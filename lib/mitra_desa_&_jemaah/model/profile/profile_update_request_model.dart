import 'dart:io';

class ProfileUpdateRequestModel {
  File? img;

  ProfileUpdateRequestModel({this.img});

  ProfileUpdateRequestModel.fromJson(Map<String, dynamic> json) {
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['img'] = img;
    return data;
  }
}