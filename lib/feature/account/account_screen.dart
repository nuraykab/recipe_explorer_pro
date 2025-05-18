import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/theme_provider.dart';
import '../../providers/user_provider.dart';
import '../../utils/constants/images.dart';
import '../../utils/routes/app_routes.dart';
import '../../utils/theme/theme_container.dart';
import 'widget/version_screen.dart';
import 'widget/settings_options.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      body: ThemeContainer(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, size: 28),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const SizedBox(height: 10),
                CircleAvatar(
                  radius: 60,
                  backgroundImage: user.profile.isEmpty
                      ? AssetImage(Images.avatar)
                      : AssetImage(user.profile),
                ),
                const SizedBox(height: 10),
                Text(
                  user.name,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                SettingsOption(
                  title: "Profile",
                  icon: Icons.person,
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.profile);
                  },
                ),
                SettingsOption(
                  title: "App Theme",
                  icon: Icons.dark_mode,
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.themeScreen);
                  },
                  trailing: Switch(
                    activeColor: Colors.amberAccent,
                    value: isDarkMode,
                    onChanged: (value) => themeProvider.toggleTheme(),
                  ),
                ),
                SettingsOption(
                  title: "My Recipe",
                  icon: Icons.book,
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.myRecipe);
                  },
                ),
                SettingsOption(
                  title: "Favorite Recipe",
                  icon: Icons.favorite,
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.favorites);
                  },
                ),
                Expanded(child: VersionScreen()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
