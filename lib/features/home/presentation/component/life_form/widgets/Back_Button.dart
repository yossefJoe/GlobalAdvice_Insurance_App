import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:global_advice_new/core/resource_manger/color_manager.dart';
import 'package:global_advice_new/core/resource_manger/locale_keys.g.dart';
import 'package:global_advice_new/core/utils/config_size.dart';
import 'package:global_advice_new/features/home/presentation/home_screen.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
            (route) => false,
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 0.5),
          child: Container(
            child: Center(
                child: Text(
              StringManager.back.tr(),
              style: TextStyle(
                  color: ColorManager.kSecondryGreenLight,
                  fontWeight: FontWeight.w600),
            )),
            decoration: BoxDecoration(
                border: Border.all(
                    color: ColorManager.kSecondryGreenLight, width: 2)),
            height: ConfigSize.defaultSize! * 2.5,
          ),
        ));
  }
}
