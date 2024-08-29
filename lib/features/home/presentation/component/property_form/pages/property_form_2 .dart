import 'package:flutter/material.dart';
import 'package:global_advice_new/core/widgets/snack_bar.dart';
import 'package:global_advice_new/features/home/presentation/component/car_form/widgets/Motor_Dropdown_Widget.dart';
import 'package:global_advice_new/features/home/presentation/component/property_form/pages/property_form_3%20.dart';
import 'package:global_advice_new/features/home/presentation/component/property_form/widgets/Prop_insurance_appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:global_advice_new/core/resource_manger/asset_path.dart';
import 'package:global_advice_new/core/utils/config_size.dart';
import 'package:global_advice_new/core/widgets/custom_text_field.dart';
import 'package:global_advice_new/core/widgets/main_button.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class PropertyForm2 extends StatefulWidget {
  const PropertyForm2(
      {super.key, required this.fullName, required this.phone_number});
  final String fullName;
  final String phone_number;

  @override
  State<PropertyForm2> createState() => _PropertyForm2State();
}

class _PropertyForm2State extends State<PropertyForm2> {
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController contentPriceController = TextEditingController();
  TextEditingController buildingPriceController = TextEditingController();
  TextEditingController tenantPriceController = TextEditingController();

  String? selectedValue;

  @override
  void initState() {
    emailController = TextEditingController();
    addressController = TextEditingController();
    contentPriceController = TextEditingController();
    buildingPriceController = TextEditingController();
    tenantPriceController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    addressController.dispose();
    contentPriceController.dispose();
    buildingPriceController.dispose();
    tenantPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    final List<String> building_type = [
      AppLocalizations.of(context)!.owner,
      AppLocalizations.of(context)!.tenant,
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PropertyAppbar(context),
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
              CarDropdown(
                selectedValue: selectedValue,
                label: AppLocalizations.of(context)!.type,
                list: building_type,
                onChanged: (String? value) {
                  setState(() {
                    selectedValue = value;
                  });
                },
              ),
              selectedValue == AppLocalizations.of(context)!.owner
                  ? SizedBox(
                      height: ConfigSize.defaultSize! * 2,
                    )
                  : const SizedBox.shrink(),
              Visibility(
                visible: selectedValue == AppLocalizations.of(context)!.owner
                    ? true
                    : false,
                child: CustomTextField(
                  labeltext: AppLocalizations.of(context)!.buildingprice,
                  prefixicon: const Icon(Icons.house_rounded),
                  controller: buildingPriceController,
                  inputType: TextInputType.text,
                ),
              ),
              selectedValue == AppLocalizations.of(context)!.owner
                  ? SizedBox(
                      height: ConfigSize.defaultSize! * 2,
                    )
                  : const SizedBox.shrink(),
              Visibility(
                visible: selectedValue == AppLocalizations.of(context)!.owner,
                child: CustomTextField(
                  labeltext: AppLocalizations.of(context)!.contentprice,
                  prefixicon: const Icon(Icons.price_change),
                  controller: contentPriceController,
                  inputType: TextInputType.text,
                ),
              ),
              selectedValue == AppLocalizations.of(context)!.tenant
                  ? SizedBox(
                      height: ConfigSize.defaultSize! * 2,
                    )
                  : const SizedBox.shrink(),
              Visibility(
                visible: selectedValue == AppLocalizations.of(context)!.tenant,
                child: CustomTextField(
                  labeltext: AppLocalizations.of(context)!.tenantprice,
                  prefixicon: const Icon(Icons.price_change),
                  controller: tenantPriceController,
                  inputType: TextInputType.text,
                ),
              ),
              SizedBox(
                height: ConfigSize.defaultSize! * 2,
              ),
              CustomTextField(
                labeltext: AppLocalizations.of(context)!.address,
                prefixicon: const Icon(Icons.pin_drop),
                controller: addressController,
                inputType: TextInputType.text,
              ),
              SizedBox(
                height: ConfigSize.defaultSize! * 2,
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: ConfigSize.defaultSize! * 2),
                child: MainButton(
                  onTap: () {
                    if (validation()) {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: PropertyForm3(
                          address: addressController.text,
                          tenantPrice: selectedValue ==
                                  AppLocalizations.of(context)!.owner
                              ? 0
                              : int.parse(tenantPriceController.text),
                          phone_number: widget.phone_number,
                          type: selectedValue == 'تمليك'
                              ? 'owner'
                              : selectedValue == 'ايجار'
                                  ? 'tenant'
                                  : selectedValue!.toLowerCase(),
                          buildingPrice: selectedValue ==
                                  AppLocalizations.of(context)!.tenant
                              ? 0
                              : int.parse(buildingPriceController.text),
                          contentPrice: selectedValue ==
                                  AppLocalizations.of(context)!.tenant
                              ? 0
                              : int.parse(contentPriceController.text),
                        ),
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

  bool validation() {
    if (emailController.text == '') {
      return false;
    } else if (addressController.text == '') {
      return false;
    } else if (selectedValue == AppLocalizations.of(context)!.tenant &&
        buildingPriceController.text == '') {
      return true;
    } else if (selectedValue == AppLocalizations.of(context)!.tenant &&
        contentPriceController.text == '') {
      return true;
    } else if (selectedValue == AppLocalizations.of(context)!.owner &&
        tenantPriceController.text == '') {
      return true;
    } else {
      return true;
    }
  }
}
