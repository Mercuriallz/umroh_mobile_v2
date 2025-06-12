class KecamatanModel {
  String? message;
  int? status;
  bool? error;
  List<DataKecamatan>? data;

  KecamatanModel({this.message, this.status, this.error, this.data});

  KecamatanModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    error = json['error'];
    if (json['data'] != null) {
      data = <DataKecamatan>[];
      json['data'].forEach((v) {
        data!.add(DataKecamatan.fromJson(v));
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

class DataKecamatan {
  int? kecamatanId;
  int? kabupatenId;
  String? name;
  String? altName;
  String? latitude;
  String? longitude;

  DataKecamatan(
      {this.kecamatanId,
      this.kabupatenId,
      this.name,
      this.altName,
      this.latitude,
      this.longitude});

  DataKecamatan.fromJson(Map<String, dynamic> json) {
    kecamatanId = json['kecamatan_id'];
    kabupatenId = json['kabupaten_id'];
    name = json['name'];
    altName = json['alt_name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kecamatan_id'] = kecamatanId;
    data['kabupaten_id'] = kabupatenId;
    data['name'] = name;
    data['alt_name'] = altName;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}