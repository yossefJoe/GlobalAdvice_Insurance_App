abstract class ResetEvent {}

class CarPolicyBlocEvent extends ResetEvent {
  String? uID;
  int? organizationId;
  int? planId;
  int? price;
  String? isLicensed;
  int? motorBrands;
  int? motorDeductibles;
  int? motorManufactureYear;
  CarPolicyBlocEvent({
    this.uID,
    this.organizationId,
    this.planId,
    this.price,
    this.isLicensed,
    this.motorBrands,
    this.motorDeductibles,
    this.motorManufactureYear,
  });
}
