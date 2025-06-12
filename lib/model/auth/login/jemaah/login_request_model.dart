class LoginRequestModel {
  String? nik;
  String? password;

  LoginRequestModel({this.nik, this.password});

  LoginRequestModel.fromJson(Map<String, dynamic> json) {
    nik = json['nik'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nik'] = nik;
    data['password'] = password;
    return data;
  }
}