import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField(
      {Key? key,
      required this.controller,
      required this.validator,
      required this.keyboardType,
      required this.hintText,
      required this.labelText,
      this.padding,
      this.action,
      this.suffixIcon,
      this.prefixIcon,
      required this.obscureText,
      this.maxLines})
      : super(key: key);

  final TextEditingController controller;
  final FormFieldValidator validator;
  final String hintText;
  final action;
  final maxLines;
  final String labelText;
  final EdgeInsetsGeometry? padding;
  final Widget? suffixIcon;
  final keyboardType;
  final Widget? prefixIcon;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      obscureText: obscureText,
      maxLines: maxLines,
      textInputAction: action,
      decoration: InputDecoration(
        contentPadding: padding,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        hintText: hintText,
        labelText: labelText,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.h),
          borderSide: BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.h),
          borderSide: BorderSide(color: Colors.grey),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.h),
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}
