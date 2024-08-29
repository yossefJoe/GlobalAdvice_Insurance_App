import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:global_advice_new/features/home/presentation/component/medical_form/Widgets/medical_appbar.dart';
import 'package:global_advice_new/features/home/presentation/manager/health_data/health_data_bloc.dart';
import 'package:global_advice_new/features/home/presentation/manager/health_data/health_data_state.dart';
import 'package:global_advice_new/features/home/presentation/manager/health_insurance_request/healthinsurancebloc_bloc.dart';
import 'package:global_advice_new/features/home/presentation/manager/health_insurance_request/healthinsurancebloc_event.dart';
import 'package:global_advice_new/features/home/presentation/manager/health_insurance_request/healthinsurancebloc_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:global_advice_new/core/resource_manger/asset_path.dart';
import 'package:global_advice_new/core/utils/config_size.dart';
import 'package:global_advice_new/core/widgets/main_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:global_advice_new/core/resource_manger/color_manager.dart';
import 'package:global_advice_new/features/home/presentation/component/medical_form/Widgets/Annual_Drop_Down.dart';
import 'package:global_advice_new/core/widgets/snack_bar.dart';
import 'package:global_advice_new/features/home/data/model/health_dependinces_model.dart';
import 'package:global_advice_new/features/home/presentation/manager/health_data/health_data_event.dart';
import 'package:global_advice_new/features/home/presentation/component/medical_form/Pages/Mdeical_Prices.dart';

class MedicalForm3 extends StatefulWidget {
  const MedicalForm3({
    super.key,
    required this.phone,
    required this.relations,
    this.ages,
    this.names,
    required this.gender,
    this.genders,
  });
  final String phone;
  final String gender;
  final List<String>? relations;
  final List<int>? ages;
  final List<String>? names;
  final List<String>? genders;

  @override
  State<MedicalForm3> createState() => _MedicalForm3State();
}

class _MedicalForm3State extends State<MedicalForm3> {
  String? selectedValue;
  late SharedPreferences prefs;

  Future<void> _initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(
        () {}); // Ensure the state is updated after SharedPreferences is initialized
  }

  @override
  void initState() {
    print(widget.names);
    print(widget.ages);
    print(widget.genders);
    _initSharedPreferences();
    BlocProvider.of<HealthDataBloc>(context).add(GetallHealthDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var localetype = Localizations.localeOf(context).languageCode;

    return BlocListener<HealthinsuranceBloc, HealthinsuranceblocState>(
        listener: (context, state) {
          if (state is HealthInsuranceSuccessState) {
            int data_length = state.healthInsuranceModel['data'].length;
            int amounts_length = state.healthInsuranceModel['data']
                .map((e) => e["persons"])
                .length;
            List<dynamic> org_id = state.healthInsuranceModel['data']
                .map((e) => e['org_id'])
                .toList();
            List<dynamic> plan_id = state.healthInsuranceModel['data']
                .map((e) => e['plan_id'])
                .toList();
            List<dynamic> total_price = state.healthInsuranceModel['data']
                .map((e) => e['total'])
                .toList();
            List<dynamic> persons = state.healthInsuranceModel['data']
                .map((e) => e["persons"])
                .toList();
            List<dynamic> health_limit = state.healthInsuranceModel['data']
                .map((e) => e["healthLimit"])
                .toList();
            List<dynamic> health_penefits = state.healthInsuranceModel['data']
                .map((e) => e["healthBenefits"])
                .toList();
            List<dynamic> plan_name = state.healthInsuranceModel['data']
                .map((e) =>
                    localetype == 'ar' ? e['plan_name_alt'] : e['plan_name'])
                .toList();

            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MedicalPrices(
                      amounts_length: amounts_length,
                      ages: widget.ages,
                      relations: widget.relations,
                      names: widget.names,
                      org_id: org_id,
                      plan_id: plan_id,
                      data_length: data_length,
                      health_penefits: health_penefits,
                      genders: widget.genders,
                      health_limit: health_limit,
                      persons: persons,
                      total_price: total_price,
                      plan_name: plan_name,
                    )));
          } else if (state is HealthinsuranceRequestErrorState) {
            errorSnackBar(context, state.errorMessage);
          } else if (state is HealthinsuranceRequestLoadingState) {}
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: MedicalAppBar(context),
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
                  BlocBuilder<HealthDataBloc, HealthDataState>(
                    builder: (context, state) {
                      final List<HealthDependincesModel> somestatevalue;

                      if (state is HealthDataSuccessState) {
                        // Create a list of dropdown items
                        return AnnualLimitDropDown(
                          myvalue: selectedValue,
                          onchanged: (String? value) {
                            setState(() {
                              selectedValue = value;
                            });
                          },
                          labeltext: AppLocalizations.of(context)!.annuallimit,
                          map_value: 'healthLimit',
                          mylist: state.HealthDependinces,
                        );
                      } else if (state is HealthDataErrorState) {
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
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: ConfigSize.defaultSize! * 1),
                    child: MainButton(
                      onTap: () {
                        if (selectedValue != null) {
                          BlocProvider.of<HealthinsuranceBloc>(context)
                              .add(HealthinsuranceblocEvent(
                            uid: prefs.getString("user_uid"),
                            name: widget.names,
                            age: widget.ages,
                            relation: widget.relations,
                            gender: widget.gender,
                            healthLimit: int.parse(selectedValue!),
                            phone: widget.phone,
                          ));
                        } else {
                          errorSnackBar(context,
                              AppLocalizations.of(context)!.errorFillFields);
                        }
                      },
                      title: AppLocalizations.of(context)!.submit,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
