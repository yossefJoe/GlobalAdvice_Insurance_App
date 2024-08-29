import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:global_advice_new/core/resource_manger/color_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:global_advice_new/core/resource_manger/routs_manager.dart';
import 'package:global_advice_new/core/utils/config_size.dart';
import 'package:global_advice_new/core/widgets/main_button.dart';
import 'package:global_advice_new/core/widgets/snack_bar.dart';
import 'package:global_advice_new/features/home/presentation/component/life_form/widgets/Back_Button.dart';
import 'package:global_advice_new/core/widgets/Upper_Part_Title.dart';
import 'package:global_advice_new/features/home/presentation/manager/car_policy/car_policy_bloc.dart';
import 'package:global_advice_new/features/home/presentation/manager/car_policy/car_policy_event.dart';
import 'package:global_advice_new/features/home/presentation/manager/car_policy/car_policy_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CarPrices extends StatefulWidget {
  const CarPrices({
    super.key,
    required this.total,
    required this.PlanName,
    required this.price,
    required this.motorBrands,
    required this.motorDeductibles,
    required this.motorManufactureYear,
    required this.organizationId,
    required this.isLicensed,
    required this.planId,
  });
  final List<dynamic> total;
  final int price;
  final List<dynamic> PlanName;
  final String isLicensed;
  final int motorBrands;
  final int motorDeductibles;
  final int motorManufactureYear;
  final List<dynamic> organizationId;
  final List<dynamic> planId;

  @override
  State<CarPrices> createState() => _CarPricesState();
}

class _CarPricesState extends State<CarPrices> {
  late SharedPreferences prefs;

  Future<void> _initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(
        () {}); // Ensure the state is updated after SharedPreferences is initialized
  }

  @override
  void initState() {
    _initSharedPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CarPolicyBloc, CarPolicyBlocState>(
      listener: (context, state) {
        if (state is CarPolicySuccessState) {
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
        }
        if (state is CarPolicyRequestErrorState) {
          errorSnackBar(context, state.errorMessage);
        }
        if (state is CarPolicyRequestLoadingState) {}
      },
      //fdfdfdfdfdfdf
      child: Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              UpperPageTitle(
                  title: AppLocalizations.of(context)!.listofmotorprice),
              widget.total.isNotEmpty || widget.total != null
                  ? ListView.builder(
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(
                              ConfigSize.defaultSize! * 2),
                          child: Padding(
                            padding:
                                EdgeInsets.all(ConfigSize.defaultSize! * 2),
                            child: Card(
                              color: ColorManager.whiteColor,
                              child: Padding(
                                padding:
                                    EdgeInsets.all(ConfigSize.defaultSize! * 2),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.PlanName[index].toString(),
                                      style: TextStyle(
                                          color: ColorManager.mainColor,
                                          fontSize: ConfigSize.defaultSize! * 2,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: ConfigSize.defaultSize! * 1,
                                    ),
                                    Text(
                                      widget.total[index]
                                          .toStringAsFixed(1)
                                          .toString(),
                                      style: TextStyle(
                                          color:
                                              ColorManager.kSecondryGreenLight,
                                          fontSize: ConfigSize.defaultSize! * 2,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                            height: ConfigSize.defaultSize! * 4,
                                            width: ConfigSize.defaultSize! * 15,
                                            child: MainButton(
                                                onTap: () {
                                                  BlocProvider.of<
                                                              CarPolicyBloc>(
                                                          context)
                                                      .add(CarPolicyBlocEvent(
                                                    isLicensed:
                                                        widget.isLicensed,
                                                    motorBrands:
                                                        widget.motorBrands,
                                                    motorDeductibles:
                                                        widget.motorDeductibles,
                                                    motorManufactureYear: widget
                                                        .motorManufactureYear,
                                                    organizationId: widget
                                                        .organizationId[index],
                                                    planId:
                                                        widget.planId[index],
                                                    price: widget.price,
                                                    uID: prefs
                                                        .getString("user_uid"),
                                                  ));
                                                },
                                                title: AppLocalizations.of(
                                                        context)!
                                                    .choosePolicy))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: widget.PlanName.length,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                    )
                  : Center(
                      child: Text(
                      AppLocalizations.of(context)!.noOffersAvailable,
                      style: TextStyle(
                          fontSize: ConfigSize.defaultSize! * 2.5,
                          fontWeight: FontWeight.bold),
                    ))
            ],
          ),
        )),
      ),
    );
  }
}
