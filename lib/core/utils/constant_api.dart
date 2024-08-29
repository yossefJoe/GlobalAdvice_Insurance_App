class ConstantApi {
  static const String baseUrl = 'https://dev.exabytellc.com/APIs/GAIB/';
  static const String register = "${baseUrl}client/access/register";
  static const String login = "${baseUrl}client/access/login";
  static const String resetPassword = "${baseUrl}client/access/reset-password";
  static const String healthInsurance =
      "${baseUrl}client/health/quick-quotation";
  static const String lifeInsurance = "${baseUrl}client/life/send";
  static const String form = "${baseUrl}client/form";
  static const String property = "${baseUrl}client/home/quick-quotation";
  static const String property_dependencies =
      "${baseUrl}client/home/dependants";
  static const String car_dependencies = "${baseUrl}client/motor2/dependants";
  static const String car = "${baseUrl}client/motor2/quick-quotation";
  static const String carpolicy = "${baseUrl}client/motor2/request";
  static const String propertypolicy = "${baseUrl}client/home/request";
  static const String healthdata = "${baseUrl}client/health/dependants";
  static const String healthpolicy = "${baseUrl}client/health/request";
}
