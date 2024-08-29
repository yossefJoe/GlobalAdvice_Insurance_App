import 'package:flutter/material.dart';
import 'package:global_advice_new/features/home/presentation/component/medical_form/Widgets/Prices_Names_and_amounts.dart';

import 'package:global_advice_new/core/resource_manger/color_manager.dart';
import 'package:global_advice_new/core/utils/config_size.dart';
import 'package:global_advice_new/core/widgets/vertical_space.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:global_advice_new/features/home/presentation/component/medical_form/Widgets/Health_Benifits_widget.dart';

class UpperPartOfMedicalCard extends StatelessWidget {
  UpperPartOfMedicalCard(
      {super.key,
      required this.plan_name,
      required this.total_price,
      required this.genders,
      required this.get_amount,
      required this.get_names,
      required this.get_health_limits,
      required this.get_health_benefits_names,
      required this.get_health_benefits_desc,
      required this.index});

  final List<dynamic> plan_name;
  final List<dynamic> total_price;
  final List<String> genders;
  final List<dynamic> get_amount;
  final List<dynamic> get_names;
  final List<dynamic> get_health_limits;
  final List<dynamic> get_health_benefits_names;
  final List<dynamic> get_health_benefits_desc;
  final int index;

  TextStyle label_style = TextStyle(
    fontSize: ConfigSize.defaultSize! * 2,
    fontWeight: FontWeight.bold,
    color: ColorManager.gray,
  );
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          plan_name[index].toString(),
          style: TextStyle(
            color: ColorManager.mainColor,
            fontSize: ConfigSize.defaultSize! * 3,
            fontWeight: FontWeight.w500,
          ),
        ),
        VerticalSpace(),
        Text(
          total_price[index].toString() +
              ' ' +
              AppLocalizations.of(context)!.egy_year,
          style: TextStyle(
            color: ColorManager.kSecondryGreenLight,
            fontSize: ConfigSize.defaultSize! * 2,
            fontWeight: FontWeight.w500,
          ),
        ),
        VerticalSpace(),
        PricesNamesAndAmounts(
          get_amount: get_amount,
          get_names: get_names,
          genders: genders,
        ),
        VerticalSpace(),
        Text(
          AppLocalizations.of(context)!.annuallimit,
          style: label_style,
        ),
        ListTile(
          leading: Icon(
            Icons.safety_check_outlined,
            color: ColorManager.secondaryColor,
          ),
          title: Text(
            get_health_limits.join(', '),
          ),
        ),
        VerticalSpace(),
        Text(
          AppLocalizations.of(context)!.healthbenefits,
          style: label_style,
        ),
        VerticalSpace(),
        HealthBenifitsWidget(
          get_health_benefits_desc: get_health_benefits_desc,
          get_health_benefits_names: get_health_benefits_names,
        ),
        VerticalSpace(),
      ],
    );
  }
}
