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
  String? kodePaket;
  int? airplaneTypeId;
  int? airportId;
  String? notes;
  List<TPaketFasilitas>? tPaketFasilitas;
  List<THotel>? tHotel;

  AirplaneType? airplaneType;
  Airport? airport;

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
      this.kodePaket,
      this.airplaneTypeId,
      this.airportId,
      this.notes,
      this.tPaketFasilitas,
      this.tHotel,
      this.airplaneType,
      this.airport});

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
    kodePaket = json['kode_paket'];
    airplaneTypeId = json['airplane_type_id'];
    airportId = json['airport_id'];
    notes = json['notes'];
    if (json['t_paket_fasilitas'] != null) {
      tPaketFasilitas = <TPaketFasilitas>[];
      json['t_paket_fasilitas'].forEach((v) {
        tPaketFasilitas!.add(TPaketFasilitas.fromJson(v));
      });
    }
    if (json['t_hotel'] != null) {
      tHotel = <THotel>[];
      json['t_hotel'].forEach((v) {
        tHotel!.add(THotel.fromJson(v));
      });
    }

    airplaneType = json['airplane_type'] != null
        ? AirplaneType.fromJson(json['airplane_type'])
        : null;
    airport =
        json['airport'] != null ? Airport.fromJson(json['airport']) : null;
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
    if (tPaketFasilitas != null) {
      data['t_paket_fasilitas'] =
          tPaketFasilitas!.map((v) => v.toJson()).toList();
    }
    if (tHotel != null) {
      data['t_hotel'] = tHotel!.map((v) => v.toJson()).toList();
    }

    if (airplaneType != null) {
      data['airplane_type'] = airplaneType!.toJson();
    }
    if (airport != null) {
      data['airport'] = airport!.toJson();
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

class THotel {
  int? hotelId;
  String? name;
  int? rate;
  String? address;
  List<String>? additionalInfo;
  bool? isUpgradable;
  String? priceUpgrade;
  String? imgThumbnail;
  String? createdAt;
  int? paketId;

  THotel(
      {this.hotelId,
      this.name,
      this.rate,
      this.address,
      this.additionalInfo,
      this.isUpgradable,
      this.priceUpgrade,
      this.imgThumbnail,
      this.createdAt,
      this.paketId});

  THotel.fromJson(Map<String, dynamic> json) {
    hotelId = json['hotel_id'];
    name = json['name'];
    rate = json['rate'];
    address = json['address'];
    additionalInfo = json['additional_info'].cast<String>();
    isUpgradable = json['is_upgradable'];
    priceUpgrade = json['price_upgrade'];
    imgThumbnail = json['img_thumbnail'];
    createdAt = json['created_at'];
    paketId = json['paket_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hotel_id'] = hotelId;
    data['name'] = name;
    data['rate'] = rate;
    data['address'] = address;
    data['additional_info'] = additionalInfo;
    data['is_upgradable'] = isUpgradable;
    data['price_upgrade'] = priceUpgrade;
    data['img_thumbnail'] = imgThumbnail;
    data['created_at'] = createdAt;
    data['paket_id'] = paketId;
    return data;
  }
}

class AirplaneType {
  int? id;
  String? airplaneCode;
  String? airplaneName;
  String? createdAt;

  AirplaneType({this.id, this.airplaneCode, this.airplaneName, this.createdAt});

  AirplaneType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    airplaneCode = json['airplane_code'];
    airplaneName = json['airplane_name'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['airplane_code'] = airplaneCode;
    data['airplane_name'] = airplaneName;
    data['created_at'] = createdAt;
    return data;
  }
}

class Airport {
  int? id;
  String? airportCode;
  String? airportName;
  String? createdAt;

  Airport({this.id, this.airportCode, this.airportName, this.createdAt});

  Airport.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    airportCode = json['airport_code'];
    airportName = json['airport_name'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['airport_code'] = airportCode;
    data['airport_name'] = airportName;
    data['created_at'] = createdAt;
    return data;
  }
}
