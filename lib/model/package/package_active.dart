class PackageActiveModel {
  int? status;
  bool? error;
  List<DataPackageActive>? data;
  String? message;

  PackageActiveModel({this.status, this.error, this.data, this.message});

  PackageActiveModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    error = json['error'];
    if (json['data'] != null) {
      data = <DataPackageActive>[];
      json['data'].forEach((v) {
        data!.add(DataPackageActive.fromJson(v));
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

class DataPackageActive {
  int? paketId;
  String? namaPaket;
  String? desc;
  String? harga;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  String? durasiPerjalanan;
  String? jadwalPerjalanan;
  int? typePaket;
  List<String>? arrFeature;
  String? imgThumbnail;
  bool? isVip;
  int? planeSeat;
  String? kodePaket;
  int? airplaneTypeId;
  int? airportId;
  String? notes;
  int? isShow;
  int? isFull;

  DataPackageActive(
      {this.paketId,
      this.namaPaket,
      this.desc,
      this.harga,
      this.isActive,
      this.createdAt,
      this.updatedAt,
      this.durasiPerjalanan,
      this.jadwalPerjalanan,
      this.typePaket,
      this.arrFeature,
      this.imgThumbnail,
      this.isVip,
      this.planeSeat,
      this.kodePaket,
      this.airplaneTypeId,
      this.airportId,
      this.notes,
      this.isShow,
      this.isFull});

  DataPackageActive.fromJson(Map<String, dynamic> json) {
    paketId = json['paket_id'];
    namaPaket = json['nama_paket'];
    desc = json['desc'];
    harga = json['harga'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    durasiPerjalanan = json['durasi_perjalanan'];
    jadwalPerjalanan = json['jadwal_perjalanan'];
    typePaket = json['type_paket'];
    arrFeature = json['arr_feature'].cast<String>();
    imgThumbnail = json['img_thumbnail'];
    isVip = json['is_vip'];
    planeSeat = json['plane_seat'];
    kodePaket = json['kode_paket'];
    airplaneTypeId = json['airplane_type_id'];
    airportId = json['airport_id'];
    notes = json['notes'];
    isShow = json['is_show'];
    isFull = json['is_full'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['paket_id'] = paketId;
    data['nama_paket'] = namaPaket;
    data['desc'] = desc;
    data['harga'] = harga;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['durasi_perjalanan'] = durasiPerjalanan;
    data['jadwal_perjalanan'] = jadwalPerjalanan;
    data['type_paket'] = typePaket;
    data['arr_feature'] = arrFeature;
    data['img_thumbnail'] = imgThumbnail;
    data['is_vip'] = isVip;
    data['plane_seat'] = planeSeat;
    data['kode_paket'] = kodePaket;
    data['airplane_type_id'] = airplaneTypeId;
    data['airport_id'] = airportId;
    data['notes'] = notes;
    data['is_show'] = isShow;
    data['is_full'] = isFull;
    return data;
  }
}