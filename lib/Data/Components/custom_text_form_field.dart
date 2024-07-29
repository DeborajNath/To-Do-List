import 'package:flutter/material.dart';
import 'package:task_management/Data/Constants/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String? Function(String?)? validator;
  final String labelText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final bool obscureText;
  final bool? enabled;
  final int? maxLines;
  final bool? readOnly;
  final bool? alignLabelWithHint;
  const CustomTextFormField({
    super.key,
    this.validator,
    required this.labelText,
    this.suffixIcon,
    this.prefixIcon,
    this.controller,
    this.obscureText = false,
    this.maxLines,
    this.enabled,
    this.readOnly,
    this.alignLabelWithHint,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      maxLines: maxLines ?? 1,
      enabled: enabled ?? true,
      readOnly: readOnly ?? false,
      decoration: InputDecoration(
        alignLabelWithHint: alignLabelWithHint ?? true,
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: blue,
            width: 1.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: red,
            width: 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: blue,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: blue,
            width: 1.0,
          ),
        ),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
      ),
      validator: validator,
    );
  }
}
