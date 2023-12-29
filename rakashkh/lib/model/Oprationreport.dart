class OperationReport {
  String? success;
  String? message;
  Data? data;

  OperationReport({this.success, this.message, this.data});

  OperationReport.fromJson(Map<String, dynamic> json) {
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
  Location? location;
  String? description;
  String? number;
  List<Null>? facts;
  String? user;
  List<Null>? officers;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.location,
        this.description,
        this.number,
        this.facts,
        this.user,
        this.officers,
        this.sId,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    description = json['description'];
    number = json['number'];
    if (json['facts'] != null) {
      facts = <Null>[];
      json['facts'].forEach((v) {
        facts!.add(v);
      });
    }
    user = json['user'];
    if (json['officers'] != null) {
      officers = <Null>[];
      json['officers'].forEach((v) {
        officers!.add(v);
      });
    }
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['description'] = this.description;
    data['number'] = this.number;
    if (this.facts != null) {
      data['facts'] = this.facts!.map((v) => v).toList();
    }
    data['user'] = this.user;
    if (this.officers != null) {
      data['officers'] = this.officers!.map((v) => v).toList();
    }
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
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
