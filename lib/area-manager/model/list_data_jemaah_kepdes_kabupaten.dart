class ListDataJemaahKepdesKabupatenModel {
  int? status;
  bool? error;
  DataListJemaahKepdesKabupaten? data;
  String? message;

  ListDataJemaahKepdesKabupatenModel(
      {this.status, this.error, this.data, this.message});

  ListDataJemaahKepdesKabupatenModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    error = json['error'];
    data = json['data'] != null ? DataListJemaahKepdesKabupaten.fromJson(json['data']) : null;
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

class DataListJemaahKepdesKabupaten {
  List<UserKepdes>? userKepdes;
  List<UserJemaah>? userJemaah;
  int? totalJemaah;

  DataListJemaahKepdesKabupaten({this.userKepdes, this.userJemaah, this.totalJemaah});

  DataListJemaahKepdesKabupaten.fromJson(Map<String, dynamic> json) {
    if (json['user_kepdes'] != null) {
      userKepdes = <UserKepdes>[];
      json['user_kepdes'].forEach((v) {
        userKepdes!.add(UserKepdes.fromJson(v));
      });
    }
    if (json['user_jemaah'] != null) {
      userJemaah = <UserJemaah>[];
      json['user_jemaah'].forEach((v) {
        userJemaah!.add(UserJemaah.fromJson(v));
      });
    }
    totalJemaah = json['total_jemaah'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userKepdes != null) {
      data['user_kepdes'] = userKepdes!.map((v) => v.toJson()).toList();
    }
    if (userJemaah != null) {
      data['user_jemaah'] = userJemaah!.map((v) => v.toJson()).toList();
    }
    data['total_jemaah'] = totalJemaah;
    return data;
  }
}

class UserKepdes {
  int? kepdesId;
  String? name;
  String? username;
  int? idKabupaten;

  UserKepdes(
      {this.kepdesId, this.name, this.username, this.idKabupaten});

  UserKepdes.fromJson(Map<String, dynamic> json) {
    kepdesId = json['kepdes_id'];
    name = json['name'];
    username = json['username'];
    idKabupaten = json['id_kabupaten'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kepdes_id'] = kepdesId;
    data['name'] = name;
    data['username'] = username;
    data['id_kabupaten'] = idKabupaten;
    return data;
  }
}

class UserJemaah {
  int? userId;
  String? name;
  String? email;
  String? gender;
  int? addedBy;
  String? kepdesName;
  String? kepdesUsername;

  UserJemaah(
      {this.userId,
      this.name,
      this.email,
      this.gender,
      this.addedBy,
      this.kepdesName,
      this.kepdesUsername});

  UserJemaah.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    email = json['email'];
    gender = json['gender'];
    addedBy = json['added_by'];
    kepdesName = json['kepdes_name'];
    kepdesUsername = json['kepdes_username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['name'] = name;
    data['email'] = email;
    data['gender'] = gender;
    data['added_by'] = addedBy;
    data['kepdes_name'] = kepdesName;
    data['kepdes_username'] = kepdesUsername;
    return data;
  }
}