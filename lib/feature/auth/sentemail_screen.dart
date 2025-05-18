import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth_provider.dart';
import '../../utils/routes/app_routes.dart';
import '../../utils/widget/button.dart';

class PasswordResetEmailScreen extends StatelessWidget {
  const PasswordResetEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: width > 600 ? 600 : width,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Password Reset Email Sent',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Spacer(),
                    const Text(
                      "Your account security is our priority! We've sent you a secure link to safely change your password and keep your account protected.",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Spacer(),
                    Button().mainButton(
                      'Done',
                      context,
                      () => Navigator.pushNamed(context, AppRoutes.login),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        authProvider.requestEmailVerification(context);
                      },
                      child: const Text(
                        'Resend Email',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
