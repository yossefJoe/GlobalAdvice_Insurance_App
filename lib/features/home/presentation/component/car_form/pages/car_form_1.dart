import 'package:flutter/material.dart';
import 'package:global_advice_new/core/resource_manger/asset_path.dart';
import 'package:global_advice_new/core/utils/config_size.dart';
import 'package:global_advice_new/core/widgets/custom_text_field.dart';
import 'package:global_advice_new/features/home/presentation/component/car_form/pages/car_form_2.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:global_advice_new/core/widgets/Custom_Drawer.dart';
import 'package:global_advice_new/core/widgets/main_button.dart';
import 'package:global_advice_new/core/widgets/snack_bar.dart';

class CarFormMainPersonData extends StatefulWidget {
  const CarFormMainPersonData({super.key});

  @override
  State<CarFormMainPersonData> createState() => _CarFormMainPersonDataState();
}

class _CarFormMainPersonDataState extends State<CarFormMainPersonData> {
  TextEditingController fullNameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    fullNameController = TextEditingController();
    phoneController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const CustomDrawer(),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          iconSize: 32, // Adjust the size as needed
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
        centerTitle: true,
        title: Image.asset(
          AssetsPath.logo,
          scale: 10,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(ConfigSize.defaultSize! * 1.5),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                labeltext: AppLocalizations.of(context)!.fullName,
                prefixicon: const Icon(Icons.person),
                controller: fullNameController,
                inputType: TextInputType.name,
              ),
              SizedBox(
                height: ConfigSize.defaultSize! * 2,
              ),
              CustomTextField(
                labeltext: AppLocalizations.of(context)!.phonenumber,
                prefixicon: const Icon(Icons.phone_android_sharp),
                controller: phoneController,
                inputType: TextInputType.phone,
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: ConfigSize.defaultSize! * 3),
                child: MainButton(
                  onTap: () {
                    if (fullNameController.text.isNotEmpty &&
                        phoneController.text.isNotEmpty) {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: CarForm2(
                          phoneNumber: phoneController.text,
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
}
