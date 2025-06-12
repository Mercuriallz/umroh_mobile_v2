class ListAreaManagerModel {
  int? status;
  bool? error;
  List<DataListAreaManager>? data;
  String? message;

  ListAreaManagerModel({this.status, this.error, this.data, this.message});

  ListAreaManagerModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    error = json['error'];
    if (json['data'] != null) {
      data = <DataListAreaManager>[];
      json['data'].forEach((v) {
        data!.add(DataListAreaManager.fromJson(v));
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

class DataListAreaManager {
  String? nama;
  String? username;
  int? idProvinsi;
  int? idKabupaten;
  WProvinsi? wProvinsi;
  WProvinsi? wKabupaten;

  DataListAreaManager(
      {this.nama,
      this.username,
      this.idProvinsi,
      this.idKabupaten,
      this.wProvinsi,
      this.wKabupaten});

  DataListAreaManager.fromJson(Map<String, dynamic> json) {
    nama = json['nama'];
    username = json['username'];
    idProvinsi = json['id_provinsi'];
    idKabupaten = json['id_kabupaten'];
    wProvinsi = json['w_provinsi'] != null
        ? WProvinsi.fromJson(json['w_provinsi'])
        : null;
    wKabupaten = json['w_kabupaten'] != null
        ? WProvinsi.fromJson(json['w_kabupaten'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nama'] = nama;
    data['username'] = username;
    data['id_provinsi'] = idProvinsi;
    data['id_kabupaten'] = idKabupaten;
    if (wProvinsi != null) {
      data['w_provinsi'] = wProvinsi!.toJson();
    }
    if (wKabupaten != null) {
      data['w_kabupaten'] = wKabupaten!.toJson();
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