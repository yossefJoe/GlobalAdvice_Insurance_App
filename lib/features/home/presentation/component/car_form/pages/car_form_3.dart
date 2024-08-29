
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:global_advice_new/core/resource_manger/color_manager.dart';
import 'package:global_advice_new/core/utils/translation_provider.dart';
import 'package:global_advice_new/core/widgets/snack_bar.dart';
import 'package:global_advice_new/features/home/presentation/component/car_form/pages/Prices_Page.dart';
import 'package:global_advice_new/features/home/presentation/component/car_form/widgets/car_insurance_appbar.dart';
import 'package:global_advice_new/features/home/presentation/manager/car_data_bloc/car_data_bloc.dart';
import 'package:global_advice_new/features/home/presentation/manager/car_insurance/carinsurance_bloc.dart';
import 'package:global_advice_new/features/home/presentation/manager/car_insurance/carinsurance_state.dart';

import 'package:global_advice_new/core/resource_manger/asset_path.dart';
import 'package:global_advice_new/core/utils/config_size.dart';
import 'package:global_advice_new/core/widgets/main_button.dart';
import 'package:global_advice_new/features/home/presentation/manager/car_data_bloc/car_data_event.dart';
import 'package:global_advice_new/features/home/presentation/manager/car_data_bloc/car_data_state.dart';
import 'package:global_advice_new/features/home/presentation/manager/car_insurance/carinsurance_event.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CarForm3 extends StatefulWidget {
  const CarForm3(
      {super.key,
      required this.price,
      required this.is_licenced,
      required this.phoneNumber});
  final int price;
  final String is_licenced;
  final String phoneNumber;

  @override
  State<CarForm3> createState() => _CarForm3State();
}

