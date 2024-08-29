abstract class ResetEvent {}

class PropertyPolicyblocEvent extends ResetEvent {
  String? uID;
  int? organizationId;
  int? planId;
  String? type;
  int? building_price;
  int? content_price;
  int? tenant_price;
  String? address;
  PropertyPolicyblocEvent({
    this.uID,
    this.organizationId,
    this.planId,
    this.type,
    this.building_price,
    this.content_price,
    this.tenant_price,
    this.address,
  });
}
