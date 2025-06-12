class AreaManagerModel {
  int? status;
  bool? error;
  String? token;
  DataAreaManager? data;
  String? message;

  AreaManagerModel(
      {this.status, this.error, this.token, this.data, this.message});

  AreaManagerModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    error = json['error'];
    token = json['token'];
    data = json['data'] != null ? DataAreaManager.fromJson(json['data']) : null;
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

class DataAreaManager {
  int? userId;
  String? name;
  int? idRole;
  int? idProvinsi;
  int? idKabupaten;

  DataAreaManager({this.userId, this.name, this.idRole, this.idProvinsi, this.idKabupaten});

  DataAreaManager.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    idRole = json['id_role'];
    idProvinsi = json['id_provinsi'];
    idKabupaten = json['id_kabupaten'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['name'] = name;
    data['id_role'] = idRole;
    data['id_provinsi'] = idProvinsi;
    data['id_kabupaten'] = idKabupaten;
    return data;
  }
}