import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/theme_provider.dart';

class MyBackButton extends StatelessWidget {
  const MyBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.pop(context),
      icon: Icon(
        Theme.of(context).platform == TargetPlatform.iOS
            ? Icons.arrow_back_ios_new
            : Icons.arrow_back,
        color: Provider.of<ThemeProvider>(context).isDarkMode
            ? Colors.white
            : Colors.black,
      ),
      tooltip: 'Back',
      splashColor: Colors.white24,
      highlightColor: Colors.white10,
    );
  }
}
