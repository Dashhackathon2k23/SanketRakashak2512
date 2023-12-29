class NearestLocationDataModel {
  String? success;
  String? message;
  Data? data;

  NearestLocationDataModel({this.success, this.message, this.data});

  NearestLocationDataModel.fromJson(Map<String, dynamic> json) {
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
  List<Department>? department;
  List<DepartmentLocation>? departmentLocation;

  Data({this.department, this.departmentLocation});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['department'] != null) {
      department = <Department>[];
      json['department'].forEach((v) {
        department!.add(new Department.fromJson(v));
      });
    }
    if (json['departmentLocation'] != null) {
      departmentLocation = <DepartmentLocation>[];
      json['departmentLocation'].forEach((v) {
        departmentLocation!.add(new DepartmentLocation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.department != null) {
      data['department'] = this.department!.map((v) => v.toJson()).toList();
    }
    if (this.departmentLocation != null) {
      data['departmentLocation'] =
          this.departmentLocation!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Department {
  String? sId;
  String? type;
  List<Departments>? departments;

  Department({this.sId, this.type, this.departments});

  Department.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    type = json['type'];
    if (json['departments'] != null) {
      departments = <Departments>[];
      json['departments'].forEach((v) {
        departments!.add(new Departments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['type'] = this.type;
    if (this.departments != null) {
      data['departments'] = this.departments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Departments {
  String? sId;
  String? name;
  String? type;
  String? address;
  Location? location;
  List<String>? number;
  String? state;
  String? city;
  List<Vehicles>? vehicles;
  String? slug;
  int? iV;
  double? distance;

  Departments(
      {this.sId,
        this.name,
        this.type,
        this.address,
        this.location,
        this.number,
        this.state,
        this.city,
        this.vehicles,
        this.slug,
        this.iV,
        this.distance});

  Departments.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    type = json['type'];
    address = json['address'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    number = json['number'].cast<String>();
    state = json['state'];
    city = json['city'];
    if (json['vehicles'] != null) {
      vehicles = <Vehicles>[];
      json['vehicles'].forEach((v) {
        vehicles!.add(new Vehicles.fromJson(v));
      });
    }
    slug = json['slug'];
    iV = json['__v'];
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['type'] = this.type;
    data['address'] = this.address;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['number'] = this.number;
    data['state'] = this.state;
    data['city'] = this.city;
    if (this.vehicles != null) {
      data['vehicles'] = this.vehicles!.map((v) => v.toJson()).toList();
    }
    data['slug'] = this.slug;
    data['__v'] = this.iV;
    data['distance'] = this.distance;
    return data;
  }
}

class Location {
  String? type;
  List<double>? coordinates;

  Location({this.type, this.coordinates});

  Location.fromJson(Map<String, dynamic> json) {
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

class Vehicles {
  String? name;
  int? count;
  String? sId;

  Vehicles({this.name, this.count, this.sId});

  Vehicles.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    count = json['count'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['count'] = this.count;
    data['_id'] = this.sId;
    return data;
  }
}

class DepartmentLocation {
  Location? location;
  String? sId;
  String? name;
  String? type;
  String? address;
  String? slug;
  int? totalVehicles;
  String? id;

  DepartmentLocation(
      {this.location,
        this.sId,
        this.name,
        this.type,
        this.address,
        this.slug,
        this.totalVehicles,
        this.id});

  DepartmentLocation.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    sId = json['_id'];
    name = json['name'];
    type = json['type'];
    address = json['address'];
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
    data['slug'] = this.slug;
    data['totalVehicles'] = this.totalVehicles;
    data['id'] = this.id;
    return data;
  }
}