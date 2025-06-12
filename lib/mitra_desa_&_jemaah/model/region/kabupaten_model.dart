class KabupatenModel {
  String? message;
  int? status;
  bool? error;
  List<DataKabupaten>? data;

  KabupatenModel({this.message, this.status, this.error, this.data});

  KabupatenModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    error = json['error'];
    if (json['data'] != null) {
      data = <DataKabupaten>[];
      json['data'].forEach((v) {
        data!.add(DataKabupaten.fromJson(v));
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

class DataKabupaten {
  int? kabupatenId;
  int? provinsiId;
  String? name;
  String? altName;
  String? latitude;
  String? longitude;

  DataKabupaten(
      {this.kabupatenId,
      this.provinsiId,
      this.name,
      this.altName,
      this.latitude,
      this.longitude});

  DataKabupaten.fromJson(Map<String, dynamic> json) {
    kabupatenId = json['kabupaten_id'];
    provinsiId = json['provinsi_id'];
    name = json['name'];
    altName = json['alt_name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kabupaten_id'] = kabupatenId;
    data['provinsi_id'] = provinsiId;
    data['name'] = name;
    data['alt_name'] = altName;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}