class PaymentDataModel {
  int? status;
  bool? error;
  DataModel? data;
  String? message;

  PaymentDataModel({this.status, this.error, this.data, this.message});

  PaymentDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    error = json['error'];
    data = json['data'] != null ? DataModel.fromJson(json['data']) : null;
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

class DataModel {
  String? trx;

  DataModel({this.trx});

  DataModel.fromJson(Map<String, dynamic> json) {
    trx = json['trx'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['trx'] = trx;
    return data;
  }
}