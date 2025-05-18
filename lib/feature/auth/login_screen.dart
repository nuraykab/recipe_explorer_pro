import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:recipe_explorer_pro/feature/auth/signup_screen.dart';
import '../../utils/animations/animated_login_button.dart';
import '../../providers/auth_provider.dart';
import '../../utils/constants/images.dart';
import '../../utils/routes/app_routes.dart';
import '../../utils/validators/validator.dart';
import '../../utils/widget/button.dart';
import '../../utils/animations/animated_card.dart';
import '../../utils/widget/textfield.dart';
import 'widget/intro_appbar.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    if (authProvider.isLoading) {
      return Scaffold(
        body: Center(
          child: Lottie.asset('assets/lottie/loading.json', width: 150),
        ),
      );
    }

    return KeyboardDismissOnTap(
      child: Scaffold(
        appBar: const IntroAppbar(
          actions: [],
          titleText: 'Log in',
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: height * 0.3,
                  width: width,
                  child: Center(
                    child: Image.asset(Images.signin, height: height * 0.25),
                  ),
                ),

                // Email TextField
                MyTextField(
                  textInputAction: TextInputAction.next,
                  controller: authProvider.emailTextEditingController,
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => InputValidators.validateEmail(value),
                ),

                // Password TextField
                PasswordTextField(
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.visiblePassword,
                  controller: authProvider.passwordTextEditingController,
                ),

                SizedBox(height: height * 0.06),

                // Forget password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRoutes.emailVerification),
                    child: const Text("Forget password?"),
                  ),
                ),

                // Login Button
                AnimatedLoginButton(
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    authProvider.signIn(context);
                  },
                ),


                SizedBox(height: height * 0.05),

                // Social login buttons
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton.icon(
                      icon: Image.asset(
                        'assets/icons/google_icon.png', // Добавь иконку Google в assets
                        height: 24,
                        width: 24,
                      ),
                      label: const Text('Sign in with Google'),
                      onPressed: () => authProvider.signInWithGoogle(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black87,
                        minimumSize: Size(double.infinity, 48),
                        side: BorderSide(color: Colors.grey.shade400),
                      ),

                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      icon: Image.asset(
                        'assets/icons/facebook_icon.png', // Добавь иконку Facebook в assets
                        height: 24,
                        width: 24,
                      ),
                      label: const Text('Sign in with Facebook'),
                      onPressed: () => authProvider.signInWithFacebook(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black87,
                        minimumSize: Size(double.infinity, 48),
                        side: BorderSide(color: Colors.grey.shade400),
                      ),

                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      icon: Icon(Icons.code, size: 24),
                      label: const Text('Sign in with GitHub'),
                      onPressed: () => authProvider.signInWithGitHub(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black87,
                        minimumSize: Size(double.infinity, 48),
                        side: BorderSide(color: Colors.grey.shade400),
                      ),

                    ),
                  ],
                ),

                SizedBox(height: height * 0.1),

                // Sign up redirect
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don’t have an account? '),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => SignupScreen(),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              return SlideTransition(
                                position: animation.drive(
                                  Tween(begin: Offset(1.0, 0.0), end: Offset.zero).chain(CurveTween(curve: Curves.ease)),
                                ),
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                      child: const Text('Sign up'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
