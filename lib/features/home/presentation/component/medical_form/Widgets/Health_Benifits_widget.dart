import 'package:flutter/material.dart';

import '../../../../../../core/resource_manger/color_manager.dart';
import '../../../../../../core/utils/config_size.dart';

class HealthBenifitsWidget extends StatelessWidget {
  const HealthBenifitsWidget(
      {super.key,
      required this.get_health_benefits_names,
      required this.get_health_benefits_desc});
  final List<dynamic> get_health_benefits_names;
  final List<dynamic> get_health_benefits_desc;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: get_health_benefits_names.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index3) {
        return ListTile(
          contentPadding: EdgeInsets.symmetric(
            vertical: ConfigSize.defaultSize! * 1,
          ),
          subtitle: Text(
            get_health_benefits_desc[index3],
          ),
          title: Text(
            get_health_benefits_names[index3],
            style: TextStyle(
              fontSize: ConfigSize.defaultSize! * 1.5,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: const Icon(
            Icons.health_and_safety_outlined,
            color: ColorManager.kSecondryGreenLight,
          ),
        );
      },
    );
  }
}
