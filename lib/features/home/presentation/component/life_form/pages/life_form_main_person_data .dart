import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:global_advice_new/core/resource_manger/asset_path.dart';
import 'package:global_advice_new/core/utils/config_size.dart';
import 'package:global_advice_new/core/widgets/Loading.dart';
import 'package:global_advice_new/core/widgets/custom_text_field.dart';
import 'package:global_advice_new/features/home/presentation/component/life_form/widgets/Back_Button.dart';
import 'package:global_advice_new/features/home/presentation/manager/life_insurance/life_insurance_event.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:global_advice_new/core/resource_manger/routs_manager.dart';
import 'package:global_advice_new/core/widgets/Custom_Drawer.dart';
import 'package:global_advice_new/core/widgets/main_button.dart';
import 'package:global_advice_new/core/widgets/snack_bar.dart';
import 'package:global_advice_new/features/home/presentation/manager/life_insurance/life_insurance_bloc.dart';
import 'package:global_advice_new/features/home/presentation/manager/life_insurance/life_insurance_state.dart';

import 'package:global_advice_new/core/resource_manger/locale_keys.g.dart';

class LifeFormMainPersonData extends StatefulWidget {
  const LifeFormMainPersonData({super.key});

  @override
  State<LifeFormMainPersonData> createState() => _LifeFormMainPersonDataState();
}

class _LifeFormMainPersonDataState extends State<LifeFormMainPersonData> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController massageController = TextEditingController();
  FocusNode _focusNode = FocusNode();

  DateTime selectedDate = DateTime.now();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    fullNameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    massageController = TextEditingController();
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
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    massageController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LifeInsuranceBloc, LifeInsuranceBlocState>(
      listener: (context, state) {
        if (state is LifeInsuranceSuccessState) {
          AwesomeDialog(
                  context: context,
                  dialogType: DialogType.success,
                  animType: AnimType.rightSlide,
                  desc: AppLocalizations.of(context)!.lifeinsurancerequest,
                  btnOkOnPress: () {},
                  btnOk: const CustomBackButton())
              .show();
          Future.delayed(const Duration(seconds: 3), () {
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.homeScreen, (route) => false);
          });
        } else if (state is LifeInsuranceRequestErrorState) {
          errorSnackBar(context, state.errorMessage);
        } else if (state is LifeInsuranceRequestLoadingState) {
          showLoading(context);
        }
      },
      child: Scaffold(
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
                  labeltext: AppLocalizations.of(context)!.email,
                  prefixicon: const Icon(Icons.email),
                  controller: emailController,
                  inputType: TextInputType.emailAddress,
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
                SizedBox(
                  height: ConfigSize.defaultSize! * 2,
                ),
                CustomTextField(
                  labeltext: AppLocalizations.of(context)!.message,
                  prefixicon: const Icon(Icons.library_books),
                  controller: massageController,
                  inputType: TextInputType.text,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: ConfigSize.defaultSize! * 3),
                  child: MainButton(
                    onTap: () {
                      if (validation()) {
                        BlocProvider.of<LifeInsuranceBloc>(context).add(
                          LifeInsuranceBlocEvent(
                            email: emailController.text,
                            name: fullNameController.text,
                            phone: phoneController.text,
                            body: massageController.text,
                          ),
                        );
                      } else {
                        errorSnackBar(context, StringManager.errorFillFields);
                      }
                    },
                    title: AppLocalizations.of(context)!.finish,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool validation() {
    if (fullNameController.text == '') {
      return false;
    } else if (emailController.text == '') {
      return false;
    } else if (phoneController.text == '') {
      return false;
    } else if (massageController.text == '') {
      return false;
    } else {
      return true;
    }
  }
}
