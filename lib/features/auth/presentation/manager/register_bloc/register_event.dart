abstract class BaseSignupEvent {}

class RegisterEvent extends BaseSignupEvent {
  final String email;
  final String password;
  final String name;
  final String telephone;

  RegisterEvent({
    required this.email,
    required this.password,
    required this.name,
    required this.telephone,
  });
}
