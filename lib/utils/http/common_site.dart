class Site {
  static const String _baseUrl = 'https://www.themealdb.com/api/json/v1/1';

  /// Search meal by name
  static String searchMealByName(String mealName) =>
      '$_baseUrl/search.php?s=$mealName';

  /// List all meals by first letter
  static String listMealsByFirstLetter(String letter) =>
      '$_baseUrl/search.php?f=$letter';

  /// Lookup full meal details by ID
  static String lookupMealById(String id) => '$_baseUrl/lookup.php?i=$id';

  /// Lookup a single random meal
  static String randomMeal() => '$_baseUrl/random.php';

  /// List all meal categories
  static String allCategories() => '$_baseUrl/categories.php';

  /// List all categories
  static String listAllCategories() => '$_baseUrl/list.php?c=list';

  /// List all areas
  static String listAllAreas() => '$_baseUrl/list.php?a=list';

  /// List all ingredients
  static String listAllIngredients() => '$_baseUrl/list.php?i=list';

  /// Filter by main ingredient
  static String filterByMainIngredient(String ingredient) =>
      '$_baseUrl/filter.php?i=$ingredient';

  /// Filter by category
  static String filterByCategory(String category) =>
      '$_baseUrl/filter.php?c=$category';

  /// Filter by area
  static String filterByArea(String area) => '$_baseUrl/filter.php?a=$area';

  /// Get meal thumbnail image URL
  static String mealThumbnail(String imageName) =>
      'https://www.themealdb.com/images/media/meals/$imageName';

  /// Get ingredient thumbnail image URL
  static String ingredientThumbnail(String ingredientName) =>
      'https://www.themealdb.com/images/ingredients/$ingredientName.png';

  /// Get small ingredient thumbnail image URL
  static String smallIngredientThumbnail(String ingredientName) =>
      'https://www.themealdb.com/images/ingredients/$ingredientName-Small.png';
}
