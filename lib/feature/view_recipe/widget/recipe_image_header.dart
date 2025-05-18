import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../data/models/recipe_model.dart';
import '../../../utils/constants/shimmer.dart';

class RecipeImageHeader extends StatelessWidget {
  final RecipeModel recipe;

  const RecipeImageHeader({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Hero(
          tag: recipe.thumbnailUrl,
          child: ClipRRect(
            borderRadius:
                const BorderRadius.vertical(bottom: Radius.circular(30)),
            child: CachedNetworkImage(
              imageUrl: recipe.thumbnailUrl,
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.45,
              fit: BoxFit.fill,
              placeholder: (context, url) =>
                  Center(child: ShimmerPlaceholder()),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: CircleAvatar(
              backgroundColor: Colors.black.withAlpha((0.5 * 255).toInt()),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
