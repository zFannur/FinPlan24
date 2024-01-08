import 'package:finplan24/app/app.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    required this.labelText,
    super.key,
    this.controller,
    this.obscureText = false,
    this.onChanged,
    this.onTap,
    this.keyboardType,
    this.validator,
    this.maxLines,
    this.autofocus = false,
  });

  final TextEditingController? controller;
  final String labelText;
  final bool obscureText;
  final int? maxLines;
  final bool autofocus;
  final void Function(String value)? onChanged;
  final void Function()? onTap;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      autofocus: autofocus,
      keyboardType: keyboardType,
      onChanged: onChanged,
      onTap: onTap,
      obscureText: obscureText,
      validator: validator ?? emptyValidator,
      controller: controller,
      style: AppTextStyle.bold24,
      cursorColor: AppColors.orange,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        hintText: labelText,
        hintStyle: AppTextStyle.bold24,
        fillColor: AppColors.grey,
        filled: false,
        focusColor: AppColors.orange,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.orange,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.orange,
            width: 2,
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.orange,
          ),
        ),
      ),
    );
  }

  String? emptyValidator(String? value) {
    if (value == null) {
      return 'обязательное поле';
    }
    return null;
  }
}
