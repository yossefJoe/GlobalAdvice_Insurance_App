import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:global_advice_new/core/resource_manger/asset_path.dart';
import 'package:global_advice_new/core/resource_manger/color_manager.dart';
import 'package:global_advice_new/core/resource_manger/locale_keys.g.dart';
import 'package:global_advice_new/core/utils/config_size.dart';
import 'package:global_advice_new/core/utils/translation_provider.dart';
import 'package:global_advice_new/core/widgets/Loading.dart';
import 'package:global_advice_new/core/widgets/custom_text_field.dart';
import 'package:global_advice_new/core/widgets/main_button.dart';
import 'package:global_advice_new/features/auth/presentation/component/forget_password/forget_password_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

import 'package:global_advice_new/core/resource_manger/routs_manager.dart';
import 'package:global_advice_new/core/widgets/snack_bar.dart';
import 'package:global_advice_new/features/auth/presentation/manager/login_bloc/login_bloc.dart';
import 'package:global_advice_new/features/auth/presentation/manager/login_bloc/login_event.dart';
import 'package:global_advice_new/features/auth/presentation/manager/login_bloc/login_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? selectedValue;
  bool isVisible = true;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ConfigSize().init(context);

    return Consumer<TranslationProvider>(
      builder: (context, login, child) {
        return BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              Navigator.pushNamedAndRemoveUntil(
                  context, Routes.homeScreen, (route) => false);
              var UID = state.loginAuthModelResponse['data']['UID'];
              login.setUID(UID);

              print('UID: UID');
            } else if (state is LoginErrorState) {
              errorSnackBar(context, state.errorMessage);
            } else if (state is LoginLoadingState) {
              showLoading(context);
            }
          },
          child: Scaffold(
            backgroundColor: ColorManager.whiteColor,
            resizeToAvoidBottomInset: false,
            body: Column(
              children: [
                SizedBox(
                  height: ConfigSize.defaultSize! * 10,
                ),
                Image.asset(
                  AssetsPath.logo,
                  scale: 4,
                ),
                SizedBox(
                  height: ConfigSize.defaultSize! * 4,
                ),
                Padding(
                  padding: EdgeInsets.all(ConfigSize.defaultSize! * 1.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.email,
                        style: TextStyle(
                          fontSize: ConfigSize.defaultSize! * 1.6,
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
                      SizedBox(
                        height: ConfigSize.defaultSize! * 2,
                      ),
                      Text(
                        AppLocalizations.of(context)!.password,
                        style: TextStyle(
                          fontSize: ConfigSize.defaultSize! * 1.6,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: ConfigSize.defaultSize! - 5,
                      ),
                      CustomTextField(
                        controller: passwordController,
                        inputType: TextInputType.text,
                        obscureText: isVisible,
                        suffix: InkWell(
                            onTap: () {
                              {
                                isVisible = !isVisible;
                              }
                              setState(() {});
                            },
                            child: Icon(isVisible
                                ? Icons.visibility_off_outlined
                                : Icons.remove_red_eye_outlined)),
                      ),
                      SizedBox(
                        height: ConfigSize.defaultSize! * 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: const ForgetPasswordScreen(),
                                withNavBar: false,
                                pageTransitionAnimation:
                                    PageTransitionAnimation.fade,
                              );
                            },
                            child: Text(
                              AppLocalizations.of(context)!.forgetPassword,
                              style: TextStyle(
                                fontSize: ConfigSize.defaultSize! * 1.6,
                                fontWeight: FontWeight.w600,
                                color: ColorManager.mainColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: ConfigSize.defaultSize! * 3),
                          child: Consumer<TranslationProvider>(
                            builder: (context, login, child) {
                              return MainButton(
                                color: ColorManager.kPrimaryBlueDark,
                                textColor: ColorManager.whiteColor,
                                onTap: () {
                                  if (validation()) {
                                    BlocProvider.of<LoginBloc>(context).add(
                                      LoginEvent(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      ),
                                    );
                                  } else {
                                    errorSnackBar(
                                        context, StringManager.errorFillFields);
                                  }
                                },
                                title: AppLocalizations.of(context)!.signingIn,
                              );
                            },
                          )),
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.all(ConfigSize.defaultSize! * 1.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.donthaveaccount,
                        style: const TextStyle(
                          color: ColorManager.gray,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, Routes.createAccount, (route) => false);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorManager.gray,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: ConfigSize.defaultSize! * 1.5,
                              horizontal: ConfigSize.defaultSize! * 3,
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.createAccount,
                              style: TextStyle(
                                color: ColorManager.kPrimaryBlueDark,
                                fontWeight: FontWeight.bold,
                                fontSize: ConfigSize.defaultSize! * 1.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  bool validation() {
    if (emailController.text == '') {
      return false;
    } else if (passwordController.text == '') {
      return false;
    } else {
      return true;
    }
  }
}
