import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_explorer_pro/providers/recipe_provider.dart';
import '../../providers/theme_provider.dart';
import '../../utils/theme/theme_container.dart';
import '../../utils/widget/textfiled.dart';
import 'image_display_widget.dart';

class AddOwnRecipeScreen extends StatelessWidget {
  const AddOwnRecipeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<RecipeProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      body: ThemeContainer(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, size: 28),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Spacer(),
                    const Text(
                      'Add Your Own Recipe',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Spacer(),
                  ],
                ),
                const SizedBox(height: 16.0),
                ImageDisplayWidget(),
                CustomTextField(
                  controller: recipeProvider.thumbnailUrlController,
                  onChanged: (value) => recipeProvider.updateImageController(),
                  hintText: 'Thumbnail URL',
                ),
                CustomTextField(
                  controller: recipeProvider.nameController,
                  hintText: 'Recipe Name',
                ),
                CustomTextField(
                  controller: recipeProvider.categoryController,
                  hintText: 'Category',
                ),
                CustomTextField(
                  controller: recipeProvider.areaController,
                  hintText: 'Area',
                ),
                CustomTextField(
                  controller: recipeProvider.instructionsController,
                  hintText: 'Instructions',
                  maxLines: 5,
                ),
                CustomTextField(
                  controller: recipeProvider.youtubeUrlController,
                  hintText: 'YouTube URL',
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Ingredients and Measurements',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: recipeProvider.ingredientControllers.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              controller:
                                  recipeProvider.ingredientControllers[index],
                              hintText: 'Ingredient',
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: CustomTextField(
                              controller:
                                  recipeProvider.measurementControllers[index],
                              hintText: 'Measurement',
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.remove_circle,
                                color: Colors.red),
                            onPressed: () =>
                                recipeProvider.removeIngredient(index),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                TextButton.icon(
                  onPressed: recipeProvider.addIngredient,
                  icon: const Icon(Icons.add),
                  label: const Text('Add Ingredient'),
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => recipeProvider.addRecipe(context),
                    child: const Text('Save Recipe'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
