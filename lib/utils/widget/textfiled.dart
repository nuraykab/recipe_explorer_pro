import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final int? maxLines;

  const CustomTextField({
    super.key,
    this.controller,
    required this.hintText,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.maxLines,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.sizeOf(context);
    return Column(
      children: [
        Container(
          // height: screen.height * 0.2,
          decoration: BoxDecoration(
            color: const Color(0x44D9D9D9),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextFormField(
            onChanged: onChanged,
            controller: controller,
            keyboardType: keyboardType,
            validator: validator,
            textInputAction: textInputAction,
            maxLines: maxLines ?? 1,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: GoogleFonts.adamina(
                textStyle: const TextStyle(
                  color: Color(0xFF666666),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                  horizontal: screen.height * 0.01,
                  vertical: screen.width * 0.01),
            ),
          ),
        ),
        SizedBox(height: screen.height * 0.01),
      ],
    );
  }
}
