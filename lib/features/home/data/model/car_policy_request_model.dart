class CarPolicyrequest {
  String? uID;
  int? organizationId;
  int? planId;
  int? price;
  String? isLicensed;
  int? motorBrands;
  int? motorDeductibles;
  int? motorManufactureYear;

  CarPolicyrequest(
      {this.uID,
      this.organizationId,
      this.planId,
      this.price,
      this.isLicensed,
      this.motorBrands,
      this.motorDeductibles,
      this.motorManufactureYear});

  CarPolicyrequest.fromJson(Map<String, dynamic> json) {
    uID = json['UID'];
    organizationId = json['organization_id'];
    planId = json['plan_id'];
    price = json['price'];
    isLicensed = json['is_licensed'];
    motorBrands = json['motorBrands'];
    motorDeductibles = json['motorDeductibles'];
    motorManufactureYear = json['motorManufactureYear'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UID'] = this.uID;
    data['organization_id'] = this.organizationId;
    data['plan_id'] = this.planId;
    data['price'] = this.price;
    data['is_licensed'] = this.isLicensed;
    data['motorBrands'] = this.motorBrands;
    data['motorDeductibles'] = this.motorDeductibles;
    data['motorManufactureYear'] = this.motorManufactureYear;
    return data;
  }
}
