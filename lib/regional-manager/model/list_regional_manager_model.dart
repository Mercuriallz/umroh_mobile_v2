class ListRegionalManagerModel {
  int? status;
  bool? error;
  List<DataListRegionalManager>? data;
  String? message;

  ListRegionalManagerModel({this.status, this.error, this.data, this.message});

  ListRegionalManagerModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    error = json['error'];
    if (json['data'] != null) {
      data = <DataListRegionalManager>[];
      json['data'].forEach((v) {
        data!.add(DataListRegionalManager.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['error'] = error;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class DataListRegionalManager {
  String? nama;
  String? username;
  int? idProvinsi;
  WProvinsi? wProvinsi;

  DataListRegionalManager({this.nama, this.username, this.idProvinsi, this.wProvinsi});

  DataListRegionalManager.fromJson(Map<String, dynamic> json) {
    nama = json['nama'];
    username = json['username'];
    idProvinsi = json['id_provinsi'];
    wProvinsi = json['w_provinsi'] != null
        ? WProvinsi.fromJson(json['w_provinsi'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nama'] = nama;
    data['username'] = username;
    data['id_provinsi'] = idProvinsi;
    if (wProvinsi != null) {
      data['w_provinsi'] = wProvinsi!.toJson();
    }
    return data;
  }
}

class WProvinsi {
  String? name;

  WProvinsi({this.name});

  WProvinsi.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}