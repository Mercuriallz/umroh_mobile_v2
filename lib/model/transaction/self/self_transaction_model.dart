class SelfTransactionModel {
  int? status;
  bool? error;
  DataTransaction? data;
  String? message;

  SelfTransactionModel({this.status, this.error, this.data, this.message});

  SelfTransactionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    error = json['error'];
    data = json['data'] != null ? DataTransaction.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['error'] = error;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class DataTransaction {
  TransactionList? transactionList;
  TransactionHistory? transactionHistory;
  UserChildrenLog? matchedChild;

  DataTransaction({this.transactionList, this.transactionHistory, this.matchedChild});

  DataTransaction.fromJson(Map<String, dynamic> json) {
    transactionList = json['transaction_list'] != null
        ? TransactionList.fromJson(json['transaction_list'])
        : null;
    transactionHistory = json['transaction_history'] != null
        ? TransactionHistory.fromJson(json['transaction_history'])
        : null;
    matchedChild = json['matched_child'] != null
        ? UserChildrenLog.fromJson(json['matched_child'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (transactionList != null) {
      data['transaction_list'] = transactionList!.toJson();
    }
    if (transactionHistory != null) {
      data['transaction_history'] = transactionHistory!.toJson();
    }
    if (matchedChild != null) {
      data['matched_child'] = matchedChild!.toJson();
    }
    return data;
  }
}

class TransactionList {
  int? id;
  String? purchaseTitle;
  String? trx;
  String? proofPaymentImage;
  int? statusPayPaket;
  int? createdBy;
  String? approvedBy;
  String? createdAt;
  int? userId;
  int? paketId;
  String? priceFinal;
  List<UserChildrenLog>? userChildrenLog;
  int? typePaymentUser;
  String? statusCreditPayment;
  int? idProvinsi;
  int? createdByRole;
  String? createFrom;
  TPaket? tPaket;
  UserPendaftar? userPendaftar;

  TransactionList(
      {this.id,
      this.purchaseTitle,
      this.trx,
      this.proofPaymentImage,
      this.statusPayPaket,
      this.createdBy,
      this.approvedBy,
      this.createdAt,
      this.userId,
      this.paketId,
      this.priceFinal,
      this.userChildrenLog,
      this.typePaymentUser,
      this.statusCreditPayment,
      this.idProvinsi,
      this.createdByRole,
      this.createFrom,
      this.tPaket,
      this.userPendaftar});

  TransactionList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    purchaseTitle = json['purchase_title'];
    trx = json['trx'];
    proofPaymentImage = json['proof_payment_image'];
    statusPayPaket = json['status_pay_paket'];
    createdBy = json['created_by'];
    approvedBy = json['approved_by'];
    createdAt = json['created_at'];
    userId = json['user_id'];
    paketId = json['paket_id'];
    priceFinal = json['price_final'];
    if (json['user_children_log'] != null) {
      userChildrenLog = <UserChildrenLog>[];
      json['user_children_log'].forEach((v) {
        userChildrenLog!.add(UserChildrenLog.fromJson(v));
      });
    }
    typePaymentUser = json['type_payment_user'];
    statusCreditPayment = json['status_credit_payment'];
    idProvinsi = json['id_provinsi'];
    createdByRole = json['created_by_role'];
    createFrom = json['create_from'];
    tPaket =
        json['t_paket'] != null ? TPaket.fromJson(json['t_paket']) : null;
    userPendaftar = json['user_pendaftar'] != null
        ? UserPendaftar.fromJson(json['user_pendaftar'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['purchase_title'] = purchaseTitle;
    data['trx'] = trx;
    data['proof_payment_image'] = proofPaymentImage;
    data['status_pay_paket'] = statusPayPaket;
    data['created_by'] = createdBy;
    data['approved_by'] = approvedBy;
    data['created_at'] = createdAt;
    data['user_id'] = userId;
    data['paket_id'] = paketId;
    data['price_final'] = priceFinal;
    if (userChildrenLog != null) {
      data['user_children_log'] =
          userChildrenLog!.map((v) => v.toJson()).toList();
    }
    data['type_payment_user'] = typePaymentUser;
    data['status_credit_payment'] = statusCreditPayment;
    data['id_provinsi'] = idProvinsi;
    data['created_by_role'] = createdByRole;
    data['create_from'] = createFrom;
    if (tPaket != null) {
      data['t_paket'] = tPaket!.toJson();
    }
    if (userPendaftar != null) {
      data['user_pendaftar'] = userPendaftar!.toJson();
    }
    return data;
  }
}

class UserChildrenLog {
  int? userId;
  String? status;
  int? transactionId;

  UserChildrenLog({this.userId, this.status, this.transactionId});

  UserChildrenLog.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    status = json['status'];
    transactionId = json['transaction_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['status'] = status;
    data['transaction_id'] = transactionId;
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
  String? airplaneTypeId;
  String? airportId;

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
  int? roleId;
  String? email;
  String? password;
  String? noTelp;
  String? name;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  String? nik;
  String? profilePicture;
  int? statusUser;
  String? address;
  String? imgKtp;
  String? imgKk;
  String? imgPasspor;
  String? imgSertifikatVaksin;
  String? imgPasFoto;
  String? imgBpjsKesehatan;
  String? idKabupaten;
  String? idProvinsi;
  String? idKecamatan;
  String? idKelurahan;
  String? dateOfBirth;
  String? gender;
  String? hubunganKerabat;
  String? addedBy;
  String? addedFrom;
  String? statusJob;

  UserPendaftar(
      {this.userId,
      this.roleId,
      this.email,
      this.password,
      this.noTelp,
      this.name,
      this.isActive,
      this.createdAt,
      this.updatedAt,
      this.nik,
      this.profilePicture,
      this.statusUser,
      this.address,
      this.imgKtp,
      this.imgKk,
      this.imgPasspor,
      this.imgSertifikatVaksin,
      this.imgPasFoto,
      this.imgBpjsKesehatan,
      this.idKabupaten,
      this.idProvinsi,
      this.idKecamatan,
      this.idKelurahan,
      this.dateOfBirth,
      this.gender,
      this.hubunganKerabat,
      this.addedBy,
      this.addedFrom,
      this.statusJob});

  UserPendaftar.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    roleId = json['role_id'];
    email = json['email'];
    password = json['password'];
    noTelp = json['no_telp'];
    name = json['name'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    nik = json['nik'];
    profilePicture = json['profile_picture'];
    statusUser = json['status_user'];
    address = json['address'];
    imgKtp = json['img_ktp'];
    imgKk = json['img_kk'];
    imgPasspor = json['img_passpor'];
    imgSertifikatVaksin = json['img_sertifikat_vaksin'];
    imgPasFoto = json['img_pas_foto'];
    imgBpjsKesehatan = json['img_bpjs_kesehatan'];
    idKabupaten = json['id_kabupaten'];
    idProvinsi = json['id_provinsi'];
    idKecamatan = json['id_kecamatan'];
    idKelurahan = json['id_kelurahan'];
    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    hubunganKerabat = json['hubungan_kerabat'];
    addedBy = json['added_by'];
    addedFrom = json['added_from'];
    statusJob = json['status_job'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['role_id'] = roleId;
    data['email'] = email;
    data['password'] = password;
    data['no_telp'] = noTelp;
    data['name'] = name;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['nik'] = nik;
    data['profile_picture'] = profilePicture;
    data['status_user'] = statusUser;
    data['address'] = address;
    data['img_ktp'] = imgKtp;
    data['img_kk'] = imgKk;
    data['img_passpor'] = imgPasspor;
    data['img_sertifikat_vaksin'] = imgSertifikatVaksin;
    data['img_pas_foto'] = imgPasFoto;
    data['img_bpjs_kesehatan'] = imgBpjsKesehatan;
    data['id_kabupaten'] = idKabupaten;
    data['id_provinsi'] = idProvinsi;
    data['id_kecamatan'] = idKecamatan;
    data['id_kelurahan'] = idKelurahan;
    data['date_of_birth'] = dateOfBirth;
    data['gender'] = gender;
    data['hubungan_kerabat'] = hubunganKerabat;
    data['added_by'] = addedBy;
    data['added_from'] = addedFrom;
    data['status_job'] = statusJob;
    return data;
  }
}

class TransactionHistory {
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
  String? userInsert;
  String? trxInv;
  String? vaNumber;
  String? createFrom;

  TransactionHistory(
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
      this.createFrom});

  TransactionHistory.fromJson(Map<String, dynamic> json) {
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
    userInsert = json['user_insert'];
    trxInv = json['trx_inv'];
    vaNumber = json['va_number'];
    createFrom = json['create_from'];
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
    data['create_from'] = createFrom;
    return data;
  }
}