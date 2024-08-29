import 'package:flutter/material.dart';
import 'package:global_advice_new/core/widgets/snack_bar.dart';
import 'package:global_advice_new/features/home/presentation/component/car_form/pages/car_form_3.dart';
import 'package:global_advice_new/features/home/presentation/component/car_form/widgets/Motor_Dropdown_Widget.dart';
import 'package:global_advice_new/features/home/presentation/component/car_form/widgets/car_insurance_appbar.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'package:global_advice_new/core/resource_manger/asset_path.dart';
import 'package:global_advice_new/core/resource_manger/color_manager.dart';
import 'package:global_advice_new/core/utils/config_size.dart';
import 'package:global_advice_new/core/widgets/custom_text_field.dart';
import 'package:global_advice_new/core/widgets/main_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CarForm2 extends StatefulWidget {
  const CarForm2({super.key, required this.phoneNumber});
  final String phoneNumber;

  @override
  State<CarForm2> createState() => _CarForm2State();
}

class _CarForm2State extends State<CarForm2> {
  TextEditingController emailController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  FocusNode _focusNode = FocusNode();

  String? selectedValue1;
  String? selectedValue2;
  @override
  void initState() {
    emailController = TextEditingController();
    birthdayController = TextEditingController();
    _focusNode = FocusNode();

    // Disable focus
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _focusNode.unfocus();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    birthdayController.dispose();
    super.dispose();
  }

  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    DateTime currentDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
        builder: (context, child) {
          return Theme(
              data: ThemeData.light().copyWith(
                hintColor: ColorManager.gray,
                colorScheme:
                    const ColorScheme.light(primary: ColorManager.mainColor),
              ),
              child: child!);
        },
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1940, 1),
        lastDate:
            DateTime.utc(currentDate.year, currentDate.month, currentDate.day));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        String convertedDateTime =
            "${picked.year.toString()}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
        birthdayController.value = TextEditingValue(text: convertedDateTime);
        ;
      });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> genders = [
      AppLocalizations.of(context)!.male,
      AppLocalizations.of(context)!.female,
    ];
    final List<String> licensed = [
      AppLocalizations.of(context)!.licenced,
      AppLocalizations.of(context)!.unlicensed,
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CarAppbar(context),
      body: Padding(
        padding: EdgeInsets.all(ConfigSize.defaultSize! * 1.5),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: ConfigSize.defaultSize! * 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AssetsPath.logo,
                    scale: 5,
                  ),
                ],
              ),
              SizedBox(
                height: ConfigSize.defaultSize! * 2,
              ),
              CustomTextField(
                labeltext: AppLocalizations.of(context)!.email,
                prefixicon: const Icon(Icons.email_rounded),
                controller: emailController,
                inputType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: ConfigSize.defaultSize! * 2,
              ),
              CustomTextField(
                focusNode: _focusNode,
                labeltext: AppLocalizations.of(context)!.dateOfBirthday,
                prefixicon: const Icon(Icons.cake),
                controller: birthdayController,
                inputType: TextInputType.none,
                suffix: IconButton(
                    onPressed: () async {
                      await _selectDate(context);
                    },
                    icon: const Icon(Icons.calendar_today)),
              ),
              SizedBox(
                height: ConfigSize.defaultSize! * 2,
              ),
              CarDropdown(
                selectedValue: selectedValue1,
                label: AppLocalizations.of(context)!.gender,
                list: genders,
                onChanged: (String? value) {
                  setState(() {
                    selectedValue1 = value;
                  });
                },
              ),
              SizedBox(
                height: ConfigSize.defaultSize! * 2,
              ),
              CarDropdown(
                selectedValue: selectedValue2,
                label: AppLocalizations.of(context)!.licenced,
                list: licensed,
                onChanged: (String? value) {
                  setState(() {
                    selectedValue2 = value;
                  });
                },
              ),
              SizedBox(
                height: ConfigSize.defaultSize! * 2,
              ),
              CustomTextField(
                labeltext: AppLocalizations.of(context)!.marketvalue,
                prefixicon: const Icon(Icons.price_change),
                controller: priceController,
                inputType: TextInputType.number,
              ),
              SizedBox(
                height: ConfigSize.defaultSize! * 2,
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: ConfigSize.defaultSize! * 2),
                child: MainButton(
                  onTap: () {
                    if (priceController.text.isNotEmpty &&
                        emailController.text.isNotEmpty &&
                        birthdayController.text.isNotEmpty &&
                        priceController.text.isNotEmpty &&
                        selectedValue1 != null &&
                        selectedValue2 != null) {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: CarForm3(
                            phoneNumber: widget.phoneNumber,
                            price: int.parse(priceController.text),
                            is_licenced: selectedValue2 ==
                                    AppLocalizations.of(context)!.licenced
                                ? '1'
                                : '0'),
                        withNavBar: false,
                        pageTransitionAnimation: PageTransitionAnimation.fade,
                      );
                    } else {
                      errorSnackBar(context,
                          AppLocalizations.of(context)!.errorFillFields);
                    }
                  },
                  title: AppLocalizations.of(context)!.next,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
