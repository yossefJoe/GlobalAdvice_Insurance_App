abstract class ResetEvent {}

class HealthPolicyblocEvent extends ResetEvent {
  String? uID;
  int? organizationId;
  int? planId;
  List<dynamic>? price;
  List<String>? relations;
  List<int>? age;
  List<String>? name;
  List<String>? gender;

  HealthPolicyblocEvent({
    this.uID,
    this.organizationId,
    this.planId,
    this.price,
    this.relations,
    this.age,
    this.name,
    this.gender,
  });
}
