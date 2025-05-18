import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'recipe_glass_card.dart';

class InstructionsSection extends StatelessWidget {
  final String instructions;

  const InstructionsSection({super.key, required this.instructions});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;
    final titleColor = theme.colorScheme.primary;

    return RecipeGlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              "Instructions",
              style: GoogleFonts.lato(
                  fontSize: 20, fontWeight: FontWeight.bold, color: titleColor),
            ),
          ),
          Text(
            instructions,
            style: GoogleFonts.lato(fontSize: 16, color: textColor),
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }
}
