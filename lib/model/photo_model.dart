// To parse this JSON data, do
//
//     final photoModel = photoModelFromJson(jsonString);

import 'dart:convert';

PhotoModel photoModelFromJson(String str) =>
    PhotoModel.fromJson(json.decode(str));

String photoModelToJson(PhotoModel data) => json.encode(data.toJson());

class PhotoModel {
  List<SitePhoto>? sitePhotos;

  PhotoModel({
    this.sitePhotos,
  });

  factory PhotoModel.fromJson(Map<String, dynamic> json) => PhotoModel(
        sitePhotos: json["sitePhotos"] == null
            ? []
            : List<SitePhoto>.from(
                json["sitePhotos"]!.map((x) => SitePhoto.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "sitePhotos": sitePhotos == null
            ? []
            : List<dynamic>.from(sitePhotos!.map((x) => x.toJson())),
      };
}

class SitePhoto {
  String? id;
  SiteId? siteId;
  DateTime? uploadDate;
  String? url;
  int? v;

  SitePhoto({
    this.id,
    this.siteId,
    this.uploadDate,
    this.url,
    this.v,
  });

  factory SitePhoto.fromJson(Map<String, dynamic> json) => SitePhoto(
        id: json["_id"],
        siteId:
            json["site_id"] == null ? null : SiteId.fromJson(json["site_id"]),
        uploadDate: json["uploadDate"] == null
            ? null
            : DateTime.parse(json["uploadDate"]),
        url: json["url"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "site_id": siteId?.toJson(),
        "uploadDate": uploadDate?.toIso8601String(),
        "url": url,
        "__v": v,
      };
}

class SiteId {
  String? id;
  String? siteName;
  String? siteLocation;

  SiteId({
    this.id,
    this.siteName,
    this.siteLocation,
  });

  factory SiteId.fromJson(Map<String, dynamic> json) => SiteId(
        id: json["_id"],
        siteName: json["site_name"],
        siteLocation: json["site_location"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "site_name": siteName,
        "site_location": siteLocation,
      };
}
