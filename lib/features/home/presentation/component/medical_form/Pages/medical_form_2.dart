import 'package:flutter/material.dart';
import 'package:global_advice_new/core/resource_manger/color_manager.dart';
import 'package:global_advice_new/core/widgets/Custom_Drop_Down.dart';
import 'package:global_advice_new/features/home/presentation/component/medical_form/Widgets/medical_appbar.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'package:global_advice_new/core/resource_manger/asset_path.dart';
import 'package:global_advice_new/core/utils/config_size.dart';
import 'package:global_advice_new/core/widgets/custom_text_field.dart';
import 'package:global_advice_new/core/widgets/main_button.dart';

import 'package:global_advice_new/core/widgets/snack_bar.dart';
import 'package:global_advice_new/features/home/presentation/component/medical_form/Pages/medical_form_3.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MedicalForm2 extends StatefulWidget {
  const MedicalForm2({super.key, required this.name, required this.phone});
  final String name;
  final String phone;

  @override
  State<MedicalForm2> createState() => _MedicalForm2State();
}

class _MedicalForm2State extends State<MedicalForm2> {
  TextEditingController emailController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  FocusNode _focusNode = FocusNode();

  String? selectedValue;

  DateTime selectedDate = DateTime.now();
  int addcount = 0;
  List<TextEditingController> birthdayControllers = [];
  List<TextEditingController> fullnameControllers = [];
  List<String?> genderselectedValues =
      []; // Initialize list for dropdown selected values
  List<String?> relationselectedValues =
      []; // Initialize list for dropdown selected values

