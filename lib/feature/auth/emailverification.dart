import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth_provider.dart';
import '../../utils/validators/validator.dart';
import '../../utils/widget/back_button.dart';
import '../../utils/widget/button.dart';
import '../../utils/widget/textfield.dart';
import 'widget/intro_appbar.dart';

class EmailVerifiScreen extends StatelessWidget {
  const EmailVerifiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: IntroAppbar(
        leading: MyBackButton(),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Forgot Password',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "Don't worry, it happens! Enter your email below, and we'll send you a password reset link.",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      MyTextField(
                        textInputAction: TextInputAction.next,
                        controller: authProvider.emailTextEditingController,
                        hintText: "example@gmail.com",
                        labelText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) =>
                            InputValidators.validateEmail(value),
                      ),
                      const SizedBox(height: 32),
                      Button().mainButton(
                        'Send Reset Link',
                        context,
                        () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          authProvider.requestEmailVerification(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
