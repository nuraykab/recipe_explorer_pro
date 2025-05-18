import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/recipe_provider.dart';

class ImageDisplayWidget extends StatelessWidget {
  const ImageDisplayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<RecipeProvider>(context);
    final height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        height: height * 0.3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.grey),
        ),
        child: Center(
          child: recipeProvider.thumbnailUrlController.text.isNotEmpty
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.network(
                    recipeProvider.thumbnailUrlController.text,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error,
                            color: Colors.red.shade400,
                            size: 60,
                          ),
                          const SizedBox(height: 12.0),
                          Text(
                            'Failed to load image',
                            style: TextStyle(
                              color: Colors.red.shade600,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            'Please check the URL and try again',
                            style: TextStyle(
                              color: Colors.red.shade500,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    // Focus on the thumbnail URL text field
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_a_photo,
                        color: Colors.grey.shade400,
                        size: 60,
                      ),
                      const SizedBox(height: 12.0),
                      Text(
                        'No Image Available',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Add thumbnail URL to display image',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 14,
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
