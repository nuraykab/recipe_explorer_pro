import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/models/recipe_model.dart';
import '../../../utils/constants/shimmer.dart';
import '../../../utils/routes/app_routes.dart';

class TrendingItem extends StatelessWidget {
  final RecipeModel recipe;

  const TrendingItem({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.recipes, arguments: recipe);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl: recipe.thumbnailUrl,
                width: screen.width * 0.4,
                height: double.infinity,
                fit: BoxFit.fill,
                placeholder: (context, url) =>
                    Center(child: ShimmerPlaceholder()),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.black.withAlpha((0.35 * 255).toInt()),
                  child: Text(
                    recipe.name,
                    style: GoogleFonts.lato(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
