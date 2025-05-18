import 'package:flutter/material.dart';

class AnimatedLoginButton extends StatefulWidget {
  final VoidCallback onTap;
  const AnimatedLoginButton({super.key, required this.onTap});

  @override
  State<AnimatedLoginButton> createState() => _AnimatedLoginButtonState();
}

class _AnimatedLoginButtonState extends State<AnimatedLoginButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: _pressed ? 320 : 340,
        height: 50,
        decoration: BoxDecoration(
          color: _pressed ? Colors.blue[700] : Colors.blue,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: const Text(
          'Log in',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
