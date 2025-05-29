class PaymentTransactionRequestModel {
  String? trx;
  String? amount;
  String? typePayment;
  String? typeVa;

  PaymentTransactionRequestModel(
      {this.trx, this.amount, this.typePayment, this.typeVa});

  PaymentTransactionRequestModel.fromJson(Map<String, dynamic> json) {
    trx = json['trx'];
    amount = json['amount'];
    typePayment = json['type_payment'];
    typeVa = json['type_va'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['trx'] = trx;
    data['amount'] = amount;
    data['type_payment'] = typePayment;
    data['type_va'] = typeVa;
    return data;
  }
}