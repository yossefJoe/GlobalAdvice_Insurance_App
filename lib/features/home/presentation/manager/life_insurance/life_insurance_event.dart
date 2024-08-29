abstract class ResetEvent {}

class LifeInsuranceBlocEvent extends ResetEvent {
  final String? uid;
  final String email;
  final String name;
  final String phone;
  final String body;

  LifeInsuranceBlocEvent({
     this.uid,
    required this.email,
    required this.name,
    required this.phone,
    required this.body,
  });
}
