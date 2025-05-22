class SelfTransactionModel {
  int? status;
  bool? error;
  List<DataTransaction>? dataTransaction;
  DataPay? dataPay;
  TPaket? dataPaket;
  String? message;

  SelfTransactionModel(
      {this.status,
      this.error,
      this.dataTransaction,
      this.dataPay,
      this.dataPaket,
      this.message});

  SelfTransactionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    error = json['error'];
    if (json['data_transaction'] != null) {
      dataTransaction = <DataTransaction>[];
      json['data_transaction'].forEach((v) {
        dataTransaction!.add(DataTransaction.fromJson(v));
      });
    }
    dataPay =
        json['data_pay'] != null ? DataPay.fromJson(json['data_pay']) : null;
    dataPaket =
        json['data_paket'] != null ? TPaket.fromJson(json['data_paket']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['error'] = error;
    if (dataTransaction != null) {
      data['data_transaction'] =
          dataTransaction!.map((v) => v.toJson()).toList();
    }
    if (dataPay != null) {
      data['data_pay'] = dataPay!.toJson();
    }
    if (dataPaket != null) {
      data['data_paket'] = dataPaket!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class DataTransaction {
  int? id;
  String? trxPay;
  int? userId;
  int? paketId;
  int? trxId;
  String? amount;
  String? typePayment;
  String? typeVa;
  String? targetCompleted;
  int? statusPay;
  String? notes;
  String? details;
  String? payAt;
  String? payTime;
  List<int>? userInsert;
  String? trxInv;
  String? vaNumber;
  TPaket? tPaket;
  UserPendaftar? userPendaftar;

  DataTransaction(
      {this.id,
      this.trxPay,
      this.userId,
      this.paketId,
      this.trxId,
      this.amount,
      this.typePayment,
      this.typeVa,
      this.targetCompleted,
      this.statusPay,
      this.notes,
      this.details,
      this.payAt,
      this.payTime,
      this.userInsert,
      this.trxInv,
      this.vaNumber,
      this.tPaket,
      this.userPendaftar});

  DataTransaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    trxPay = json['trx_pay'];
    userId = json['user_id'];
    paketId = json['paket_id'];
    trxId = json['trx_id'];
    amount = json['amount'];
    typePayment = json['type_payment'];
    typeVa = json['type_va'];
    targetCompleted = json['target_completed'];
    statusPay = json['status_pay'];
    notes = json['notes'];
    details = json['details'];
    payAt = json['pay_at'];
    payTime = json['pay_time'];
    userInsert = json['user_insert'] != null
        ? List<int>.from(json['user_insert'])
        : null;
    trxInv = json['trx_inv'];
    vaNumber = json['va_number'];
    tPaket = json['t_paket'] != null ? TPaket.fromJson(json['t_paket']) : null;
    userPendaftar = json['user_pendaftar'] != null
        ? UserPendaftar.fromJson(json['user_pendaftar'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['trx_pay'] = trxPay;
    data['user_id'] = userId;
    data['paket_id'] = paketId;
    data['trx_id'] = trxId;
    data['amount'] = amount;
    data['type_payment'] = typePayment;
    data['type_va'] = typeVa;
    data['target_completed'] = targetCompleted;
    data['status_pay'] = statusPay;
    data['notes'] = notes;
    data['details'] = details;
    data['pay_at'] = payAt;
    data['pay_time'] = payTime;
    data['user_insert'] = userInsert;
    data['trx_inv'] = trxInv;
    data['va_number'] = vaNumber;
    if (tPaket != null) {
      data['t_paket'] = tPaket!.toJson();
    }
    if (userPendaftar != null) {
      data['user_pendaftar'] = userPendaftar!.toJson();
    }
    return data;
  }
}

class TPaket {
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

  TPaket(
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
      this.airportId});

  TPaket.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}

class UserPendaftar {
  int? userId;
  String? name;

  UserPendaftar({this.userId, this.name});

  UserPendaftar.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['name'] = name;
    return data;
  }
}

class DataPay {
  int? totalPayment;
  String? targetCompleted;
  String? percentangePayment;

  DataPay({this.totalPayment, this.targetCompleted, this.percentangePayment});

  DataPay.fromJson(Map<String, dynamic> json) {
    totalPayment = json['total_payment'];
    targetCompleted = json['target_completed'];
    percentangePayment = json['percentange_payment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_payment'] = totalPayment;
    data['target_completed'] = targetCompleted;
    data['percentange_payment'] = percentangePayment;
    return data;
  }
}
