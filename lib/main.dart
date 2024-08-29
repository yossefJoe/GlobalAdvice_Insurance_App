import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:global_advice_new/core/resource_manger/routs_manager.dart';
import 'package:global_advice_new/core/service/navigation_service.dart';
import 'package:global_advice_new/core/service/service_locator.dart';
import 'package:global_advice_new/core/utils/config_size.dart';
import 'package:global_advice_new/core/utils/font_loader.dart';
import 'package:global_advice_new/features/auth/presentation/login_screen.dart';
import 'package:global_advice_new/features/home/presentation/home_screen.dart';
import 'package:global_advice_new/features/home/presentation/manager/car_insurance/carinsurance_bloc.dart';
import 'package:global_advice_new/features/home/presentation/manager/car_policy/car_policy_bloc.dart';
import 'package:global_advice_new/features/home/presentation/manager/health_insurance_request/healthinsurancebloc_bloc.dart';
import 'package:global_advice_new/features/home/presentation/manager/life_insurance/life_insurance_bloc.dart';
import 'package:global_advice_new/features/home/presentation/manager/other_forms_bloc/other_forms_bloc.dart';
import 'package:global_advice_new/features/home/presentation/manager/property_data_bloc/property_data_bloc.dart';
import 'package:global_advice_new/features/home/presentation/manager/property_insurance.dart/property_insurance_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/service/bloc_observer.dart';
import 'core/utils/translation_provider.dart';
import 'features/auth/presentation/manager/login_bloc/login_bloc.dart';
import 'features/auth/presentation/manager/register_bloc/register_bloc.dart';
import 'features/auth/presentation/manager/reset_password_bloc/bloc/reset_password_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'features/home/presentation/manager/car_data_bloc/car_data_bloc.dart';
import 'features/home/presentation/manager/health_data/health_data_bloc.dart';
import 'features/home/presentation/manager/health_policy/health_policy_bloc.dart';
import 'features/home/presentation/manager/property_policy/property_policy_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await ServerLocator().init();
  Bloc.observer = MyBlocObserver();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final isArabic = prefs.getBool("is_arabic") ?? false;
  final uid_success = prefs.getString("user_uid");
  final isLogin = uid_success == null;
  //get storage

  print(isLogin);
  print(uid_success);

  runApp(
    MyApp(
      isArabic: isArabic,
      isLogin: isLogin,
      uid_success: uid_success,
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp(
      {super.key,
      required this.isArabic,
      required this.isLogin,
      required this.uid_success});

  final bool isArabic;
  final bool isLogin;
  final String? uid_success;

  @override
  Widget build(BuildContext context) {
    ConfigSize().init(context);
    return MultiProvider(
        providers: [
          BlocProvider(
            create: (context) => getIt<RegisterBloc>(),
          ),
          BlocProvider(
            create: (context) => getIt<LoginBloc>(),
          ),
          BlocProvider(
            create: (context) => getIt<ResetPasswordBloc>(),
          ),
          BlocProvider(
            create: (context) => getIt<HealthinsuranceBloc>(),
          ),
          BlocProvider(
            create: (context) => getIt<CarinsuranceBloc>(),
          ),
          BlocProvider(
            create: (context) => getIt<LifeInsuranceBloc>(),
          ),
          BlocProvider(
            create: (context) => getIt<PropertyInsuranceBloc>(),
          ),
          BlocProvider(
            create: (context) => getIt<LifeInsuranceBloc>(),
          ),
          BlocProvider(
            create: (context) => getIt<OtherInsuranceBloc>(),
          ),
          BlocProvider(
            create: (context) => getIt<PropertyInsuranceBloc>(),
          ),
          BlocProvider(
            create: (context) => getIt<CarDataBloc>(),
          ),
          BlocProvider(
            create: (context) => getIt<PropertyDataBloc>(),
          ),
          BlocProvider(
            create: (context) => getIt<CarPolicyBloc>(),
          ),
          BlocProvider(
            create: (context) => getIt<PropertyPolicyBloc>(),
          ),
          BlocProvider(
            create: (context) => getIt<HealthDataBloc>(),
          ),
          BlocProvider(
            create: (context) => getIt<HealthPolicyBloc>(),
          ),

          ChangeNotifierProvider(
              create: (_) => TranslationProvider(
                  isArabic)), //isLogin, uid_success ?? 'none'
        ],
        child: Consumer<TranslationProvider>(
          builder: (context, translate, child) {
            return MaterialApp(
              title: 'Be sure!',
              debugShowCheckedModeBanner: false,
              locale: translate.locale,
              // Set initial locale
              supportedLocales: [
                const Locale('en', ''),
                const Locale('ar', ''),
              ],
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate
              ],
              theme: ThemeData(
                canvasColor: Colors
                    .white, // Change this to adjust dropdown background color
                fontFamily: FontLoader.getFontFamily(translate.locale),
                textTheme: GoogleFonts.poppinsTextTheme(),
              ),
              navigatorKey: getIt<NavigationService>().navigatorKey,
              onGenerateRoute: RouteGenerator.getRoute,
              localeResolutionCallback: (locale, supportedLocales) {
                for (var supportedLocale in supportedLocales) {
                  if (supportedLocale.languageCode == locale!.languageCode) {
                    return supportedLocale;
                  }
                }
                return supportedLocales.first;
              },
              home: Provider.value(
                value: isLogin,
                child: isLogin ? const LoginScreen() : const HomeScreen(),
              ),
            );
          },
        ));
  }
}
