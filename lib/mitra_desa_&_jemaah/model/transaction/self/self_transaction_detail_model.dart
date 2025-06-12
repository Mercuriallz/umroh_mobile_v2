// class SelfTransactionDetailModel {
//   int? status;
//   bool? error;
//   List<DataTransaction>? dataTransaction;
//   DataPay? dataPay;
//   TPaket? dataPaket;
//   String? message;

//   SelfTransactionDetailModel(
//       {this.status,
//       this.error,
//       this.dataTransaction,
//       this.dataPay,
//       this.dataPaket,
//       this.message});

//   SelfTransactionDetailModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     error = json['error'];
//     if (json['data_transaction'] != null) {
//       dataTransaction = <DataTransaction>[];
//       json['data_transaction'].forEach((v) {
//         dataTransaction!.add(DataTransaction.fromJson(v));
//       });
//     }
//     dataPay = json['data_pay'] != null
//         ? DataPay.fromJson(json['data_pay'])
//         : null;
//     dataPaket = json['data_paket'] != null
//         ? TPaket.fromJson(json['data_paket'])
//         : null;
//     message = json['message'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['status'] = status;
//     data['error'] = error;
//     if (dataTransaction != null) {
//       data['data_transaction'] =
//           dataTransaction!.map((v) => v.toJson()).toList();
//     }
//     if (dataPay != null) {
//       data['data_pay'] = dataPay!.toJson();
//     }
//     if (dataPaket != null) {
//       data['data_paket'] = dataPaket!.toJson();
//     }
//     data['message'] = message;
//     return data;
//   }
// }

// class DataTransaction {
//   int? id;
//   String? trxPay;
//   int? userId;
//   int? paketId;
//   int? trxId;
//   String? amount;
//   String? typePayment;
//   String? typeVa;
//   String? targetCompleted;
//   int? statusPay;
//   String? notes;
//   String? details;
//   String? payAt;
//   String? payTime;
//   TPaket? tPaket;
//   UserPendaftar? userPendaftar;

//   DataTransaction(
//       {this.id,
//       this.trxPay,
//       this.userId,
//       this.paketId,
//       this.trxId,
//       this.amount,
//       this.typePayment,
//       this.typeVa,
//       this.targetCompleted,
//       this.statusPay,
//       this.notes,
//       this.details,
//       this.payAt,
//       this.payTime,
//       this.tPaket,
//       this.userPendaftar});

//   DataTransaction.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     trxPay = json['trx_pay'];
//     userId = json['user_id'];
//     paketId = json['paket_id'];
//     trxId = json['trx_id'];
//     amount = json['amount'];
//     typePayment = json['type_payment'];
//     typeVa = json['type_va'];
//     targetCompleted = json['target_completed'];
//     statusPay = json['status_pay'];
//     notes = json['notes'];
//     details = json['details'];
//     payAt = json['pay_at'];
//     payTime = json['pay_time'];
//     tPaket =
//         json['t_paket'] != null ? TPaket.fromJson(json['t_paket']) : null;
//     userPendaftar = json['user_pendaftar'] != null
//         ? UserPendaftar.fromJson(json['user_pendaftar'])
//         : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['trx_pay'] = trxPay;
//     data['user_id'] = userId;
//     data['paket_id'] = paketId;
//     data['trx_id'] = trxId;
//     data['amount'] = amount;
//     data['type_payment'] = typePayment;
//     data['type_va'] = typeVa;
//     data['target_completed'] = targetCompleted;
//     data['status_pay'] = statusPay;
//     data['notes'] = notes;
//     data['details'] = details;
//     data['pay_at'] = payAt;
//     data['pay_time'] = payTime;
//     if (tPaket != null) {
//       data['t_paket'] = tPaket!.toJson();
//     }
//     if (userPendaftar != null) {
//       data['user_pendaftar'] = userPendaftar!.toJson();
//     }
//     return data;
//   }
// }

