class PaymentTransactionModel {
  int? status;
  bool? error;
  PaymentData? data;
  String? message;

  PaymentTransactionModel({this.status, this.error, this.data, this.message});

  PaymentTransactionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    error = json['error'];
    data = json['data'] != null ? PaymentData.fromJson(json['data']) : null;
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

class PaymentData {
  String? amount;
  String? typePayment;
  String? finalPrice;
  String? invNumber;
  String? vaNumber;
  String? trxId;

  PaymentData(
      {this.amount,
      this.typePayment,
      this.finalPrice,
      this.invNumber,
      this.vaNumber,
      this.trxId});

  PaymentData.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    typePayment = json['type_payment'];
    finalPrice = json['final_price'];
    invNumber = json['inv_number'];
    vaNumber = json['va_number'];
    trxId = json['trx_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['type_payment'] = typePayment;
    data['final_price'] = finalPrice;
    data['inv_number'] = invNumber;
    data['va_number'] = vaNumber;
    data['trx_id'] = trxId;
    return data;
  }
}