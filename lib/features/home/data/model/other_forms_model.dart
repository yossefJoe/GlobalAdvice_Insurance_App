class OtherFormsModel {
  String? name;
  String? phoneNumber;
  String? type;
  String? message;

  OtherFormsModel({this.name, this.phoneNumber, this.type, this.message});

  OtherFormsModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    type = json['type'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phoneNumber'] = this.phoneNumber;
    data['type'] = this.type;
    data['message'] = this.message;
    return data;
  }
}