  List<String>? genders = [];
  List<String>? names = [];
  List<String>? relations = [];
  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    names!.add(widget.name);
    // Disable focus
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _focusNode.unfocus();
      }
    });

    // genders.clear();

    // Initialize controllers based on addcount
    _initializeControllers();
  }

  void _initializeControllers() {
    birthdayControllers.clear();
    fullnameControllers.clear();
    genderselectedValues.clear();
    relationselectedValues.clear();

    for (int i = 0; i < addcount; i++) {
      birthdayControllers.add(TextEditingController());
      fullnameControllers.add(TextEditingController());
      genderselectedValues.add(null); // Initialize dropdown selected values
      relationselectedValues.add(null); // Initialize dropdown selected values
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    birthdayController.dispose();
    for (var controller in birthdayControllers) {
      controller.dispose();
    }
    for (var controller in fullnameControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  DateTime today = DateTime.now();

  Future<Null> _selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime currentdate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            hintColor: ColorManager.gray,
            colorScheme:
                const ColorScheme.light(primary: ColorManager.mainColor),
          ),
          child: child!,
        );
      },
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1940, 1),
      lastDate:
          DateTime.utc(currentdate.year, currentdate.month, currentdate.day),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        String convertedDateTime =
            "${picked.year.toString()}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
        controller.value = TextEditingValue(text: convertedDateTime);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> siblingrelations = [
      AppLocalizations.of(context)!.spouse,
      AppLocalizations.of(context)!.child,
    ];
    List<String> genderstype = [
      AppLocalizations.of(context)!.male,
      AppLocalizations.of(context)!.female,
    ];
    List<int> new_ages;
    List<int> modify_ages_list() {
      new_ages = birthdayControllers
          .map((controller) {
            String text = controller.text;
            if (text.length >= 4) {
              int birthYear = int.tryParse(text.substring(0, 4)) ?? 0;
              return today.year - birthYear;
            }
            return 0; // Default value if text is invalid
          })
          .where((age) => age > 0)
          .toList();
      int main_age =
          today.year - int.parse(birthdayController.text.substring(0, 4));
      new_ages.insert(0, main_age);
      return new_ages;
    }

    String return_gender(String gender) {
      if (gender == 'ذكر') {
        return 'male';
      } else if (gender == 'أنثى') {
        return 'female';
      } else {
        return gender;
      }
    }

    String return_relation(String relation) {
      if (relation == 'زوج') {
        return 'spouse';
      } else if (relation == 'ابن') {
        return 'children';
      } else {
        return relation;
      }
    }

    List<String> modify_genders_list() {
      genders = genderselectedValues
          .map((e) => return_gender(e.toString().toLowerCase()))
          .toList();
      genders!.insert(0, return_gender(selectedValue!.toLowerCase()));
      return genders!;
    }

    List<String> modify_names_list() {
      genders = fullnameControllers.map((e) => e.text.toString()).toList();
      genders!.insert(0, widget.name);
      return genders!;
    }

    List<String> modify_realtions_list() {
      relations = relationselectedValues
          .map((e) => return_relation(e.toString().toLowerCase()))
          .toList();
      relations!.insert(0, 'self');
      return relations!;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MedicalAppBar(context),
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
                    await _selectDate(context, birthdayController);
                  },
                  icon: const Icon(Icons.calendar_today),
                ),
              ),
              SizedBox(
                height: ConfigSize.defaultSize! * 2,
              ),
              CustomDropDown(
                myvalue: selectedValue,
                DefaultList: genderstype,
                onchanged: (value) {
                  setState(() {
                    selectedValue = value;
                  });
                },
                labeltext: AppLocalizations.of(context)!.gender,
              ),
              SizedBox(height: ConfigSize.defaultSize! * 2),
              Text(
                AppLocalizations.of(context)!.addyourmajority,
                style: TextStyle(
                  fontSize: ConfigSize.defaultSize! * 2,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: ConfigSize.defaultSize! * 2),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      CustomTextField(
                        focusNode: _focusNode,
                        labeltext: AppLocalizations.of(context)!.dateOfBirthday,
                        prefixicon: const Icon(Icons.cake),
                        controller: birthdayControllers[index],
                        inputType: TextInputType.none,
                        suffix: IconButton(
                          onPressed: () async {
                            await _selectDate(
                                context, birthdayControllers[index]);
                          },
                          icon: const Icon(Icons.calendar_today),
                        ),
                      ),
                      SizedBox(
                        height: ConfigSize.defaultSize! * 2,
                      ),
                      CustomDropDown(
                        myvalue: genderselectedValues[index],
                        DefaultList: genderstype,
                        onchanged: (value) {
                          setState(() {
                            genderselectedValues[index] = value;
                          });
                        },
                        labeltext: AppLocalizations.of(context)!.gender,
                      ),
                      SizedBox(height: ConfigSize.defaultSize! * 2),
                      CustomDropDown(
                        myvalue: relationselectedValues[index],
                        DefaultList: siblingrelations,
                        onchanged: (value) {
                          setState(() {
                            relationselectedValues[index] = value;
                          });
                        },
                        labeltext: AppLocalizations.of(context)!.realtion,
                      ),
                      SizedBox(height: ConfigSize.defaultSize! * 2),
                      CustomTextField(
                        labeltext: AppLocalizations.of(context)!.fullName,
                        prefixicon: const Icon(Icons.person),
                        controller: fullnameControllers[index],
                        inputType: TextInputType.name,
                      ),
                      SizedBox(height: ConfigSize.defaultSize! * 2),
                      index == addcount - 1
                          ? const SizedBox.shrink()
                          : const Divider(
                              thickness: 3, color: ColorManager.mainColor),
                      SizedBox(height: ConfigSize.defaultSize! * 2),
                    ],
                  );
                },
                itemCount: addcount,
                shrinkWrap: true,
              ),
              MainButton(
                onTap: () {
                  setState(() {
                    addcount++;
                    _initializeControllers(); // Initialize controllers and values when addcount changes
                  });
                },
                title: AppLocalizations.of(context)!.add,
              ),
              Visibility(
                visible: addcount > 0,
                child: SizedBox(height: ConfigSize.defaultSize! * 2),
              ),
              Visibility(
                visible: addcount > 0,
                child: MainButton(
                  onTap: () {
                    setState(() {
                      if (addcount > 0) {
                        addcount--;
                        _initializeControllers(); // Initialize controllers and values when addcount changes
                      }
                    });
                  },
                  title: AppLocalizations.of(context)!.remove,
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: ConfigSize.defaultSize! * 2),
                child: MainButton(
                  onTap: () {
                    print(addcount);
                    print(selectedValue);
                    print(birthdayController.text);
                    if (addcount > 0 &&
                        selectedValue != null &&
                        modify_ages_list().isNotEmpty &&
                        modify_names_list().isNotEmpty &&
                        modify_genders_list().isNotEmpty &&
                        modify_realtions_list().isNotEmpty) {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: MedicalForm3(
                          phone: widget.phone,
                          gender: selectedValue == 'ذكر'
                              ? 'male'
                              : selectedValue == 'أنثى'
                                  ? 'female'
                                  : selectedValue!.toLowerCase(),
                          relations: modify_realtions_list(),
                          ages: modify_ages_list(),
                          names: modify_names_list(),
                          genders: modify_genders_list(),
                        ),
                        withNavBar: false,
                        pageTransitionAnimation: PageTransitionAnimation.fade,
                      );
                    } else if (addcount == 0 &&
                        selectedValue != null &&
                        birthdayController.text.isNotEmpty) {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: MedicalForm3(
                          phone: widget.phone,
                          gender: selectedValue == 'ذكر'
                              ? 'male'
                              : selectedValue == 'أنثى'
                                  ? 'female'
                                  : selectedValue!.toLowerCase(),
                          relations: modify_realtions_list(),
                          ages: modify_ages_list(),
                          names: modify_names_list(),
                          genders: modify_genders_list(),
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
