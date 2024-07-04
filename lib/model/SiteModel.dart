// To parse this JSON data, do
//
//     final siteModel = siteModelFromJson(jsonString);

import 'dart:convert';

SiteModel siteModelFromJson(String str) => SiteModel.fromJson(json.decode(str));

String siteModelToJson(SiteModel data) => json.encode(data.toJson());

class SiteModel {
  List<Site>? sites;

  SiteModel({
    this.sites,
  });

  factory SiteModel.fromJson(Map<String, dynamic> json) => SiteModel(
        sites: json["sites"] == null
            ? []
            : List<Site>.from(json["sites"]!.map((x) => Site.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "sites": sites == null
            ? []
            : List<dynamic>.from(sites!.map((x) => x.toJson())),
      };
}

class Site {
  String? siteName;
  String? siteLocation;
  String? ownerName;
  String? ownerNumber;
  String? siteLogo;
  Manager? supervisor;
  Manager? manager;
  List<Manager>? worker;
  List<Manager>? helper;

  Site({
    this.siteName,
    this.siteLocation,
    this.ownerName,
    this.ownerNumber,
    this.siteLogo,
    this.supervisor,
    this.manager,
    this.worker,
    this.helper,
  });

  factory Site.fromJson(Map<String, dynamic> json) => Site(
        siteName: json["site_name"],
        siteLocation: json["site_location"],
        ownerName: json["owner_name"],
        ownerNumber: json["owner_number"],
        siteLogo: json["site_logo"],
        supervisor: json["supervisor"] == null
            ? null
            : Manager.fromJson(json["supervisor"]),
        manager:
            json["manager"] == null ? null : Manager.fromJson(json["manager"]),
        worker: json["worker"] == null
            ? []
            : List<Manager>.from(
                json["worker"]!.map((x) => Manager.fromJson(x))),
        helper: json["helper"] == null
            ? []
            : List<Manager>.from(
                json["helper"]!.map((x) => Manager.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "site_name": siteName,
        "site_location": siteLocation,
        "owner_name": ownerName,
        "owner_number": ownerNumber,
        "site_logo": siteLogo,
        "supervisor": supervisor?.toJson(),
        "manager": manager?.toJson(),
        "worker": worker == null
            ? []
            : List<dynamic>.from(worker!.map((x) => x.toJson())),
        "helper": helper == null
            ? []
            : List<dynamic>.from(helper!.map((x) => x.toJson())),
      };
}

class Manager {
  String? id;
  String? name;
  String? referenceName;
  String? photo;
  Attendance? attendance;

  Manager({
    this.id,
    this.name,
    this.referenceName,
    this.photo,
    this.attendance,
  });

  factory Manager.fromJson(Map<String, dynamic> json) => Manager(
        id: json["_id"],
        name: json["name"],
        referenceName: json["reference_name"],
        photo: json["photo"],
        attendance: json["attendance"] == null
            ? null
            : Attendance.fromJson(json["attendance"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "reference_name": referenceName,
        "photo": photo,
        "attendance": attendance?.toJson(),
      };
}

class Attendance {
  String? id;
  String? employeeId;
  String? siteId;
  String? startTime;
  String? endTime;
  DateTime? date;
  int? v;

  Attendance({
    this.id,
    this.employeeId,
    this.siteId,
    this.startTime,
    this.endTime,
    this.date,
    this.v,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) => Attendance(
        id: json["_id"],
        employeeId: json["employee_id"],
        siteId: json["site_id"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "employee_id": employeeId,
        "site_id": siteId,
        "start_time": startTime,
        "end_time": endTime,
        "date": date?.toIso8601String(),
        "__v": v,
      };
}
