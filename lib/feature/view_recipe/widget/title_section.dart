import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../data/models/recipe_model.dart';
import '../../../providers/recipe_provider.dart';

class TitleSection extends StatelessWidget {
  final RecipeModel recipe;

  const TitleSection({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            recipe.name,
            style: GoogleFonts.lato(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.fade,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Consumer<RecipeProvider>(
            builder: (context, recipeProvider, child) {
              final isFavorite = recipeProvider.isFavorite(recipe.id);
              return IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: isFavorite ? Colors.red : theme.iconTheme.color,
                  size: 30,
                ),
                onPressed: () => recipeProvider.toggleFavorite(recipe.id),
              );
            },
          ),
        ),
      ],
    );
  }
}
