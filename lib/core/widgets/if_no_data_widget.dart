import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../utils/config_size.dart';

class IfNoDataWidget extends StatelessWidget {
  const IfNoDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        AppLocalizations.of(context)!.noOffersAvailable,
        style: TextStyle(
          fontSize: ConfigSize.defaultSize! * 2.5,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
