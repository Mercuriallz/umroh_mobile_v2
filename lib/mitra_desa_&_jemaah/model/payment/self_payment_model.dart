import 'dart:io';

class SelfPaymentModel {
  String? amount;
  String? priceFinal;
  String? purchaseTitle;
  int? paketId;
  String? typePayment;
  List<UserRegs>? userReg;
  String? typePaymentUser;
  String? typeVaChoice;
  String? kodeConnect;
  String? statusPay;

  SelfPaymentModel(
      {this.amount,
      this.priceFinal,
      this.purchaseTitle,
      this.paketId,
      this.typePayment,
      this.userReg,
      this.typePaymentUser,
      this.typeVaChoice,
      this.kodeConnect,
      this.statusPay
      });

  SelfPaymentModel.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    priceFinal = json['price_final'];
    purchaseTitle = json['purchase_title'];
    paketId = json['paket_id'];
    typePayment = json['type_payment'];
    if (json['user_reg'] != null) {
      userReg = <UserRegs>[];
      json['user_reg'].forEach((v) {
        userReg!.add(UserRegs.fromJson(v));
      });
    }
    typePaymentUser = json['type_payment_user'];
    typeVaChoice = json['type_va_choice'];
    kodeConnect = json['kode_connect'];
    statusPay = json['status_pay'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['price_final'] = priceFinal;
    data['purchase_title'] = purchaseTitle;
    data['paket_id'] = paketId;
    data['type_payment'] = typePayment;
    if (userReg != null) {
      data['user_reg'] = userReg!.map((v) => v.toJson()).toList();
    }
    data['type_payment_user'] = typePaymentUser;
    data['type_va_choice'] = typeVaChoice;
    data['kode_connect'] = kodeConnect;
    data['status_pay'] = statusPay;
    return data;
  }
}


  class UserRegs {
  String? name;
  String? email;
  String? phoneNumber;
  String? nik;
  String? password;
  String? hubunganKerabat;
  File? imgKtp;
  File? imgPassport;
  File? imgKk;
  File? imgVaksin;
  File? imgPasFoto;
  File? imgBpjsKesehatan;

  UserRegs(
      {this.name,
      this.email,
      this.phoneNumber,
      this.nik,
      this.password,
      this.hubunganKerabat,
      this.imgKtp,
      this.imgPassport,
      this.imgKk,
      this.imgVaksin,
      this.imgPasFoto,
      this.imgBpjsKesehatan});

  UserRegs.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    nik = json['nik'];
    password = json['password'];
    hubunganKerabat = json['hubungan_kerabat'];
    imgKtp = json['img_ktp'];
    imgPassport = json['img_passport'];
    imgKk = json['img_kk'];
    imgVaksin = json['img_vaksin'];
    imgPasFoto = json['img_pas_foto'];
    imgBpjsKesehatan = json['img_bpjs_kesehatan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['phone_number'] = phoneNumber;
    data['nik'] = nik;
    data['password'] = password;
    data['hubungan_kerabat'] = hubunganKerabat;
    data['img_ktp'] = imgKtp;
    data['img_passport'] = imgPassport;
    data['img_kk'] = imgKk;
    data['img_vaksin'] = imgVaksin;
    data['img_pas_foto'] = imgPasFoto;
    data['img_bpjs_kesehatan'] = imgBpjsKesehatan;
    return data;
  }
}