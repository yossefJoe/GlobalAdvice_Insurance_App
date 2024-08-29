import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:global_advice_new/core/resource_manger/asset_path.dart';
import 'package:global_advice_new/core/resource_manger/color_manager.dart';
import 'package:global_advice_new/core/resource_manger/locale_keys.g.dart';
import 'package:global_advice_new/core/utils/config_size.dart';
import 'package:global_advice_new/core/widgets/Loading.dart';
import 'package:global_advice_new/core/widgets/custom_text_field.dart';
import 'package:global_advice_new/core/widgets/main_button.dart';
import 'package:global_advice_new/core/resource_manger/routs_manager.dart';
import 'package:global_advice_new/core/widgets/snack_bar.dart';
import 'package:global_advice_new/features/auth/presentation/manager/register_bloc/register_bloc.dart';
import 'package:global_advice_new/features/auth/presentation/manager/register_bloc/register_event.dart';
import 'package:global_advice_new/features/auth/presentation/manager/register_bloc/register_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController ganderController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dateOfBirthdayController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  String phoneNumber = '';

  @override
  void initState() {
    fullNameController = TextEditingController();
    phoneController = TextEditingController();
    ganderController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    dateOfBirthdayController = TextEditingController();
    confirmPasswordController = TextEditingController();
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
    phoneController.dispose();
    ganderController.dispose();
    emailController.dispose();
    passwordController.dispose();
    dateOfBirthdayController.dispose();
    confirmPasswordController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  String? selectedValue;
  bool isVisible = true;
  bool isVisible1 = true;

  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    DateTime currentdate = DateTime.now();
    final DateTime? picked = await showDatePicker(
        builder: (context, child) {
          return Theme(
              data: ThemeData.light().copyWith(
                hintColor: ColorManager.gray,
                colorScheme: ColorScheme.light(primary: ColorManager.mainColor),
              ),
              child: child!);
        },
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1940, 1),
        lastDate:
            DateTime.utc(currentdate.year, currentdate.month, currentdate.day));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        String convertedDateTime =
            "${picked.year.toString()}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
        dateOfBirthdayController.value =
            TextEditingValue(text: convertedDateTime);
        ;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> items = [
      AppLocalizations.of(context)!.male,
      AppLocalizations.of(context)!.female,
    ];
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.login, (route) => false);
        } else if (state is RegisterErrorState) {
          errorSnackBar(context, state.errorMessage);
        } else if (state is RegisterLoadingState) {
          showLoading(context);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: null,
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context)!.signupwithus,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: ConfigSize.defaultSize! * 2,
            ),
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
                  height: ConfigSize.defaultSize! * 5,
                ),
                Text(
                  AppLocalizations.of(context)!.fullName,
                  style: TextStyle(
                    fontSize: ConfigSize.defaultSize! * 1.6,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                CustomTextField(
                  controller: fullNameController,
                  inputType: TextInputType.name,
                ),
                SizedBox(height: ConfigSize.defaultSize! * 2),
                Text(
                  AppLocalizations.of(context)!.gender,
                  style: TextStyle(
                    fontSize: ConfigSize.defaultSize! * 1.6,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: ConfigSize.defaultSize! - 5,
                ),
                Center(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: Text(
                        AppLocalizations.of(context)!.gender,
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      items: items
                          .map((String item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                          .toList(),
                      value: selectedValue,
                      onChanged: (String? value) {
                        setState(() {
                          selectedValue = value;
                        });
                      },
                      buttonStyleData: ButtonStyleData(
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          color: Colors.white,
                          border:
                              Border.all(color: Colors.grey.shade300, width: 1),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: ConfigSize.defaultSize! * 1.6),
                        height: ConfigSize.defaultSize! * 5.5,
                        width: ConfigSize.screenWidth,
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: ConfigSize.defaultSize! * 2),
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
                SizedBox(height: ConfigSize.defaultSize! * 2),
                Text(
                  AppLocalizations.of(context)!.phonenumber,
                  style: TextStyle(
                    fontSize: ConfigSize.defaultSize! * 1.6,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: ConfigSize.defaultSize! - 5,
                ),
                CustomTextField(
                  controller: phoneController,
                  inputType: TextInputType.number,
                ),
                SizedBox(height: ConfigSize.defaultSize! * 2),
                Text(
                  AppLocalizations.of(context)!.dateOfBirthday,
                  style: TextStyle(
                    fontSize: ConfigSize.defaultSize! * 1.6,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: ConfigSize.defaultSize! - 5,
                ),
                CustomTextField(
                  focusNode: _focusNode,
                  controller: dateOfBirthdayController,
                  inputType: TextInputType.none,
                  suffix: IconButton(
                      onPressed: () async {
                        await _selectDate(context);
                      },
                      icon: const Icon(Icons.calendar_today)),
                ),
                SizedBox(height: ConfigSize.defaultSize! * 2),
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
                  obscureText: isVisible1,
                  suffix: InkWell(
                      onTap: () {
                        {
                          isVisible1 = !isVisible1;
                        }
                        setState(() {});
                      },
                      child: Icon(isVisible1
                          ? Icons.visibility_off_outlined
                          : Icons.remove_red_eye_outlined)),
                ),
                SizedBox(height: ConfigSize.defaultSize! * 2),
                Text(
                  AppLocalizations.of(context)!.confirmPassword,
                  style: TextStyle(
                    fontSize: ConfigSize.defaultSize! * 1.6,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: ConfigSize.defaultSize! - 5,
                ),
                CustomTextField(
                  controller: confirmPasswordController,
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
                        : Icons.remove_red_eye_outlined),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: ConfigSize.defaultSize! * 3),
                  child: MainButton(
                    onTap: () {
                      if (validation()) {
                        BlocProvider.of<RegisterBloc>(context).add(
                          RegisterEvent(
                            email: emailController.text,
                            password: passwordController.text,
                            name: fullNameController.text,
                            telephone: phoneController.text,
                          ),
                        );
                      } else {
                        errorSnackBar(context, StringManager.errorFillFields);
                      }
                    },

                    // PersistentNavBarNavigator.pushNewScreen(
                    //   context,
                    //   screen: const MainScreen(),
                    //   withNavBar: false,
                    //   pageTransitionAnimation: PageTransitionAnimation.fade,
                    // );

                    title: AppLocalizations.of(context)!.next,
                  ),
                ),
                SizedBox(
                  height: ConfigSize.defaultSize! * 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.alreadyHaveAnAccount,
                      style: TextStyle(
                        color: ColorManager.kPrimaryBlueDark,
                        fontWeight: FontWeight.bold,
                        fontSize: ConfigSize.defaultSize! * 1.5,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, Routes.login, (route) => false);
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
                            AppLocalizations.of(context)!.login,
                            style: TextStyle(
                              color: ColorManager.kPrimaryBlueDark,
                              fontWeight: FontWeight.bold,
                              fontSize: ConfigSize.defaultSize! * 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool validation() {
    if (emailController.text == '') {
      return false;
    } else if (passwordController.text == '') {
      return false;
    } else if (fullNameController.text == '') {
      return false;
    } else if (phoneController.text == '') {
      return false;
    } else {
      return true;
    }
  }
}
