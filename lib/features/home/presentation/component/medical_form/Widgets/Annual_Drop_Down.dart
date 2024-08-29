import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:global_advice_new/core/resource_manger/color_manager.dart';
import 'package:global_advice_new/core/utils/config_size.dart';
import 'package:global_advice_new/features/home/data/model/health_dependinces_model.dart';

class AnnualLimitDropDown extends StatefulWidget {
  const AnnualLimitDropDown({
    super.key,
    this.myvalue,
    required this.onchanged,
    this.labeltext,
    required this.map_value,
    required this.mylist,
  });
  final String? myvalue;
  final Function(String?) onchanged;
  final String? labeltext;
  final String map_value;
  final List<HealthDependincesModel> mylist;

  @override
  State<AnnualLimitDropDown> createState() => _AnnualLimitDropDownState();
}

class _AnnualLimitDropDownState extends State<AnnualLimitDropDown> {
  @override
  Widget build(BuildContext context) {
    var localetype = Localizations.localeOf(context).languageCode;
    List<DropdownMenuItem<String>> dropdownItems = widget.mylist
        .where((element) => element.id == widget.map_value)
        .expand((item) {
      // Extract `id` and `name` to be used as values and labels
      return item.plansDataValues!.map((e) {
        return DropdownMenuItem<String>(
          value: e.id.toString(), // Ensure value is not null
          child: Text(
            localetype == 'en'
                ? e.name?.toUpperCase() ?? 'Unknown'
                : e.nameAlt?.toUpperCase() ?? 'Unknown',
            style: TextStyle(
              fontSize: ConfigSize.defaultSize! * 1.6,
              fontWeight: FontWeight.bold,
              color: ColorManager.mainColor,
            ),
          ),
        );
      }).toList();
    }).toList();

    return Center(
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: Text(
            widget.labeltext!,
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).hintColor,
            ),
          ),
          items: dropdownItems,
          value: widget.myvalue, // Set this to the currently selected value
          onChanged: widget.onchanged,
          buttonStyleData: ButtonStyleData(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300, width: 1),
            ),
            padding:
                EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize! * 1.6),
            height: ConfigSize.defaultSize! * 5.5,
            width: ConfigSize.screenWidth,
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
          ),
        ),
      ),
    );
  }
}
