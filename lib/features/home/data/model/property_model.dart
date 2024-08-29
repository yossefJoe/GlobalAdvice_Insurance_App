class PropertyModel {
  String? uid;
  int? buildingPrice;
  int? contentPrice;
  int? tenantPrice;
  String? type;
  List<int>? homeBenefits;
  int? phone;

  PropertyModel({
    this.uid,
    this.buildingPrice,
    this.contentPrice,
    this.type,
    this.homeBenefits,
    this.phone,
    this.tenantPrice,
  });
  PropertyModel.fromJson(Map<String, dynamic> json) {
    uid = json['UID'];
    buildingPrice = json['buildingPrice'];
    contentPrice = json['contentPrice'];
    type = json['type'];
    homeBenefits = json['homeBenefits'];
    phone = json['phone'];
    phone = json['phone'];
  }

  // Method to convert the instance to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UID'] = this.uid;
    data['buildingPrice'] = this.buildingPrice;
    data['contentPrice'] = this.contentPrice;
    data['type'] = this.type;
    data['homeBenefits'] = this.homeBenefits;
    data['tenantPrice'] = this.tenantPrice;
    data['phone'] = this.phone;

    return data;
  }
}
