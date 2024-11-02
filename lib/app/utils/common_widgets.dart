import 'package:flutter/material.dart';

import 'app_constants.dart';

class CommonTextWidget extends StatelessWidget {
  final Color color;
  final String text;
  final double fontSize;
  final TextAlign align;
  final double letterSpacing;
  final FontWeight fontWeight;
  final int? maxLines;
  final double? height;
  final double? wordSpacing;
  final TextOverflow? overFlow;

  const CommonTextWidget({
    super.key,
    required this.color,
    required this.text,
    this.fontSize = 18,
    this.fontWeight = FontWeight.normal,
    this.letterSpacing = 0.5,
    this.maxLines,
    this.align = TextAlign.center,
    this.overFlow,
    this.height,
    this.wordSpacing,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      maxLines: maxLines,
      text,
      textAlign: align,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontFamily: AppConstants.fontFamily,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
        overflow: overFlow,
        wordSpacing: wordSpacing,
      ),
    );
  }
}

class ComonTextfieldWidgets extends StatelessWidget {
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool? obscureText;

  const ComonTextfieldWidgets(
      {super.key,
      this.controller,
      this.hintText,
      this.prefixIcon,
      this.suffixIcon,
      this.keyboardType,
      this.validator,
      this.onChanged,
      this.obscureText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      keyboardType: keyboardType,
      validator: validator,
      onChanged: onChanged,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        prefixIcon: prefixIcon, // Email icon as prefix
        suffixIcon: suffixIcon,

        hintText: hintText, // Placeholder text
        hintStyle: const TextStyle(
            color: Colors.black45,
            fontFamily: AppConstants.fontFamily,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50), // Border radius
          borderSide: BorderSide(
            color: Colors.grey[300] ?? Colors.grey, // black color border
            width: 1.0, // Border width
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(
            color: Colors.grey[300] ?? Colors.grey, // Grey color border when focused
            width: 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(
            color: Colors.grey[300] ?? Colors.grey, // Grey color border when enabled
            width: 1.0,
          ),
        ),
      ),
    );
  }
}
