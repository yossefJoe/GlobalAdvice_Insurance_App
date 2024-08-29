class LoginModel {
  int? id;
  String? name;
  String? birthdate;
  String? gender;
  String? email;
  String? telephone;
  int? banned;
  int? deleted;
  String? addstamp;
  String? updatestamp;
  String? password;
  bool? isAuthenticated;
  String? token;
  DateTime? expiresOn;
  DateTime? refreshTokenExpiration;

  LoginModel({
    this.id,
    this.password,
    this.name,
    this.birthdate,
    this.gender,
    this.email,
    this.telephone,
    this.banned,
    this.deleted,
    this.addstamp,
    this.updatestamp,
    this.isAuthenticated,
    this.token,
    this.expiresOn,
    this.refreshTokenExpiration,
  });

  LoginModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    password = json['password'];
    name = json['name'];
    birthdate = json['birthdate'];
    gender = json['gender'];
    email = json['email'];
    telephone = json['telephone'];
    banned = json['banned'];
    deleted = json['deleted'];
    addstamp = json['addstamp'];
    updatestamp = json['updatestamp'];
    isAuthenticated = json['isAuthenticated'];
    token = json['token'];
    expiresOn = json['expiresOn'];
    refreshTokenExpiration = json['refreshTokenExpiration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['password'] = this.password;
    data['name'] = this.name;
    data['birthdate'] = this.birthdate;
    data['gender'] = this.gender;
    data['email'] = this.email;
    data['telephone'] = this.telephone;
    data['banned'] = this.banned;
    data['deleted'] = this.deleted;
    data['addstamp'] = this.addstamp;
    data['updatestamp'] = this.updatestamp;
    data['isAuthenticated'] = this.isAuthenticated;
    data['token'] = this.token;
    data['expiresOn'] = this.expiresOn;
    data['refreshTokenExpiration'] = this.refreshTokenExpiration;
    return data;
  }
}
