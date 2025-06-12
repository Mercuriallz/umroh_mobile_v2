class LoginAreaManagerRequestModel {
  String? username;
  String? password;

  LoginAreaManagerRequestModel({this.username, this.password});

  LoginAreaManagerRequestModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    return data;
  }
}