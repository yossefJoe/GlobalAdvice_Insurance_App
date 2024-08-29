class LifeInsuranceModel {
  String? uid;
  String email;
  String name;
  String phone;
  String body;

  LifeInsuranceModel({
     this.uid,
    required this.email,
    required this.name,
    required this.phone,
    required this.body,
  });

  // Convert a JSON map to a UserModel instance
  factory LifeInsuranceModel.fromJson(Map<String, dynamic> json) {
    return LifeInsuranceModel(
      uid: json['uid'],
      email: json['email'],
      name: json['name'],
      phone: json['phone'],
      body: json['body'],
    );
  }

  // Convert a UserModel instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'phone': phone,
      'body': body,
    };
  }
}