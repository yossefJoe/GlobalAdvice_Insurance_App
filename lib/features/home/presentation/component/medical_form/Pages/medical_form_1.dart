import 'package:flutter/material.dart';
import 'package:global_advice_new/core/resource_manger/asset_path.dart';
import 'package:global_advice_new/core/utils/config_size.dart';
import 'package:global_advice_new/core/widgets/custom_text_field.dart';
import 'package:global_advice_new/core/widgets/snack_bar.dart';
import 'package:global_advice_new/features/home/presentation/component/medical_form/Pages/medical_form_2.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:global_advice_new/core/widgets/Custom_Drawer.dart';
import 'package:global_advice_new/core/widgets/main_button.dart';

class MedicalFormMainPersonData extends StatefulWidget {
  const MedicalFormMainPersonData({super.key});

  @override
  State<MedicalFormMainPersonData> createState() =>
      _MedicalFormMainPersonDataState();
}

class _MedicalFormMainPersonDataState extends State<MedicalFormMainPersonData> {
  late TextEditingController fullNameController;
  late TextEditingController phoneController;

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
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                          labeltext: AppLocalizations.of(context)!.fullName,
                          prefixicon: const Icon(Icons.person),
                          controller: fullNameController,
                          inputType: TextInputType.name,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: ConfigSize.defaultSize! * 2),
              CustomTextField(
                labeltext: AppLocalizations.of(context)!.phonenumber,
                prefixicon: const Icon(Icons.phone_android_sharp),
                controller: phoneController,
                inputType: TextInputType.phone,
              ),
              SizedBox(height: ConfigSize.defaultSize! * 2),
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: ConfigSize.defaultSize! * 3),
                child: MainButton(
                  onTap: () {
                    if (fullNameController.text.isNotEmpty &&
                        phoneController.text.isNotEmpty) {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: MedicalForm2(
                          name: fullNameController.text,
                          phone: phoneController.text,
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
