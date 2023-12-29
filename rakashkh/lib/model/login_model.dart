class LoginModel {
  String? success;
  String? message;
  Data? data;

  LoginModel({this.success, this.message, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
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
  User? user;

  Data({this.token, this.user});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  String? sId;
  String? name;
  List<Location>? location;
  String? designation;
  String? role;
  String? number;
  int? iV;
  String? fcmToken;

  User(
      {this.sId,
        this.name,
        this.location,
        this.designation,
        this.role,
        this.number,
        this.iV,
        this.fcmToken});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    if (json['location'] != null) {
      location = <Location>[];
      json['location'].forEach((v) {
        location!.add(new Location.fromJson(v));
      });
    }
    designation = json['designation'];
    role = json['role'];
    number = json['number'];
    iV = json['__v'];
    fcmToken = json['fcm_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    if (this.location != null) {
      data['location'] = this.location!.map((v) => v.toJson()).toList();
    }
    data['designation'] = this.designation;
    data['role'] = this.role;
    data['number'] = this.number;
    data['__v'] = this.iV;
    data['fcm_token'] = this.fcmToken;
    return data;
  }
}

class Location {
  String? type;
  List<double>? coordinates;
  String? address;
  String? sId;

  Location({this.type, this.coordinates, this.address, this.sId});

  Location.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
    address = json['address'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    data['address'] = this.address;
    data['_id'] = this.sId;
    return data;
  }
}
