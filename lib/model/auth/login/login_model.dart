class LoginModel {
  int? status;
  String? message;
  bool? error;
  DataLogin? data;
  String? token;

  LoginModel({this.status, this.message, this.error, this.data, this.token});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    error = json['error'];
    data = json['data'] != null ? DataLogin.fromJson(json['data']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['error'] = error;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['token'] = token;
    return data;
  }
}

class DataLogin {
  int? userId;
  String? email;
  String? name;
  String? noTelp;
  int? roleId;

  DataLogin({this.userId, this.email, this.name, this.noTelp, this.roleId});

  DataLogin.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    email = json['email'];
    name = json['name'];
    noTelp = json['no_telp'];
    roleId = json['role_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['email'] = email;
    data['name'] = name;
    data['no_telp'] = noTelp;
    data['role_id'] = roleId;
    return data;
  }
}