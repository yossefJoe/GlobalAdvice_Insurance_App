import 'package:flutter/material.dart';
import 'package:global_advice_new/features/auth/presentation/component/create_account/create_account_screen.dart';
import 'package:global_advice_new/features/auth/presentation/login_screen.dart';
import 'package:global_advice_new/features/home/presentation/component/card_screen/card_screen.dart';
import 'package:global_advice_new/features/profile/presentation/component/edit_my_profile/edit_my_profile_screen.dart';
import 'package:global_advice_new/features/profile/presentation/profile_screen.dart';

import 'package:global_advice_new/features/home/presentation/home_screen.dart';

class Routes {
  static const String login = "/LoginScreen";
  static const String createAccount = "/CreateAccount";
  static const String addDogInfoScreen = "/AddDogInfoScreen";
  static const String addDogImagesScreen = "/AddDogImagesScreen";
  static const String forgetPasswordScreen = "/ForgetPasswordScreen";
  static const String otpScreen = "/OtpScreen";
  static const String changePasswordScreen = "/ChangePasswordScreen";
  static const String homeScreen = "/HomeScreen";
  static const String serviceType = "/ServiceType";
  static const String matchingRequestScreen = "/MatchingRequestScreen";
  static const String editMyProfileScreen = "/EditMyProfileScreen";
  static const String editDogProfileScreen = "/EditDogProfileScreen";
  static const String propertyForm2 = "/PropertyForm2";
  static const String propertyForm3 = "/PropertyForm3";
  static const String pricespage = "/PricesPage";
  static const String profile = "/Profile";
  static const String editProfile = "/EditProfile";
  static const String plans = "/Plans";
}

class RouteGenerator {
  static String currentContext = '';

  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.login:
        currentContext = Routes.login;
        return MaterialPageRoute(
            settings: settings, builder: (_) => const LoginScreen());
//gfggfgff
      case Routes.homeScreen:
        currentContext = Routes.homeScreen;
        return MaterialPageRoute(
            settings: settings, builder: (_) => const HomeScreen());
      case Routes.createAccount:
        currentContext = Routes.createAccount;
        return MaterialPageRoute(
            settings: settings, builder: (_) => const CreateAccount());

      case Routes.profile:
        currentContext = Routes.profile;
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ProfileScreen());
      case Routes.editProfile:
        currentContext = Routes.editProfile;
        return MaterialPageRoute(
            settings: settings, builder: (_) => const EditMyProfileScreen());
      case Routes.plans:
        currentContext = Routes.plans;
        return MaterialPageRoute(
            settings: settings, builder: (_) => const CardScreen());
    }
    return unDefinedRoute();
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (context) => Container(),
    );
  }
}
