class RegionalManagerModel {
  int? status;
  bool? error;
  String? token;
  DataRegionalManager? data;
  String? message;

  RegionalManagerModel(
      {this.status, this.error, this.token, this.data, this.message});

  RegionalManagerModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    error = json['error'];
    token = json['token'];
    data = json['data'] != null ? DataRegionalManager.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['error'] = error;
    data['token'] = token;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class DataRegionalManager {
  int? userId;
  String? name;
  int? idRole;
  int? idProvinsi;

  DataRegionalManager({this.userId, this.name, this.idRole, this.idProvinsi});

  DataRegionalManager.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    idRole = json['id_role'];
    idProvinsi = json['id_provinsi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['name'] = name;
    data['id_role'] = idRole;
    data['id_provinsi'] = idProvinsi;
    return data;
  }
}