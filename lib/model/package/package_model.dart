class PackageModel {
  int? status;
  String? message;
  bool? error;
  int? totalResult;
  int? limit;
  int? totalPage;
  List<DataPackage>? data;

  PackageModel(
      {this.status,
      this.message,
      this.error,
      this.totalResult,
      this.limit,
      this.totalPage,
      this.data});

  PackageModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    error = json['error'];
    totalResult = json['total_result'];
    limit = json['limit'];
    totalPage = json['total_page'];
    if (json['data'] != null) {
      data = <DataPackage>[];
      json['data'].forEach((v) {
        data!.add(DataPackage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['error'] = error;
    data['total_result'] = totalResult;
    data['limit'] = limit;
    data['total_page'] = totalPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataPackage {
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
  List<TPaketFasilitas>? tPaketFasilitas;

  DataPackage(
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
      this.tPaketFasilitas});

  DataPackage.fromJson(Map<String, dynamic> json) {
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