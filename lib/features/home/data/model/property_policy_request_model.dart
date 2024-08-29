class PropertyPolicyRequestModel {
  String? uID;
  int? organizationId;
  int? planId;
  String? type;
  int? building_price;
  int? content_price;
  int? tenant_price;
  String? address;

  PropertyPolicyRequestModel(
      {this.uID,
      this.organizationId,
      this.planId,
      this.type,
      this.building_price,
      this.content_price,
      this.tenant_price,
      this.address});

  PropertyPolicyRequestModel.fromJson(Map<String, dynamic> json) {
    uID = json['UID'];
    organizationId = json['organization_id'];
    planId = json['plan_id'];
    type = json['type'];
    building_price = json['building_price'];
    content_price = json['content_price'];
    tenant_price = json['tenant_price'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UID'] = this.uID;
    data['organization_id'] = this.organizationId;
    data['plan_id'] = this.planId;
    data['type'] = this.type;
    data['building_price'] = this.building_price;
    data['content_price'] = this.content_price;
    data['tenant_price'] = this.tenant_price;
    data['address'] = this.address;
    return data;
  }
}
