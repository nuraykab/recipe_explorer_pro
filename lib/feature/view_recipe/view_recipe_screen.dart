import 'package:flutter/material.dart';

import '../../data/models/recipe_model.dart';
import 'widget/source_button.dart';
import 'widget/background_gradient.dart';
import 'widget/category_and_tags.dart';
import 'widget/ingredients_section.dart';
import 'widget/instructions_section.dart';
import 'widget/recipe_image_header.dart';
import 'widget/title_section.dart';

class ViewRecipeScreen extends StatelessWidget {
  final RecipeModel recipe;

  const ViewRecipeScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundGradient(),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RecipeImageHeader(recipe: recipe),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleSection(recipe: recipe),
                      CategoryAndTags(
                          category: recipe.category, tags: recipe.area),
                      const SizedBox(height: 15),
                      IngredientsSection(recipe: recipe),
                      const SizedBox(height: 15),
                      InstructionsSection(instructions: recipe.instructions),
                      const SizedBox(height: 15),
                      RecipeButtons(recipe: recipe),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
