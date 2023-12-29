class AdminDetailModel {
  String? success;
  String? message;
  Data? data;

  AdminDetailModel({this.success, this.message, this.data});

  AdminDetailModel.fromJson(Map<String, dynamic> json) {
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
  User? user;
  Department? department;

  Data({this.user, this.department});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    department = json['department'] != null
        ? new Department.fromJson(json['department'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.department != null) {
      data['department'] = this.department!.toJson();
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

class Department {
  Location? location;
  String? sId;
  String? name;
  String? type;
  String? address;
  List<String>? number;
  String? state;
  String? city;
  String? head;
  List<Null>? officers;
  List<Null>? vehicles;
  String? slug;
  int? totalVehicles;
  String? id;

  Department(
      {this.location,
        this.sId,
        this.name,
        this.type,
        this.address,
        this.number,
        this.state,
        this.city,
        this.head,
        this.officers,
        this.vehicles,
        this.slug,
        this.totalVehicles,
        this.id});

  Department.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    sId = json['_id'];
    name = json['name'];
    type = json['type'];
    address = json['address'];
    number = json['number'].cast<String>();
    state = json['state'];
    city = json['city'];
    head = json['head'];
    if (json['officers'] != null) {
      officers = <Null>[];
      json['officers'].forEach((v) {
        officers!.add(v);
      });
    }
    if (json['vehicles'] != null) {
      vehicles = <Null>[];
      json['vehicles'].forEach((v) {
        vehicles!.add(v);
      });
    }
    slug = json['slug'];
    totalVehicles = json['totalVehicles'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['type'] = this.type;
    data['address'] = this.address;
    data['number'] = this.number;
    data['state'] = this.state;
    data['city'] = this.city;
    data['head'] = this.head;
    if (this.officers != null) {
      data['officers'] = this.officers!.map((v) => v).toList();
    }
    if (this.vehicles != null) {
      data['vehicles'] = this.vehicles!.map((v) => v).toList();
    }
    data['slug'] = this.slug;
    data['totalVehicles'] = this.totalVehicles;
    data['id'] = this.id;
    return data;
  }
}

class Location1 {
  String? type;
  List<double>? coordinates;

  Location1({this.type, this.coordinates});

  Location1.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}
