import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:global_advice_new/core/resource_manger/color_manager.dart';
import 'package:global_advice_new/core/utils/translation_provider.dart';
import 'package:global_advice_new/core/widgets/snack_bar.dart';
import 'package:global_advice_new/features/home/presentation/component/property_form/widgets/Prop_insurance_appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:global_advice_new/core/resource_manger/asset_path.dart';
import 'package:global_advice_new/core/utils/config_size.dart';
import 'package:global_advice_new/core/widgets/main_button.dart';
import 'package:global_advice_new/features/home/presentation/manager/property_data_bloc/property_data_bloc.dart';
import 'package:global_advice_new/features/home/presentation/manager/property_data_bloc/property_data_event.dart';
import 'package:global_advice_new/features/home/presentation/manager/property_data_bloc/property_data_state.dart';
import 'package:global_advice_new/features/home/presentation/manager/property_insurance.dart/property_insurance_bloc.dart';
import 'package:global_advice_new/features/home/presentation/manager/property_insurance.dart/property_insurance_event.dart';
import 'package:global_advice_new/features/home/presentation/manager/property_insurance.dart/property_insurance_state.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:global_advice_new/features/home/presentation/component/property_form/pages/Prop_Prices_Page.dart';

class PropertyForm3 extends StatefulWidget {
  const PropertyForm3(
      {super.key,
      required this.buildingPrice,
      required this.contentPrice,
      this.phone_number,
      this.type,
      required this.tenantPrice,
      this.address});
  final int buildingPrice;
  final int contentPrice;
  final int tenantPrice;
  final String? phone_number;
  final String? type;
  final String? address;

  @override
  State<PropertyForm3> createState() => _PropertyForm3State();
}

class _PropertyForm3State extends State<PropertyForm3> {
  String? selectedValue3;
  String? selectedValue4;
  String? selectedValue5;

  Map<String, dynamic> Options = new Map();

  List<int> homeBenefitsSet = [];
  bool value1 = false;
  Random random = Random();
  late ScrollController _scrollController;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    print('type : ' + widget.type.toString());
    _initSharedPreferences();
    _scrollController = ScrollController();
    BlocProvider.of<PropertyDataBloc>(context).add(GetallPropertydataEvent());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  bool intToBool(int value) {
    return value != 0;
  }

  Future<void> _initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(
        () {}); // Ensure the state is updated after SharedPreferences is initialized
  }

  @override
  Widget build(BuildContext context) {
    var localetype = Localizations.localeOf(context).languageCode;
    return BlocListener<PropertyInsuranceBloc, PropertyInsuranceBlocState>(
      listener: (context, state) {
        if (state is PropertyInsuranceSuccessState) {
          List<dynamic> plan_name = state.PropertyModel['data']
              .map((e) => localetype == 'ar' ? e['name_alt'] : e['name'])
              .toList();
          List<dynamic> total_price =
              state.PropertyModel['data'].map((e) => e['total_price']).toList();
          List<dynamic> org_id =
              state.PropertyModel['data'].map((e) => e['org_id']).toList();
          List<dynamic> plan_id =
              state.PropertyModel['data'].map((e) => e['id']).toList();
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PropertyPrices(
                    type: widget.type!,
                    building_price:
                        widget.type == AppLocalizations.of(context)!.tenant
                            ? 0
                            : widget.buildingPrice,
                    content_price:
                        widget.type == AppLocalizations.of(context)!.tenant
                            ? 0
                            : widget.contentPrice,
                    tenant_price:
                        widget.type == AppLocalizations.of(context)!.tenant
                            ? 0
                            : widget.tenantPrice,
                    org_id: org_id,
                    plan_id: plan_id,
                    address: widget.address,
                    plan_name: plan_name,
                    total_price: total_price,
                  )));
        } else if (state is PropertyInsuranceRequestErrorState) {
          errorSnackBar(context, state.errorMessage);
        } else if (state is PropertyInsuranceBlocRequestLoadingState) {}
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PropertyAppbar(context),
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
                          BlocBuilder<PropertyDataBloc, PropertyDataState>(
                            builder: (context, state) {
                              if (state is PropertyDataSuccessState) {
                                return Container(
                                  height: ConfigSize.defaultSize! * 45,
                                  child: ListView.builder(
                                    physics: ClampingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: state.PropertyDependinces.length,
                                    itemBuilder: (context, index) {
                                      var dep =
                                          state.PropertyDependinces[index];
                                      var depId = dep.id!;
                                      var values = dep.plansDataValues!;

                                      if (Options[depId] == null) {
                                        Options[depId] = new Map<int, bool>();
                                      }
                                      print(Options);

                                      return ListView.builder(
                                        physics: ClampingScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: values.length,
                                        itemBuilder: (context, index2) {
                                          var item = values[index2];
                                          var itemId = item.id!;
                                          var itemName = localetype == 'ar'
                                              ? item.nameAlt
                                              : item.name!;

                                          if (Options[depId][itemId] == null) {
                                            Options[depId][itemId] = false;
                                          }

                                          var selected = Options[depId][itemId];

                                          return CheckboxListTile(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        ConfigSize
                                                                .defaultSize! *
                                                            1.5)),
                                            activeColor: ColorManager.mainColor,
                                            checkColor: ColorManager.whiteColor,
                                            value: selected,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                Options[depId][itemId] = value!;
                                              });

                                              if (Options[depId][itemId] ==
                                                  true) {
                                                homeBenefitsSet.add(itemId);
                                              } else {
                                                homeBenefitsSet.remove(itemId);
                                              }
                                              print(homeBenefitsSet);
                                              print(selected);
                                            },
                                            title: Text(itemName!),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                );
                              } else if (state is PropertyDataErrorState) {
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
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: ConfigSize.defaultSize! * 2),
                Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: ConfigSize.defaultSize! * 1),
                    child: Consumer<TranslationProvider>(
                      builder: (context, getuid, child) {
                        return MainButton(
                          onTap: () {
                            if (validation()) {
                              BlocProvider.of<PropertyInsuranceBloc>(context)
                                  .add(
                                PropertyInsuranceBlocEvent(
                                  tenantPrice: widget.tenantPrice,
                                  phone: int.parse(widget.phone_number!),
                                  uid: prefs.getString("user_uid")!,
                                  buildingPrice: widget.buildingPrice,
                                  contentPrice: widget.contentPrice,
                                  type: widget.type!,
                                  homeBenefits: homeBenefitsSet,
                                ),
                              );
                            } else {
                              errorSnackBar(
                                  context,
                                  AppLocalizations.of(context)!
                                      .errorFillFields);
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
  }

  bool validation() {
    if (homeBenefitsSet.isEmpty) {
      return false;
    } else {
      return true;
    }
  }
}
