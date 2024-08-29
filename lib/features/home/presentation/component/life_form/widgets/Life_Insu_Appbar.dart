import 'package:flutter/material.dart';

import 'package:global_advice_new/core/resource_manger/color_manager.dart';
import 'package:global_advice_new/core/utils/config_size.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LifeAppbar extends AppBar {
  LifeAppbar(BuildContext context)
      : super(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: ColorManager.mainColor,
            ),
          ),
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context)!.lifeinsurance,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: ConfigSize.defaultSize! * 2,
            ),
          ),
        );
}
