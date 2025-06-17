import 'dart:io';

class PaymentModel {
  String? purchaseTitle;
  int? paketId;
  int? priceFinal;
  int? amount;
  String? typePayment;
  String? typeVaChoice;
  int? typePaymentUser;
  List<UserReg>? userReg;

  PaymentModel(
      {this.purchaseTitle,
      this.paketId,
      this.priceFinal,
      this.amount,
      this.typePayment,
      this.typeVaChoice,
      this.typePaymentUser,
      this.userReg});

  PaymentModel.fromJson(Map<String, dynamic> json) {
    purchaseTitle = json['purchase_title'];
    paketId = json['paket_id'];
    priceFinal = json['price_final'];
    amount = json['amount'];
    typePayment = json['type_payment'];
    typeVaChoice = json['type_va_choice'];
    typePaymentUser = json['type_payment_user'];
    if (json['user_reg'] != null) {
      userReg = <UserReg>[];
      json['user_reg'].forEach((v) {
        userReg!.add(UserReg.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['purchase_title'] = purchaseTitle;
    data['paket_id'] = paketId;
    data['price_final'] = priceFinal;
    data['amount'] = amount;
    data['type_payment'] = typePayment;
    data['type_va_choice'] = typeVaChoice;
    data['type_payment_user'] = typePaymentUser;
    if (userReg != null) {
      data['user_reg'] = userReg!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserReg {
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

  UserReg(
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

  UserReg.fromJson(Map<String, dynamic> json) {
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