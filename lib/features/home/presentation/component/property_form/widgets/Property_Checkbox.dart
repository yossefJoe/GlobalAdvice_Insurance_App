import 'package:flutter/material.dart';
import 'package:global_advice_new/core/resource_manger/color_manager.dart';

class PropertyCheckbox extends StatelessWidget {
  PropertyCheckbox(
      {super.key, this.onChanged, required this.value, this.title});
  final Function(bool?)? onChanged;
  final bool value;
  final String? title;

  @override
  Widget build(BuildContext context) {
    var localetype = Localizations.localeOf(context).languageCode;
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      value: value,
      onChanged: onChanged,
      activeColor: ColorManager.mainColor,
      checkColor: ColorManager.whiteColor,
      title: Text(
        textAlign: localetype == 'ar' ? TextAlign.right : TextAlign.left,
        title!,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
