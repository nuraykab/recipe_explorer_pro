import 'dart:developer' as developer;
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import '../data/models/category_model.dart';
import '../data/models/recipe_model.dart';
import '../utils/constants/snackbar.dart';
import '../utils/http/common_site.dart';
import '../utils/http/http_service.dart';

class RecipeProvider with ChangeNotifier {
  late Box<RecipeModel> _recipeBox;
  late Box<CategoryModel> _categoryBox;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  final List<RecipeModel> _recipes = [];
  List<RecipeModel> get recipes => _recipes;
  final List<RecipeModel> _trending = [];
  List<RecipeModel> get trending => _trending;

  List<CategoryModel> _category = [];
  List<CategoryModel> get categories => _category;

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  List<RecipeModel> _filteredRecipes = [];
  List<RecipeModel> get filteredRecipes =>
      _searchQuery.isEmpty ? _recipes : _filteredRecipes;

  List<RecipeModel> _filteredFavoriteRecipes = [];
  List<RecipeModel> get filteredFavoriteRecipes => _searchQuery.isEmpty
      ? _recipes.where((recipe) => recipe.isFavorite).toList()
      : _filteredFavoriteRecipes;

  RecipeProvider() {
    _initializeHive();
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> _initializeHive() async {
    isLoading = true;
    notifyListeners();
    _recipeBox = await Hive.openBox<RecipeModel>('recipes');
    _categoryBox = await Hive.openBox<CategoryModel>('categories');
    isLoading = false;
    await fetchAll();
    notifyListeners();
  }

  Future<void> fetchAll() async {
    if (_categoryBox.isEmpty) {
      await fetchRecipesCategories();
    } else {
      _category = _categoryBox.values.toList();
      _recipes.addAll(_recipeBox.values);
      if (_recipeBox.length < 250) await fetchRecipesCategories();
      _selectTrendingRecipes();
    }
    notifyListeners();
  }

  Future<void> fetchRecipesCategories() async {
    try {
      final value = await HttpService.getRequest(Site.allCategories(), false);
      final List<dynamic>? categoriesJson = value['categories'];
      if (categoriesJson != null) {
        _category.addAll(
          categoriesJson
              .map((json) => CategoryModel.fromJson(json))
              .where((category) => !_categoryBox.values.any(
                  (existingCategory) => existingCategory.id == category.id))
              .toList(),
        );

        for (var category in _category) {
          _categoryBox.put(category.id, category);
        }
        for (var category in _category) {
          await fetchRecipesByCategory(category.name);
        }
      }
      notifyListeners();
    } catch (e) {
      developer.log('Error fetching categories: $e');
    }
  }

  Future<void> fetchRecipesByCategory(String category) async {
    await fetchRecipesBySearch(category);
    await fetchRecipesSeafood(category);
  }

  Future<void> fetchRecipesSeafood(String query) async {
    if (query.isEmpty) return;
    try {
      final value =
          await HttpService.getRequest(Site.filterByCategory(query), false);
      final List<dynamic>? mealsJson = value['meals'];
      if (mealsJson != null) {
        for (var json in mealsJson) {
          await fetchRecipeById(json['idMeal']);
        }
      } else {
        developer.log('No data found');
      }
      notifyListeners();
    } catch (e) {
      developer.log('Error fetching seafood recipes: $e');
    }
  }

  Future<void> fetchRecipeById(String id) async {
    if (_recipes.any((element) => element.id == id)) return;
    try {
      final value =
          await HttpService.getRequest(Site.lookupMealById(id), false);
      if (value['meals'] != null) {
        RecipeModel recipe = RecipeModel.fromJson(value['meals'].first ?? {});
        if (!_recipes.any((element) => element.id == recipe.id)) {
          _recipes.add(recipe);
          _recipeBox.put(recipe.id, recipe);
        }
      }
      notifyListeners();
    } catch (e) {
      developer.log('Error fetching recipe by ID: $e');
    }
  }

  void searchRecipes(String query) {
    _searchQuery = query;
    fetchRecipesBySearch(query);
    if (query.isEmpty) {
      _filteredRecipes = [];
    } else {
      _filteredRecipes = _recipes
          .where((recipe) =>
              recipe.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void searchFavoriteRecipe(String query) {
    _searchQuery = query;
    if (query.isEmpty) {
      _filteredFavoriteRecipes =
          _recipes.where((recipe) => recipe.isFavorite).toList();
    } else {
      _filteredFavoriteRecipes = _recipes
          .where((recipe) =>
              recipe.isFavorite &&
              recipe.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  Future<void> fetchRecipesBySearch(String query) async {
    if (query.isEmpty) return;
    try {
      final value =
          await HttpService.getRequest(Site.searchMealByName(query), false);
      final List<dynamic>? mealsJson = value['meals'];
      if (mealsJson != null) {
        for (var json in mealsJson) {
          RecipeModel recipe = RecipeModel.fromJson(json);
          if (!_recipes.any((element) => element.id == recipe.id)) {
            _recipes.add(recipe);
            _recipeBox.put(recipe.id, recipe);
          }
        }
      } else {
        developer.log('No data found');
      }
      notifyListeners();
    } catch (e) {
      developer.log('Error fetching recipes by search: $e');
    }
  }

  void toggleFavorite(String id) {
    final recipeIndex = _recipes.indexWhere((recipe) => recipe.id == id);
    if (recipeIndex != -1) {
      _recipes[recipeIndex] = RecipeModel(
        id: _recipes[recipeIndex].id,
        name: _recipes[recipeIndex].name,
        category: _recipes[recipeIndex].category,
        area: _recipes[recipeIndex].area,
        instructions: _recipes[recipeIndex].instructions,
        thumbnailUrl: _recipes[recipeIndex].thumbnailUrl,
        youtubeUrl: _recipes[recipeIndex].youtubeUrl,
        ingredients: _recipes[recipeIndex].ingredients,
        measurements: _recipes[recipeIndex].measurements,
        source: _recipes[recipeIndex].source,
        isFavorite: !_recipes[recipeIndex].isFavorite,
        isItMine: _recipes[recipeIndex].isItMine,
      );
      _recipeBox.put(id, _recipes[recipeIndex]);
      if (_recipes[recipeIndex].isFavorite) {
        _filteredFavoriteRecipes.add(_recipes[recipeIndex]);
      } else {
        _filteredFavoriteRecipes.removeWhere((recipe) => recipe.id == id);
      }
      notifyListeners();
    }
  }

  bool isFavorite(String id) {
    final recipe = _recipes.firstWhere((recipe) => recipe.id == id);
    return recipe.isFavorite;
  }

  /// Select 10 random recipes for trending. If empty, retry after 2 seconds.
  void _selectTrendingRecipes() {
    if (_recipeBox.isNotEmpty) {
      final random = Random();
      final allRecipes = _recipeBox.values.toList();
      _trending.clear();

      /// Shuffle the list and pick 10 random items
      _trending.addAll(
        allRecipes..shuffle(random),
      );
      _trending.length = min(10, _trending.length); // Ensure max 10 items

      notifyListeners();
    } else {
      /// Retry after 2 seconds if no data
      Future.delayed(const Duration(seconds: 2), () {
        _selectTrendingRecipes();
      });
    }
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController instructionsController = TextEditingController();
  final TextEditingController thumbnailUrlController = TextEditingController();
  final TextEditingController youtubeUrlController = TextEditingController();
  TextEditingController get imageController => thumbnailUrlController;

  void updateImageController() {
    notifyListeners();
  }

  Future<void> addRecipe(BuildContext context) async {
    try {
      if (nameController.text.isEmpty ||
          categoryController.text.isEmpty ||
          areaController.text.isEmpty ||
          instructionsController.text.isEmpty ||
          thumbnailUrlController.text.isEmpty ||
          ingredientControllers.any((controller) => controller.text.isEmpty) ||
          measurementControllers.any((controller) => controller.text.isEmpty)) {
        MySnackbar.showError(context, 'Please fill all the fields');
        return;
      }
      var recipe = RecipeModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          name: nameController.text,
          category: categoryController.text,
          area: areaController.text,
          instructions: instructionsController.text,
          thumbnailUrl: thumbnailUrlController.text,
          youtubeUrl: youtubeUrlController.text,
          ingredients: ingredientControllers
              .map((controller) => controller.text)
              .toList(),
          measurements: measurementControllers
              .map((controller) => controller.text)
              .toList(),
          source: '',
          isFavorite: false,
          isItMine: true);
      developer.log(recipe.name);
      if (!_recipes.any((element) => element.id == recipe.id)) {
        developer.log('message');
        _recipes.add(recipe);
        await _recipeBox.put(recipe.id, recipe);
        notifyListeners();
      } else {
        developer.log('Recipe with id ${recipe.id} already exists.');
      }
      clearFields();
    } catch (e) {
      developer.log('Error adding recipe: $e');
    }
    notifyListeners();
  }

  final List<TextEditingController> _ingredientControllers = [];
  final List<TextEditingController> _measurementControllers = [];

  List<TextEditingController> get ingredientControllers =>
      _ingredientControllers;
  List<TextEditingController> get measurementControllers =>
      _measurementControllers;
  int get ingredientsCount => _ingredientControllers.length;

  // Add a new ingredient and measurement field
  void addIngredient() {
    ingredientControllers.add(TextEditingController());
    measurementControllers.add(TextEditingController());
    notifyListeners();
  }

  // Remove an ingredient and measurement field
  void removeIngredient(int index) {
    if (ingredientControllers.length > 1) {
      ingredientControllers[index].dispose();
      measurementControllers[index].dispose();
      ingredientControllers.removeAt(index);
      measurementControllers.removeAt(index);
      notifyListeners();
    }
  }

  // Delete a recipe by ID
  Future<void> deleteRecipe(String id, BuildContext context) async {
    try {
      _recipes.removeWhere((recipe) => recipe.id == id);
      await _recipeBox.delete(id);
      if (context.mounted) {
        Navigator.of(context).pop();
      }
      notifyListeners();
    } catch (e) {
      developer.log('Error deleting recipe: $e');
    }
  }

  // Edit a recipe by ID
  Future<void> editRecipe(String id, RecipeModel updatedRecipe) async {
    try {
      final recipeIndex = _recipes.indexWhere((recipe) => recipe.id == id);
      if (recipeIndex != -1) {
        _recipes[recipeIndex] = updatedRecipe;
        await _recipeBox.put(id, updatedRecipe);
        notifyListeners();
      }
    } catch (e) {
      developer.log('Error editing recipe: $e');
    }
  }

  // Clear all controllers when recipe is saved
  void clearFields() {
    nameController.clear();
    categoryController.clear();
    areaController.clear();
    instructionsController.clear();
    thumbnailUrlController.clear();
    youtubeUrlController.clear();

    for (var controller in ingredientControllers) {
      controller.dispose();
    }
    for (var controller in measurementControllers) {
      controller.dispose();
    }

    ingredientControllers.clear();
    measurementControllers.clear();
    addIngredient(); // Reset with one ingredient field
    notifyListeners();
  }

  @override
  void dispose() {
    // Dispose all controllers to free memory
    nameController.dispose();
    categoryController.dispose();
    areaController.dispose();
    instructionsController.dispose();
    thumbnailUrlController.dispose();
    youtubeUrlController.dispose();

    for (var controller in ingredientControllers) {
      controller.dispose();
    }
    for (var controller in measurementControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
