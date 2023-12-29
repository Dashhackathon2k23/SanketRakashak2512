// ignore_for_file: unnecessary_new

class DesignationType {
  String? success;
  String? message;
  List<Data>? data;

  DesignationType({this.success, this.message, this.data});

  DesignationType.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? department;
  String? designation;
  String? staff;
  int? iV;

  Data({this.sId, this.department, this.designation, this.staff, this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    department = json['department'];
    designation = json['designation'];
    staff = json['staff'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['department'] = this.department;
    data['designation'] = this.designation;
    data['staff'] = this.staff;
    data['__v'] = this.iV;
    return data;
  }
}