import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:global_advice_new/core/resource_manger/color_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:global_advice_new/core/utils/config_size.dart';
import 'package:global_advice_new/features/home/presentation/manager/property_policy/property_policy_bloc.dart';
import 'package:global_advice_new/features/home/presentation/manager/property_policy/property_policy_event.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:global_advice_new/core/resource_manger/routs_manager.dart';
import 'package:global_advice_new/core/widgets/main_button.dart';
import 'package:global_advice_new/core/widgets/snack_bar.dart';
import 'package:global_advice_new/features/home/presentation/manager/property_policy/property_policy_state.dart';
import 'package:global_advice_new/features/home/presentation/component/life_form/widgets/Back_Button.dart';

class PropertyPrices extends StatefulWidget {
  const PropertyPrices(
      {super.key,
      required this.plan_name,
      required this.total_price,
      this.address,
      required this.type,
      this.building_price,
      this.content_price,
      this.tenant_price,
      this.org_id,
      this.plan_id});
  final List<dynamic> plan_name;
  final List<dynamic> total_price;
  final String? address;
  final String type;
  final int? building_price;
  final int? content_price;
  final int? tenant_price;
  final List<dynamic>? org_id;
  final List<dynamic>? plan_id;
  @override
  State<PropertyPrices> createState() => _PropertyPricesState();
}

class _PropertyPricesState extends State<PropertyPrices> {
  late SharedPreferences prefs;

  Future<void> _initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(
        () {}); // Ensure the state is updated after SharedPreferences is initialized
  }

  @override
  void initState() {
    print('type : ' + widget.type.toString());
    _initSharedPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PropertyPolicyBloc, PropertyPolicyblocState>(
      listener: (context, state) {
        if (state is PropertyPolicySuccessState) {
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
        if (state is PropertyPolicyRequestErrorState) {
          errorSnackBar(context, state.errorMessage);
        }
      },
      child: Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.arrow_back_ios_new_rounded)),
                  Text(
                    AppLocalizations.of(context)!.listofpropertyprice,
                    style: TextStyle(
                        fontSize: ConfigSize.defaultSize! * 3,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              widget.total_price.isNotEmpty || widget.total_price != null
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
                                      widget.plan_name[index].toString(),
                                      style: TextStyle(
                                          color: ColorManager.mainColor,
                                          fontSize: ConfigSize.defaultSize! * 2,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: ConfigSize.defaultSize! * 1,
                                    ),
                                    Text(
                                      widget.total_price[index]
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
                                                              PropertyPolicyBloc>(
                                                          context)
                                                      .add(
                                                          PropertyPolicyblocEvent(
                                                    uID: prefs
                                                        .getString("user_uid"),
                                                    organizationId:
                                                        widget.org_id![index],
                                                    planId:
                                                        widget.plan_id![index],
                                                    building_price:
                                                        widget.type == 'tenant'
                                                            ? 0
                                                            : widget
                                                                .building_price,
                                                    content_price:
                                                        widget.type == 'tenant'
                                                            ? 0
                                                            : widget
                                                                .content_price,
                                                    tenant_price: widget.type ==
                                                            'owner'
                                                        ? 0
                                                        : widget.tenant_price,
                                                    address: widget.address,
                                                    type: widget.type,
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
                      itemCount: widget.plan_name.length,
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
