class HealthDependincesModel {
  String? id;
  String? service;
  String? name;
  String? nameAlt;
  int? multiple;
  int? planMultiple;
  int? clientMultiple;
  int? active;
  String? addstamp;
  String? updatestamp;
  List<PlansDataValues>? plansDataValues;

  HealthDependincesModel(
      {this.id,
      this.service,
      this.name,
      this.nameAlt,
      this.multiple,
      this.planMultiple,
      this.clientMultiple,
      this.active,
      this.addstamp,
      this.updatestamp,
      this.plansDataValues});

  HealthDependincesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    service = json['service'];
    name = json['name'];
    nameAlt = json['name_alt'];
    multiple = json['multiple'];
    planMultiple = json['plan_multiple'];
    clientMultiple = json['client_multiple'];
    active = json['active'];
    addstamp = json['addstamp'];
    updatestamp = json['updatestamp'];
    if (json['plans_data_values'] != null) {
      plansDataValues = <PlansDataValues>[];
      json['plans_data_values'].forEach((v) {
        plansDataValues!.add(new PlansDataValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['service'] = this.service;
    data['name'] = this.name;
    data['name_alt'] = this.nameAlt;
    data['multiple'] = this.multiple;
    data['plan_multiple'] = this.planMultiple;
    data['client_multiple'] = this.clientMultiple;
    data['active'] = this.active;
    data['addstamp'] = this.addstamp;
    data['updatestamp'] = this.updatestamp;
    if (this.plansDataValues != null) {
      data['plans_data_values'] =
          this.plansDataValues!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PlansDataValues {
  int? id;
  String? dataId;
  String? name;
  String? nameAlt;
  String? value;
  int? alwaysChecked;
  int? orderBy;
  int? active;
  String? addstamp;
  String? updatestamp;

  PlansDataValues(
      {this.id,
      this.dataId,
      this.name,
      this.nameAlt,
      this.value,
      this.alwaysChecked,
      this.orderBy,
      this.active,
      this.addstamp,
      this.updatestamp});

  PlansDataValues.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dataId = json['data_id'];
    name = json['name'];
    nameAlt = json['name_alt'];
    value = json['value'];
    alwaysChecked = json['always_checked'];
    orderBy = json['order_by'];
    active = json['active'];
    addstamp = json['addstamp'];
    updatestamp = json['updatestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['data_id'] = this.dataId;
    data['name'] = this.name;
    data['name_alt'] = this.nameAlt;
    data['value'] = this.value;
    data['always_checked'] = this.alwaysChecked;
    data['order_by'] = this.orderBy;
    data['active'] = this.active;
    data['addstamp'] = this.addstamp;
    data['updatestamp'] = this.updatestamp;
    return data;
  }
}

class CurrPlansData {
  int? planId;
  int? planDataValueId;

  CurrPlansData({this.planId, this.planDataValueId});

  CurrPlansData.fromJson(Map<String, dynamic> json) {
    planId = json['plan_id'];
    planDataValueId = json['plan_data_value_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['plan_id'] = this.planId;
    data['plan_data_value_id'] = this.planDataValueId;
    return data;
  }
}
