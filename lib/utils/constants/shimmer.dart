import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../theme/theme_container.dart';

class ShimmerPlaceholder extends StatelessWidget {
  const ShimmerPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDarkMode = brightness == Brightness.dark;
    return Shimmer.fromColors(
      baseColor: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
      highlightColor: isDarkMode ? Colors.grey[500]! : Colors.grey[100]!,
      child: Container(color: isDarkMode ? Colors.black : Colors.white),
    );
  }
}

class HomeScreenShimmer extends StatelessWidget {
  const HomeScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDarkMode = brightness == Brightness.dark;

    // Dynamic Colors Based on Theme
    final baseColor = isDarkMode ? Colors.grey[700]! : Colors.grey[300]!;
    final highlightColor = isDarkMode ? Colors.grey[500]! : Colors.grey[100]!;
    final bgColor = isDarkMode ? Colors.black : Colors.white;

    return ThemeContainer(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _shimmerText(150, 30, baseColor, highlightColor, bgColor),
                const SizedBox(height: 8),
                _shimmerText(200, 20, baseColor, highlightColor, bgColor),
                const SizedBox(height: 16),
                _shimmerSearchBar(baseColor, highlightColor, bgColor),
                const SizedBox(height: 16),
                _shimmerCategories(baseColor, highlightColor, bgColor),
                const SizedBox(height: 20),
                _shimmerText(100, 20, baseColor, highlightColor, bgColor),
                const SizedBox(height: 10),
                _shimmerTrendingRecipes(baseColor, highlightColor, bgColor),
                const SizedBox(height: 16),
                _shimmerRecipeList(baseColor, highlightColor, bgColor),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 🔹 Search Bar Placeholder
  Widget _shimmerSearchBar(
      Color baseColor, Color highlightColor, Color bgColor) {
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: bgColor,
        ),
      ),
    );
  }

  /// 🔹 Last Recipe List Placeholder (Vertical)
  Widget _shimmerRecipeList(
      Color baseColor, Color highlightColor, Color bgColor) {
    return Column(
      children: List.generate(3, (index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Shimmer.fromColors(
            baseColor: baseColor,
            highlightColor: highlightColor,
            child: Container(
              height: 80,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: bgColor,
              ),
            ),
          ),
        );
      }),
    );
  }

  /// 🔹 Categories Placeholder
  Widget _shimmerCategories(
      Color baseColor, Color highlightColor, Color bgColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(4, (index) {
        return Column(
          children: [
            Shimmer.fromColors(
              baseColor: baseColor,
              highlightColor: highlightColor,
              child: CircleAvatar(
                radius: 35,
                backgroundColor: bgColor,
              ),
            ),
            const SizedBox(height: 4),
            _shimmerText(50, 10, baseColor, highlightColor, bgColor),
          ],
        );
      }),
    );
  }

  /// 🔹 Trending Recipes Placeholder
  Widget _shimmerTrendingRecipes(
      Color baseColor, Color highlightColor, Color bgColor) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: baseColor,
            highlightColor: highlightColor,
            child: Container(
              width: 150,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: bgColor,
              ),
            ),
          );
        },
      ),
    );
  }

  /// 🔹 Reusable Shimmer Text
  Widget _shimmerText(double width, double height, Color baseColor,
      Color highlightColor, Color bgColor) {
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        width: width,
        height: height,
        color: bgColor,
      ),
    );
  }
}
