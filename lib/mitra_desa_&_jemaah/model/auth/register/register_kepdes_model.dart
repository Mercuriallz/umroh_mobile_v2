class RegisterKepdesModel {
  String? username;
  String? name;
  String? password;
  String? idProvinsi;
  String? idKabupaten;
  String? idKecamatan;
  String? idKelurahan;

  RegisterKepdesModel(
      {this.username,
      this.name,
      this.password,
      this.idProvinsi,
      this.idKabupaten,
      this.idKecamatan,
      this.idKelurahan});

  RegisterKepdesModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    name = json['name'];
    password = json['password'];
    idProvinsi = json['id_provinsi'];
    idKabupaten = json['id_kabupaten'];
    idKecamatan = json['id_kecamatan'];
    idKelurahan = json['id_kelurahan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['name'] = name;
    data['password'] = password;
    data['id_provinsi'] = idProvinsi;
    data['id_kabupaten'] = idKabupaten;
    data['id_kecamatan'] = idKecamatan;
    data['id_kelurahan'] = idKelurahan;
    return data;
  }
}