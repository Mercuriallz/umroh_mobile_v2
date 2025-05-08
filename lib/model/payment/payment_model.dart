class PaymentModel {
  String? purchaseTitle;
  int? paketId;
  int? priceFinal;
  int? amount;
  String? typePayment;
  String? notes;
  List<UserReg>? userReg;

  PaymentModel(
      {this.purchaseTitle,
      this.paketId,
      this.priceFinal,
      this.amount,
      this.typePayment,
      this.notes,
      this.userReg});

  PaymentModel.fromJson(Map<String, dynamic> json) {
    purchaseTitle = json['purchase_title'];
    paketId = json['paket_id'];
    priceFinal = json['price_final'];
    amount = json['amount'];
    typePayment = json['type_payment'];
    notes = json['notes'];
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
    data['notes'] = notes;
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

  UserReg({this.name, this.email, this.phoneNumber, this.nik, this.password});

  UserReg.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    nik = json['nik'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['phone_number'] = phoneNumber;
    data['nik'] = nik;
    data['password'] = password;
    return data;
  }
}