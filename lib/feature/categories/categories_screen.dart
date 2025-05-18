import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/category_model.dart';
import '../../providers/recipe_provider.dart';
import '../home/widget/recipe_item.dart';
import '../home/widget/trending_item.dart';
import 'widget/categories_head.dart';

class CategoriesScreen extends StatelessWidget {
  final CategoryModel category;
  const CategoriesScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<RecipeProvider>(context);
    final recipes = recipeProvider.recipes
        .where((element) => element.category == category.name)
        .toList();
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Section
            CategoriesHead(category: category),
            const SizedBox(height: 16),

            // Horizontal List (Popular Categories)
            if (recipes.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                child: SizedBox(
                  height: 180,
                  child: ListView.builder(
                    itemCount: recipes.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final recipe = recipes[recipes.length - 1 - index];
                      return TrendingItem(recipe: recipe);
                    },
                  ),
                ),
              ),

            // Vertical List (Category Items)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
              child: ListView.builder(
                controller: ScrollController(),
                itemCount: recipes.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final recipe = recipes[index];
                  return RecipeItem(recipe: recipe);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
