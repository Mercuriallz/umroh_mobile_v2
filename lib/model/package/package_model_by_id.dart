class PackageModelById {
  int? status;
  String? message;
  bool? error;
  DataPackageById? data;

  PackageModelById({this.status, this.message, this.error, this.data});

  PackageModelById.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    error = json['error'];
    data = json['data'] != null ? DataPackageById.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['error'] = error;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DataPackageById {
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
  List<TPaketFasilitas>? tPaketFasilitas;

  DataPackageById(
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
      this.tPaketFasilitas});

  DataPackageById.fromJson(Map<String, dynamic> json) {
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
    if (json['t_paket_fasilitas'] != null) {
      tPaketFasilitas = <TPaketFasilitas>[];
      json['t_paket_fasilitas'].forEach((v) {
        tPaketFasilitas!.add(TPaketFasilitas.fromJson(v));
      });
    }
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
    if (tPaketFasilitas != null) {
      data['t_paket_fasilitas'] =
          tPaketFasilitas!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TPaketFasilitas {
  int? fasilitasId;
  int? paketId;
  String? desc;
  String? createdAt;

  TPaketFasilitas({this.fasilitasId, this.paketId, this.desc, this.createdAt});

  TPaketFasilitas.fromJson(Map<String, dynamic> json) {
    fasilitasId = json['fasilitas_id'];
    paketId = json['paket_id'];
    desc = json['desc'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fasilitas_id'] = fasilitasId;
    data['paket_id'] = paketId;
    data['desc'] = desc;
    data['created_at'] = createdAt;
    return data;
  }
}