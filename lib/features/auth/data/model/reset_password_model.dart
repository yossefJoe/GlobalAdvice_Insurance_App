class ResetPasswordModel {
  int? status;
  String? statusText;
  String? error;
  String? message;
  ResetEmail? data;

  ResetPasswordModel(
      {this.status, this.statusText, this.error, this.message, this.data});

  ResetPasswordModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusText = json['statusText'];
    error = json['error'];
    message = json['message'];
    data = json['data'] != null ? new ResetEmail.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['statusText'] = this.statusText;
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ResetEmail {
  String? email;

  ResetEmail({this.email});

  ResetEmail.fromJson(Map<String, dynamic> json) {
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    return data;
  }
}
