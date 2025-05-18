import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/user_provider.dart';
import '../../utils/constants/images.dart';
import '../../utils/routes/app_routes.dart';
import '../../utils/theme/theme_container.dart';
import 'widget/profile_info_row.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.white;
    final secondaryTextColor =
        theme.textTheme.bodyMedium?.color ?? Colors.white70;
    final backgroundColor = theme.scaffoldBackgroundColor;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 26, color: textColor),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          "Profile",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
      body: ThemeContainer(
        child: Stack(
          children: [
            SafeArea(
              child: Column(
                children: [
                  SizedBox(height: 20),

                  // Profile Picture
                  Center(
                    child: Hero(
                      tag: "profile_picture",
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: theme.colorScheme.surface,
                        backgroundImage: user.profile.isEmpty
                            ? AssetImage(Images.avatar)
                            : AssetImage(user.profile),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Name & Email
                  Text(
                    user.name,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  Text(
                    user.email,
                    style: TextStyle(
                      fontSize: 16,
                      color: secondaryTextColor,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Glassmorphism Profile Details
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: theme.colorScheme.surface
                            .withAlpha((0.1 * 255).toInt()),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: theme.colorScheme.surface
                              .withAlpha((0.2 * 255).toInt()),
                        )),
                    child: Column(
                      children: [
                        ProfileInfoRow(title: "Phone", value: user.number),
                        ProfileInfoRow(title: "Email", value: user.email),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Buttons
                  const SizedBox(height: 10),

                  _glassButton(
                    icon: Icons.edit,
                    label: "Edit Profile",
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRoutes.editProfile),
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 10),
                  _glassButton(
                    icon: Icons.logout,
                    label: "Logout",
                    onPressed: () {
                      // Logout
                      Provider.of<AuthProvider>(context, listen: false)
                          .signOut(context);
                    },
                    color: Colors.red,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Reusable Glassmorphism Button
  Widget _glassButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 30),
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: color.withAlpha((0.8 * 255).toInt()),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: color.withAlpha((0.8 * 255).toInt()),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 22),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
