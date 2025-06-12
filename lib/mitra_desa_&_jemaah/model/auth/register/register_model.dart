import 'dart:io';

class RegisterModel {
  String? email;
  String? password;
  String? name;
  String? noTelp;
  File? imgKtp;
  File? imgKk;
  File? imgPassport;
  File? imgVaksin;
  String? nik;
  String? address;
  File? imgPasFoto;
  File? imgBpjsKesehatan;
  String? idKabupaten;
  String? idKecamatan;
  String? idProvinsi;
  String? idKelurahan;
  String? dob;

  RegisterModel(
      {this.email,
      this.password,
      this.name,
      this.noTelp,
      this.imgKtp,
      this.imgKk,
      this.imgPassport,
      this.imgVaksin,
      this.nik,
      this.address,
      this.imgPasFoto,
      this.imgBpjsKesehatan,
      this.dob,
      this.idKabupaten,
      this.idKecamatan,
      this.idProvinsi,
      this.idKelurahan
      });

  RegisterModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    name = json['name'];
    noTelp = json['no_telp'];
    imgKtp = json['img_ktp'];
    imgKk = json['img_kk'];
    imgPassport = json['img_passport'];
    imgVaksin = json['img_vaksin'];
    nik = json['nik'];
    address = json['address'];
    imgPasFoto = json['img_pas_foto'];
    imgBpjsKesehatan = json['img_bpjs_kesehatan'];
    dob = json['dob'];
    idKabupaten = json['id_kabupaten'];
    idKecamatan = json['id_kecamatan'];
    idProvinsi = json['id_provinsi'];
    idKelurahan = json['id_kelurahan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    data['name'] = name;
    data['no_telp'] = noTelp;
    data['img_ktp'] = imgKtp;
    data['img_kk'] = imgKk;
    data['img_passport'] = imgPassport;
    data['img_vaksin'] = imgVaksin;
    data['nik'] = nik;
    data['address'] = address;
    data['img_pas_foto'] = imgPasFoto;
    data['img_bpjs_kesehatan'] = imgBpjsKesehatan;
    data['dob'] = dob;
    data['id_kabupaten'] = idKabupaten;
    data['id_kecamatan'] = idKecamatan;
    data['id_provinsi'] = idProvinsi;
    data['id_kelurahan'] = idKelurahan;
    return data;
  }
}
