class SignUpModel {
  String? success;
  String? message;
  Data? data;

  SignUpModel({this.success, this.message, this.data});

  SignUpModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? token;
  NewUser? newUser;

  Data({this.token, this.newUser});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    newUser =
    json['newUser'] != null ? new NewUser.fromJson(json['newUser']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.newUser != null) {
      data['newUser'] = this.newUser!.toJson();
    }
    return data;
  }
}

class NewUser {
  String? name;
  List<Null>? location;
  String? role;
  String? number;
  bool? active;
  String? sId;
  int? iV;

  NewUser(
      {this.name,
        this.location,
        this.role,
        this.number,
        this.active,
        this.sId,
        this.iV});

  NewUser.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['location'] != null) {
      location = <Null>[];
      json['location'].forEach((v) {
        location!.add(v);
      });
    }
    role = json['role'];
    number = json['number'];
    active = json['active'];
    sId = json['_id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.location != null) {
      data['location'] = this.location!.map((v) => v).toList();
    }
    data['role'] = this.role;
    data['number'] = this.number;
    data['active'] = this.active;
    data['_id'] = this.sId;
    data['__v'] = this.iV;
    return data;
  }
}