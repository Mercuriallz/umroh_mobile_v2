class LoginChiefModel {
  int? status;
  bool? error;
  String? token;
  DataChief? data;
  String? message;

  LoginChiefModel(
      {this.status, this.error, this.token, this.data, this.message});

  LoginChiefModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    error = json['error'];
    token = json['token'];
    data = json['data'] != null ? DataChief.fromJson(json['data']) : null;
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

class DataChief {
  int? id;
  int? idRole;
  String? name;
  int? idProvinsi;
  int? idKabupaten;
  int? idKecamatan;
  int? idKelurahan;

  DataChief(
      {this.id,
      this.idRole,
      this.name,
      this.idProvinsi,
      this.idKabupaten,
      this.idKecamatan,
      this.idKelurahan});

  DataChief.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['id']?.toString() ?? '');
    idRole = int.tryParse(json['id_role']?.toString() ?? '');
    name = json['name'];
    idProvinsi = int.tryParse(json['id_provinsi']?.toString() ?? '');
    idKabupaten = int.tryParse(json['id_kabupaten']?.toString() ?? '');
    idKecamatan = int.tryParse(json['id_kecamatan']?.toString() ?? '');
    idKelurahan = int.tryParse(json['id_kelurahan']?.toString() ?? '');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_role'] = idRole;
    data['name'] = name;
    data['id_provinsi'] = idProvinsi;
    data['id_kabupaten'] = idKabupaten;
    data['id_kecamatan'] = idKecamatan;
    data['id_kelurahan'] = idKelurahan;
    return data;
  }
}
