class CarInusranceRequest {
  String? uid;
  int? price;
  String? isLicensed;
  int? motorBrands;
  int? motorDeductibles;
  int? motorManufactureYear;
  int? phone;

  // Constructor
  CarInusranceRequest({
    required this.uid,
    required this.price,
    required this.isLicensed,
    required this.motorBrands,
    required this.motorDeductibles,
    required this.motorManufactureYear,
    required this.phone,
  });

  // Factory method to create an instance from JSON
  CarInusranceRequest.fromJson(Map<String, dynamic> json) {
    uid = json['UID'];
    price = json['price'];
    isLicensed = json['is_licensed']; // Convert 1 to true
    motorBrands = json['motorBrands'];
    motorDeductibles = json['motorDeductibles'];
    motorManufactureYear = json['motorManufactureYear'];
    phone = json['phone'];
  }

  // Method to convert the instance to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UID'] = this.uid;
    data['price'] = this.price;
    data['islicensed'] = this.isLicensed;
    data['motorbrands'] = this.motorBrands;
    data['motordeductibles'] = this.motorDeductibles;
    data['motormanufactureyear'] = this.motorManufactureYear;
    data['phone'] = this.phone;

    return data;
  }
}
