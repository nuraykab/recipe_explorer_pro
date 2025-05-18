import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryAndTags extends StatelessWidget {
  final String category;
  final String tags;

  const CategoryAndTags(
      {super.key, required this.category, required this.tags});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildTag(context, "Category: $category"),
          const SizedBox(width: 10),
          _buildTag(context, "Tags: $tags"),
        ],
      ),
    );
  }

  Widget _buildTag(BuildContext context, String text) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: GoogleFonts.lato(fontSize: 14),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