// class TPaket {
//   int? paketId;
//   String? namaPaket;
//   String? desc;
//   String? harga;
//   bool? isActive;
//   String? createdAt;
//   String? updatedAt;
//   String? durasiPerjalanan;
//   String? jadwalPerjalanan;
//   int? typePaket;
//   List<String>? arrFeature;
//   String? imgThumbnail;
//   bool? isVip;
//   int? planeSeat;
//   String? kodePaket;

//   TPaket(
//       {this.paketId,
//       this.namaPaket,
//       this.desc,
//       this.harga,
//       this.isActive,
//       this.createdAt,
//       this.updatedAt,
//       this.durasiPerjalanan,
//       this.jadwalPerjalanan,
//       this.typePaket,
//       this.arrFeature,
//       this.imgThumbnail,
//       this.isVip,
//       this.planeSeat,
//       this.kodePaket});

//   TPaket.fromJson(Map<String, dynamic> json) {
//     paketId = json['paket_id'];
//     namaPaket = json['nama_paket'];
//     desc = json['desc'];
//     harga = json['harga'];
//     isActive = json['is_active'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     durasiPerjalanan = json['durasi_perjalanan'];
//     jadwalPerjalanan = json['jadwal_perjalanan'];
//     typePaket = json['type_paket'];
//     arrFeature = json['arr_feature'].cast<String>();
//     imgThumbnail = json['img_thumbnail'];
//     isVip = json['is_vip'];
//     planeSeat = json['plane_seat'];
//     kodePaket = json['kode_paket'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['paket_id'] = paketId;
//     data['nama_paket'] = namaPaket;
//     data['desc'] = desc;
//     data['harga'] = harga;
//     data['is_active'] = isActive;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     data['durasi_perjalanan'] = durasiPerjalanan;
//     data['jadwal_perjalanan'] = jadwalPerjalanan;
//     data['type_paket'] = typePaket;
//     data['arr_feature'] = arrFeature;
//     data['img_thumbnail'] = imgThumbnail;
//     data['is_vip'] = isVip;
//     data['plane_seat'] = planeSeat;
//     data['kode_paket'] = kodePaket;
//     return data;
//   }
// }

// class UserPendaftar {
//   int? userId;
//   String? name;

//   UserPendaftar({this.userId, this.name});

//   UserPendaftar.fromJson(Map<String, dynamic> json) {
//     userId = json['user_id'];
//     name = json['name'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['user_id'] = userId;
//     data['name'] = name;
//     return data;
//   }
// }

// class DataPay {
//   int? totalPayment;
//   String? targetCompleted;
//   String? percentangePayment;

//   DataPay({this.totalPayment, this.targetCompleted, this.percentangePayment});

//   DataPay.fromJson(Map<String, dynamic> json) {
//     totalPayment = json['total_payment'];
//     targetCompleted = json['target_completed'];
//     percentangePayment = json['percentange_payment'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['total_payment'] = totalPayment;
//     data['target_completed'] = targetCompleted;
//     data['percentange_payment'] = percentangePayment;
//     return data;
//   }
// }

class SelfTransactionDetailModel {
  int? status;
  bool? error;
  List<DataTransaction>? data;
  String? message;

  SelfTransactionDetailModel(
      {this.status, this.error, this.data, this.message});

  SelfTransactionDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    error = json['error'];
    if (json['data'] != null) {
      data = <DataTransaction>[];
      json['data'].forEach((v) {
        data!.add(DataTransaction.fromJson(v));
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

class DataTransaction {
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
  List<TransactionHistory>? transactionHistory;
  UserPendaftar? userPendaftar;

  DataTransaction(
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
      this.transactionHistory,
      this.userPendaftar});

  DataTransaction.fromJson(Map<String, dynamic> json) {
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
    if (json['transaction_history'] != null) {
      transactionHistory = <TransactionHistory>[];
      json['transaction_history'].forEach((v) {
        transactionHistory!.add(TransactionHistory.fromJson(v));
      });
    }
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
    if (transactionHistory != null) {
      data['transaction_history'] =
          transactionHistory!.map((v) => v.toJson()).toList();
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