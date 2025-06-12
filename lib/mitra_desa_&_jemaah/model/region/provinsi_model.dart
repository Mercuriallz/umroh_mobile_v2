class ProvinceModel {
  String? message;
  int? status;
  bool? error;
  List<DataProvince>? data;

  ProvinceModel({this.message, this.status, this.error, this.data});

  ProvinceModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    error = json['error'];
    if (json['data'] != null) {
      data = <DataProvince>[];
      json['data'].forEach((v) {
        data!.add(DataProvince.fromJson(v));
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

class DataProvince {
  int? provinsiId;
  String? name;
  String? altName;
  String? latitude;
  String? longitude;

  DataProvince(
      {this.provinsiId,
      this.name,
      this.altName,
      this.latitude,
      this.longitude});

  DataProvince.fromJson(Map<String, dynamic> json) {
    provinsiId = json['provinsi_id'];
    name = json['name'];
    altName = json['alt_name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['provinsi_id'] = provinsiId;
    data['name'] = name;
    data['alt_name'] = altName;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}