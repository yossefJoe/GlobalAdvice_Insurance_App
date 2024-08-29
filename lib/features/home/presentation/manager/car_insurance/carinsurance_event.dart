abstract class ResetEvent {}

class CarInsuranceBlocEvent extends ResetEvent {
  String? uid;
  int? price;
  String? isLicensed;
  int? motorBrands;
  int? motorDeductibles;
  int? motorManufactureYear;
  int? phone;
  CarInsuranceBlocEvent({
    this.uid,
    this.price,
    this.isLicensed,
    this.motorBrands,
    this.motorDeductibles,
    this.motorManufactureYear,
    this.phone,
  });
}
