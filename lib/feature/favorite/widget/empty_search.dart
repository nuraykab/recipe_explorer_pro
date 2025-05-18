import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final bool isFavorite;
  const EmptyState({super.key, this.isFavorite = true});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isFavorite ? Icons.favorite_border : Icons.restaurant_menu,
            size: 80,
            color: Colors.redAccent,
          ),
          const SizedBox(height: 20),
          Text(
            isFavorite ? "No Favorite Recipes Yet!" : "No Recipes Yet!",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            isFavorite
                ? "Start Adding Your Favorites!"
                : "Start Adding Your Own Recipe!",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
