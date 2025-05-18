import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth_provider.dart';

class PrivacyPolicyCheckbox extends StatelessWidget {
  const PrivacyPolicyCheckbox({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          onChanged: (newValue) {
            authProvider.isChecked = newValue ?? false;
          },
          value: authProvider.isChecked,
        ),
        InkWell(
          onTap: () {},
          child: const Text(
            'I agree with the Terms and Privacy Policy',
            style: TextStyle(
              fontSize: 11.5,
            ),
          ),
        ),
      ],
    );
  }
}