class _CarForm3State extends State<CarForm3> {
  String? selectedValue3;
  String? selectedValue4;
  String? selectedValue5;
  int motor_Brands_index = 0;

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
    BlocProvider.of<CarDataBloc>(context).add(GetallcardataEvent());
  }

  late SharedPreferences prefs;

  Future<void> _initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(
        () {}); // Ensure the state is updated after SharedPreferences is initialized
  }

  @override
  Widget build(BuildContext context) {
    var localetype = Localizations.localeOf(context).languageCode;
    return Consumer<TranslationProvider>(
      builder: (context, getuid, child) {
        return BlocListener<CarinsuranceBloc, CarInsuranceBlocState>(
          listener: (context, state) {
            if (state is CarInsuranceSuccessState) {
              List<dynamic> total = state.CarInsuranceModel['data']
                  .map((e) => e['total'])
                  .toList();
              List<dynamic> PlanName = state.CarInsuranceModel['data']
                  .map((e) => e['plan_name'])
                  .toList();
              List<dynamic> plan_id = state.CarInsuranceModel['data']
                  .map((e) => e['plan_id'])
                  .toList();
              List<dynamic> organizationId = state.CarInsuranceModel['data']
                  .map((e) => e['org_id'])
                  .toList();

              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CarPrices(
                        motorBrands: int.parse(selectedValue3!),
                        motorDeductibles: int.parse(selectedValue4!),
                        motorManufactureYear: int.parse(selectedValue5!),
                        organizationId: organizationId,
                        planId: plan_id,
                        isLicensed: widget.is_licenced,
                        PlanName: PlanName,
                        total: total,
                        price: widget.price,
                      )));
            }
            if (state is CarInsuranceRequestErrorState) {
              errorSnackBar(context, state.errorMessage);
            }
            if (state is CarInsuranceRequestLoadingState) {
              const Center(
                child: CircularProgressIndicator(
                  color: ColorManager.mainColor,
                ),
              );
            }
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: CarAppbar(context),
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
                              BlocBuilder<CarDataBloc, CarDataState>(
                                builder: (context, state) {
                                  if (state is CarDataSuccessState) {
                                    // Create a list of dropdown items
                                    List<DropdownMenuItem<String>>
                                        dropdownItems =
                                        state.CarDependinces.where((element) =>
                                                element.id == 'motorBrands')
                                            .expand((car) {
                                      // Extract `id` and `name` to be used as values and labels
                                      return car.plansDataValues!.map((e) {
                                        return DropdownMenuItem<String>(
                                          value: e.id
                                              .toString(), // Ensure value is not null
                                          child: Text(
                                            localetype == 'en'
                                                ? e.name?.toUpperCase() ??
                                                    'Unknown'
                                                : e.nameAlt?.toUpperCase() ??
                                                    'Unknown',
                                            style: TextStyle(
                                              fontSize:
                                                  ConfigSize.defaultSize! * 1.6,
                                              fontWeight: FontWeight.bold,
                                              color: ColorManager.mainColor,
                                            ),
                                          ),
                                        );
                                      }).toList();
                                    }).toList();

                                    return Center(
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton2<String>(
                                          isExpanded: true,
                                          hint: Text(
                                            AppLocalizations.of(context)!
                                                .carbrand,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color:
                                                  Theme.of(context).hintColor,
                                            ),
                                          ),
                                          items: dropdownItems,
                                          value:
                                              selectedValue3, // Set this to the currently selected value
                                          onChanged: (String? value) {
                                            setState(() {
                                              selectedValue3 = value;
                                            });
                                          },
                                          buttonStyleData: ButtonStyleData(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(12)),
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Colors.grey.shade300,
                                                  width: 1),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    ConfigSize.defaultSize! *
                                                        1.6),
                                            height:
                                                ConfigSize.defaultSize! * 5.5,
                                            width: ConfigSize.screenWidth,
                                          ),
                                          menuItemStyleData:
                                              const MenuItemStyleData(
                                            height: 40,
                                          ),
                                        ),
                                      ),
                                    );
                                  } else if (state is CarDataErrorState) {
                                    return Text(state.errorMessage);
                                  } else {
                                    return const Center(
                                      child: CircularProgressIndicator(
                                        color: ColorManager.mainColor,
                                      ),
                                    );
                                  }
                                },
                              ),
                              SizedBox(height: ConfigSize.defaultSize! * 2),
                              BlocBuilder<CarDataBloc, CarDataState>(
                                builder: (context, state) {
                                  if (state is CarDataSuccessState) {
                                    // Create a list of dropdown items
                                    List<DropdownMenuItem<String>>
                                        dropdownItems =
                                        state.CarDependinces.where((element) =>
                                            element.id ==
                                            'motorDeductibles').expand((car) {
                                      // Extract `id` and `name` to be used as values and labels
                                      return car.plansDataValues!.map((e) {
                                        return DropdownMenuItem<String>(
                                          value: e.id
                                              .toString(), // Ensure value is not null
                                          child: Text(
                                            localetype == 'en'
                                                ? e.name?.toUpperCase() ??
                                                    'Unknown'
                                                : e.nameAlt?.toUpperCase() ??
                                                    'Unknown',
                                            style: TextStyle(
                                              fontSize:
                                                  ConfigSize.defaultSize! * 1.6,
                                              fontWeight: FontWeight.bold,
                                              color: ColorManager.mainColor,
                                            ),
                                          ),
                                        );
                                      }).toList();
                                    }).toList();

                                    return Center(
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton2<String>(
                                          isExpanded: true,
                                          hint: Text(
                                            AppLocalizations.of(context)!
                                                .motorDeductibles,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color:
                                                  Theme.of(context).hintColor,
                                            ),
                                          ),
                                          items: dropdownItems,
                                          value:
                                              selectedValue4, // Set this to the currently selected value
                                          onChanged: (String? value) {
                                            setState(() {
                                              selectedValue4 = value;
                                            });
                                          },
                                          buttonStyleData: ButtonStyleData(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(12)),
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Colors.grey.shade300,
                                                  width: 1),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    ConfigSize.defaultSize! *
                                                        1.6),
                                            height:
                                                ConfigSize.defaultSize! * 5.5,
                                            width: ConfigSize.screenWidth,
                                          ),
                                          menuItemStyleData:
                                              const MenuItemStyleData(
                                            height: 40,
                                          ),
                                        ),
                                      ),
                                    );
                                  } else if (state is CarDataErrorState) {
                                    return Text(state.errorMessage);
                                  } else {
                                    return const Center(
                                      child: CircularProgressIndicator(
                                        color: ColorManager.mainColor,
                                      ),
                                    );
                                  }
                                },
                              ),
                              SizedBox(height: ConfigSize.defaultSize! * 2),
                              BlocBuilder<CarDataBloc, CarDataState>(
                                builder: (context, state) {
                                  if (state is CarDataSuccessState) {
                                    // Create a list of dropdown items
                                    List<DropdownMenuItem<String>>
                                        dropdownItems =
                                        state.CarDependinces.where((element) =>
                                                element.id ==
                                                'motorManufactureYear')
                                            .expand((car) {
                                      // Extract `id` and `name` to be used as values and labels
                                      return car.plansDataValues!.map((e) {
                                        return DropdownMenuItem<String>(
                                          value: e.id
                                              .toString(), // Ensure value is not null
                                          child: Text(
                                            localetype == 'en'
                                                ? e.name?.toUpperCase() ??
                                                    'Unknown'
                                                : e.nameAlt?.toUpperCase() ??
                                                    'Unknown',
                                            style: TextStyle(
                                              fontSize:
                                                  ConfigSize.defaultSize! * 1.6,
                                              fontWeight: FontWeight.bold,
                                              color: ColorManager.mainColor,
                                            ),
                                          ),
                                        );
                                      }).toList();
                                    }).toList();

                                    return Center(
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton2<String>(
                                          isExpanded: true,
                                          hint: Text(
                                            AppLocalizations.of(context)!
                                                .manufactureYear,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color:
                                                  Theme.of(context).hintColor,
                                            ),
                                          ),
                                          items: dropdownItems,
                                          value:
                                              selectedValue5, // Set this to the currently selected value
                                          onChanged: (String? value) {
                                            setState(() {
                                              selectedValue5 = value;
                                            });
                                          },
                                          buttonStyleData: ButtonStyleData(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(12)),
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Colors.grey.shade300,
                                                  width: 1),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    ConfigSize.defaultSize! *
                                                        1.6),
                                            height:
                                                ConfigSize.defaultSize! * 5.5,
                                            width: ConfigSize.screenWidth,
                                          ),
                                          menuItemStyleData:
                                              const MenuItemStyleData(
                                            height: 40,
                                          ),
                                        ),
                                      ),
                                    );
                                  } else if (state is CarDataErrorState) {
                                    return Text(state.errorMessage);
                                  } else {
                                    return const Center(
                                      child: CircularProgressIndicator(
                                        color: ColorManager.mainColor,
                                      ),
                                    );
                                  }
                                },
                              ),
                              SizedBox(height: ConfigSize.defaultSize! * 2),
                              SizedBox(height: ConfigSize.defaultSize! * 2),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: ConfigSize.defaultSize! * 1),
                        child: Consumer<TranslationProvider>(
                          builder: (context, getuid, child) {
                            return MainButton(
                              onTap: () {
                                if (selectedValue3 != null &&
                                    selectedValue4 != null &&
                                    selectedValue5 != null) {
                                  BlocProvider.of<CarinsuranceBloc>(context)
                                      .add(CarInsuranceBlocEvent(
                                          isLicensed: widget.is_licenced,
                                          motorBrands:
                                              int.parse(selectedValue3!),
                                          motorDeductibles:
                                              int.parse(selectedValue4!),
                                          motorManufactureYear:
                                              int.parse(selectedValue5!),
                                          phone: int.parse(widget.phoneNumber),
                                          price: widget.price,
                                          uid: prefs.getString("user_uid")));
                                } else {
                                  errorSnackBar(
                                      context,
                                      AppLocalizations.of(context)!
                                          .errorFillFields);
                                  //hvbhvhvhvh
                                }
                              },
                              title: AppLocalizations.of(context)!.submit,
                            );
                          },
                        )),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
