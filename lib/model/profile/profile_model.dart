class ProfileModel {
  int? status;
  bool? error;
  DataProfile? data;
  String? message;

  ProfileModel({this.status, this.error, this.data, this.message});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    error = json['error'];
    data = json['data'] != null ? DataProfile.fromJson(json['data']) : null;
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

class DataProfile {
  int? userId;
  String? name;
  String? profilePicture;

  DataProfile({this.userId, this.name, this.profilePicture, });

  DataProfile.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    profilePicture = json['profile_picture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['name'] = name;
    data['profile_picture'] = profilePicture;
    return data;
  }
}