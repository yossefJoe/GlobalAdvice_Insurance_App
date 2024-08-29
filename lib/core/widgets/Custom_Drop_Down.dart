import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:global_advice_new/core/utils/config_size.dart';

class CustomDropDown extends StatefulWidget {
  const CustomDropDown(
      {super.key,
      this.myvalue,
      required this.DefaultList,
      required this.onchanged,
      this.labeltext});
  final String? myvalue;
  final List<String> DefaultList;
  final Function(String?) onchanged;
  final String? labeltext;

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  @override
  Widget build(BuildContext context) {
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
          items:
              widget.DefaultList.map((String item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  )).toList(),
          value: widget.myvalue,
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
