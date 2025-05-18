import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/recipe_provider.dart';
import '../../utils/theme/theme_container.dart';
import 'widget/empty_search.dart';
import 'widget/fav_recipe_card.dart';
import 'widget/fav_search_filed.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeProvider>(
      builder: (context, provider, child) {
        final filteredRecipes = provider.filteredFavoriteRecipes;

        return Scaffold(
          body: ThemeContainer(
            child: SafeArea(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, size: 28),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Spacer(),
                      Text(
                        "Favorite Recipes",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Spacer(),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child:
                        SearchField(onChanged: provider.searchFavoriteRecipe),
                  ),
                  Expanded(
                    child: filteredRecipes.isEmpty
                        ? EmptyState()
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            itemCount: filteredRecipes.length,
                            itemBuilder: (context, index) {
                              final recipe = filteredRecipes[index];
                              return RecipeCard(
                                recipe: recipe,
                                onFavoriteToggle: () =>
                                    provider.toggleFavorite(recipe.id),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
