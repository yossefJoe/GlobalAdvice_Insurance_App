abstract class ResetEvent {}

class OtherinsuranceblocEvent extends ResetEvent {
  final String name;
  final String phonenumber;
  final String type;
  final String message;

  OtherinsuranceblocEvent({
    required this.name,
    required this.phonenumber,
    required this.type,
    required this.message,
  });
}
