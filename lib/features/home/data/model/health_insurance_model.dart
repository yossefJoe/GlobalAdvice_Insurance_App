class HealthInsuranceModel {
  String? uid;
  List<String>? name;
  List<int>? age;
  late List<String>? relation;
  String? gender;
  int? healthLimit;
  String? phone;

  HealthInsuranceModel({
    this.uid,
    this.name,
    this.age,
    required this.relation,
    required this.gender,
    this.healthLimit,
    this.phone,
  });

  HealthInsuranceModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    age = json['age'];
    relation = json['relation'] ?? [];
    gender = json['gender'] ?? [];
    healthLimit = json['healthLimit'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['name'] = this.name;
    data['age'] = this.age;
    data['relation'] = this.relation;
    data['gender'] = this.gender;
    data['healthLimit'] = this.healthLimit;
    data['phone'] = this.phone;
    return data;
  }
}
