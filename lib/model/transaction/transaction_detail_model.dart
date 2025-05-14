class TransactionDetailModel {
  int? status;
  bool? error;
  DataTransactionDetail? data;

  TransactionDetailModel({this.status, this.error, this.data});

  TransactionDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    error = json['error'];
    data = json['data'] != null ? DataTransactionDetail.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['error'] = error;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DataTransactionDetail {
  String? transaksiTrx;
  String? paketName;
  List<String>? paketAdditionalFeature;
  String? paketClass;
  String? pricePaket;
  int? amountSeat;
  String? hotelName;
  String? airportName;
  String? airplaneName;
  String? tanggalKeberangkatan;
  String? tanggalPemesanan;
  String? finalPrice;
  String? notes;
  int? statusPay;

  DataTransactionDetail(
      {this.transaksiTrx,
      this.paketName,
      this.paketAdditionalFeature,
      this.paketClass,
      this.pricePaket,
      this.amountSeat,
      this.hotelName,
      this.airportName,
      this.airplaneName,
      this.tanggalKeberangkatan,
      this.tanggalPemesanan,
      this.finalPrice,
      this.notes,
      this.statusPay});

  DataTransactionDetail.fromJson(Map<String, dynamic> json) {
    transaksiTrx = json['transaksi_trx'];
    paketName = json['paket_name'];
    paketAdditionalFeature = json['paket_additional_feature'].cast<String>();
    paketClass = json['paket_class'];
    pricePaket = json['price_paket'];
    amountSeat = json['amount_seat'];
    hotelName = json['hotel_name'];
    airportName = json['airport_name'];
    airplaneName = json['airplane_name'];
    tanggalKeberangkatan = json['tanggal_keberangkatan'];
    tanggalPemesanan = json['tanggal_pemesanan'];
    finalPrice = json['final_price'];
    notes = json['notes'];
    statusPay = json['status_pay'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['transaksi_trx'] = transaksiTrx;
    data['paket_name'] = paketName;
    data['paket_additional_feature'] = paketAdditionalFeature;
    data['paket_class'] = paketClass;
    data['price_paket'] = pricePaket;
    data['amount_seat'] = amountSeat;
    data['hotel_name'] = hotelName;
    data['airport_name'] = airportName;
    data['airplane_name'] = airplaneName;
    data['tanggal_keberangkatan'] = tanggalKeberangkatan;
    data['tanggal_pemesanan'] = tanggalPemesanan;
    data['final_price'] = finalPrice;
    data['notes'] = notes;
    data['status_pay'] = statusPay;
    return data;
  }
}