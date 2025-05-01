class KelurahanModel {
  String? message;
  int? status;
  bool? error;
  List<DataKelurahan>? data;

  KelurahanModel({this.message, this.status, this.error, this.data});

  KelurahanModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    error = json['error'];
    if (json['data'] != null) {
      data = <DataKelurahan>[];
      json['data'].forEach((v) {
        data!.add(DataKelurahan.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    data['error'] = error;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataKelurahan {
  int? kelurahanId;
  int? kecamatanId;
  String? name;
  String? altName;
  String? latitude;
  String? longitude;

  DataKelurahan(
      {this.kelurahanId,
      this.kecamatanId,
      this.name,
      this.altName,
      this.latitude,
      this.longitude});

  DataKelurahan.fromJson(Map<String, dynamic> json) {
    kelurahanId = json['kelurahan_id'];
    kecamatanId = json['kecamatan_id'];
    name = json['name'];
    altName = json['alt_name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kelurahan_id'] = kelurahanId;
    data['kecamatan_id'] = kecamatanId;
    data['name'] = name;
    data['alt_name'] = altName;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}