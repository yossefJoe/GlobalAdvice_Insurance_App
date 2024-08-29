import 'package:flutter/material.dart';

import '../utils/config_size.dart';

class UpperPageTitle extends StatelessWidget {
  const UpperPageTitle({super.key, this.title});
  final String? title;
  @override
  Widget build(BuildContext context) {
    var localetype = Localizations.localeOf(context).languageCode;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        Text(
          title!,
          style: TextStyle(
            fontSize: localetype == 'ar'
                ? ConfigSize.defaultSize! * 3
                : ConfigSize.defaultSize! * 2.25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
