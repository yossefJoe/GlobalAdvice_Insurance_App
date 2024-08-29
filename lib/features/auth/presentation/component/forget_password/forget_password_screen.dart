import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:global_advice_new/core/resource_manger/color_manager.dart';
import 'package:global_advice_new/core/resource_manger/locale_keys.g.dart';
import 'package:global_advice_new/core/utils/config_size.dart';
import 'package:global_advice_new/core/widgets/Loading.dart';
import 'package:global_advice_new/core/widgets/custom_text_field.dart';
import 'package:global_advice_new/core/widgets/main_button.dart';
import 'package:global_advice_new/features/auth/presentation/login_screen.dart';
import 'package:global_advice_new/features/auth/presentation/manager/reset_password_bloc/bloc/reset_password_bloc.dart';

import 'package:global_advice_new/core/widgets/snack_bar.dart';
import 'package:global_advice_new/features/auth/presentation/manager/reset_password_bloc/bloc/reset_password_event.dart';
import 'package:global_advice_new/features/auth/presentation/manager/reset_password_bloc/bloc/reset_password_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  TextStyle awesomedialougetextstyle = TextStyle(
    fontSize: ConfigSize.defaultSize! * 1.5,
    fontWeight: FontWeight.w600,
  );
  @override
  Widget build(BuildContext context) {
    return BlocListener<ResetPasswordBloc, ResetPasswordState>(
        listener: (context, state) {
          if (state is ResetPasswordSuccess) {
            EasyLoading.dismiss();
            AwesomeDialog(
              context: context,
              dialogType: DialogType.success,
              animType: AnimType.rightSlide,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    StringManager.resetsuccess.tr(),
                    textAlign: TextAlign.center,
                    style: awesomedialougetextstyle,
                  ),
                  SizedBox(height: ConfigSize.defaultSize! * 2),
                  Text(
                    StringManager.checkyouremailinbox.tr(),
                    style: awesomedialougetextstyle,
                  ),
                ],
              ),
            ).show();
            Future.delayed(
              const Duration(seconds: 5),
              () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                  (route) => false,
                );
              },
            );
          } else if (state is ChangingFailedState) {
            errorSnackBar(context, state.errorMessage);
          } else if (state is LoadingChangingPasswordState) {
            showLoading(context);
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            automaticallyImplyLeading: false,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: ColorManager.mainColor,
              ),
            ),
            centerTitle: true,
            title: Text(
              AppLocalizations.of(context)!.forgot,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: ConfigSize.defaultSize! * 2,
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(ConfigSize.defaultSize! * 1.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.forgothint,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: ConfigSize.defaultSize! * 1.5,
                  ),
                ),
                SizedBox(
                  height: ConfigSize.defaultSize! * 2,
                ),
                Text(
                  AppLocalizations.of(context)!.enterYourEmail,
                  style: TextStyle(
                    fontSize: ConfigSize.defaultSize! * 1.4,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: ConfigSize.defaultSize! - 5,
                ),
                CustomTextField(
                  controller: emailController,
                  inputType: TextInputType.emailAddress,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: ConfigSize.defaultSize! * 3),
                  child: MainButton(
                    onTap: () {
                      if (validation()) {
                        BlocProvider.of<ResetPasswordBloc>(context).add(
                          ResetPasswordEvent(email: emailController.text),
                        );
                      } else {
                        errorSnackBar(context,
                            AppLocalizations.of(context)!.errorFillFields);
                      }
                    },
                    title: AppLocalizations.of(context)!.sendCode,
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  bool validation() {
    if (emailController.text == '') {
      return false;
    } else {
      return true;
    }
  }
}
