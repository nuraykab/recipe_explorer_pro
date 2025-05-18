import 'package:flutter/material.dart';
import 'package:recipe_explorer_pro/data/models/recipe_model.dart';

import '../../../utils/http/url_launcher_service.dart';
import 'display_button.dart';

class RecipeButtons extends StatelessWidget {
  final RecipeModel recipe;

  const RecipeButtons({
    super.key,
    required this.recipe,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Column(
        children: [
          if (recipe.source != null && recipe.source!.isNotEmpty ||
              recipe.youtubeUrl.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (recipe.source != null && recipe.source!.isNotEmpty)
                  Expanded(
                    child: DisplayButton(
                      onTap: () =>
                          UrlService.launchURL(context, recipe.source!),
                      icon: Icons.link,
                      text: "Source",
                      colors: [Colors.brown.shade800, Colors.brown.shade600],
                    ),
                  ),
                if (recipe.youtubeUrl.isNotEmpty)
                  Expanded(
                    child: DisplayButton(
                      onTap: () =>
                          UrlService.launchURL(context, recipe.youtubeUrl),
                      icon: Icons.play_circle_fill,
                      text: "Watch Video",
                      colors: [Colors.red.shade800, Colors.red.shade600],
                    ),
                  ),
              ],
            ),
          if (recipe.isItMine) ...[
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: DisplayButton(
                    onTap: () => {},
                    text: "Edit Recipe",
                    colors: [Colors.blue.shade800, Colors.blue.shade600],
                  ),
                ),
                Expanded(
                  child: DisplayButton(
                    onTap: () {},
                    icon: Icons.delete,
                    text: "Delete Recipe",
                    colors: [Colors.red.shade800, Colors.red.shade600],
                  ),
                ),
              ],
            ),
          ]
        ],
      ),
    );
  }
}
