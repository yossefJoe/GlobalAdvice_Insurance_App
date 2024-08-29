class HealthPolicyrequest {
  String? uID;
  int? organizationId;
  int? planId;
  List<dynamic>? price;
  List<String>? relations;
  List<int>? age;
  List<String>? name;
  List<String>? gender;

  HealthPolicyrequest({
    this.uID,
    this.organizationId,
    this.planId,
    this.price,
    this.relations,
    this.age,
    this.name,
    this.gender,
  });

  HealthPolicyrequest.fromJson(Map<String, dynamic> json) {
    uID = json['UID'];
    organizationId = json['organization_id'];
    planId = json['plan_id'];
    price = json['price'];
    relations = json['relations'];
    age = json['age'];
    name = json['name'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UID'] = this.uID;
    data['organization_id'] = this.organizationId;
    data['plan_id'] = this.planId;
    data['price'] = this.price;
    data['relations'] = this.relations;
    data['age'] = this.age;
    data['name'] = this.name;
    data['gender'] = this.gender;
    return data;
  }
}
