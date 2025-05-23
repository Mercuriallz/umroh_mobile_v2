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
  List<TransactionHistory>? transactionHistory;
  UserChildrenLog? matchedChild;

  DataTransaction({this.transactionList, this.transactionHistory, this.matchedChild});

  DataTransaction.fromJson(Map<String, dynamic> json) {
    transactionList = json['transaction_list'] != null
        ? TransactionList.fromJson(json['transaction_list'])
        : null;
    if (json['transaction_history'] != null) {
      transactionHistory = <TransactionHistory>[];
      json['transaction_history'].forEach((v) {
        transactionHistory!.add(TransactionHistory.fromJson(v));
      });
    }
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
      data['transaction_history'] =
          transactionHistory!.map((v) => v.toJson()).toList();
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
  String? typePaymentUser;
  String? statusCreditPayment;

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
      this.statusCreditPayment});

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
      this.vaNumber});

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
    return data;
  }
}