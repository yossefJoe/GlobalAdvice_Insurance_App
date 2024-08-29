import 'package:flutter/material.dart';

import '../../../../../../core/resource_manger/color_manager.dart';
import '../../../../../../core/utils/config_size.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PricesNamesAndAmounts extends StatelessWidget {
  const PricesNamesAndAmounts(
      {super.key,
      required this.get_names,
      required this.get_amount,
      this.genders});
  final List<dynamic> get_names;
  final List<dynamic> get_amount;
  final List<String>? genders;

  @override
  Widget build(BuildContext context) {
    var localetype = Localizations.localeOf(context).languageCode;
    return ListView.builder(
      itemCount: get_names.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index2) {
        return Column(
          crossAxisAlignment: localetype == 'ar'
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.end,
          children: [
            ListTile(
              contentPadding: EdgeInsets.symmetric(
                vertical: ConfigSize.defaultSize! * 1,
              ),
              subtitle: Text(
                get_amount[index2].toString() +
                    ' ' +
                    AppLocalizations.of(context)!.egy_year,
                style: const TextStyle(
                  color: ColorManager.kSecondryGreenLight,
                ),
              ),
              title: Text(get_names[index2]),
              leading: Icon(
                size: ConfigSize.defaultSize! * 3,
                genders![index2] == 'male' ? Icons.person : Icons.person_3,
                color: ColorManager.kSecondryGreenLight,
              ),
            ),
          ],
        );
      },
    );
  }
}
