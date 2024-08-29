import 'package:flutter/material.dart';
import 'package:global_advice_new/core/utils/config_size.dart';

import 'package:global_advice_new/core/resource_manger/color_manager.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  Widget? suffix;
  TextInputType inputType;
  bool? obscureText;
  String? hint;
  Widget? prefixicon;
  String? labeltext;
  FocusNode? focusNode;
  Function(String)? onSubmitted;
  int? maxLength;

  CustomTextField(
      {super.key,
      required this.controller,
      this.suffix,
      required this.inputType,
      this.obscureText = false,
      this.hint,
      this.prefixicon,
      this.labeltext,
      this.maxLength,
      this.focusNode,
      this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: onSubmitted,
      maxLength: maxLength,
      focusNode: focusNode,
      controller: controller,
      keyboardType: inputType,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        floatingLabelStyle: const TextStyle(color: ColorManager.mainColor),
        labelText: labeltext,
        hintText: hint,
        suffixIcon: suffix,
        filled: true,
        fillColor: Colors.white,
        prefixIcon: prefixicon,
        contentPadding:
            EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize!),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            width: 1,
            color: ColorManager.mainColor,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            width: 1,
            color: ColorManager.mainColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            width: 1,
            color: ColorManager.mainColor,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            width: 1,
            color: ColorManager.mainColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            width: 1,
            color: ColorManager.mainColor,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            width: 1,
            color: ColorManager.mainColor,
          ),
        ),
      ),
      style: const TextStyle(color: Colors.black),
    );
  }
}
