import 'dart:io';

class UploadModel {
  File? imgTrx;

  UploadModel({this.imgTrx});

  UploadModel.fromJson(Map<String, dynamic> json) {
    imgTrx = json['img_trx'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['img_trx'] = imgTrx;
    return data;
  }
}