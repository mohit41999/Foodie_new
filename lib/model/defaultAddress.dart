// To parse this JSON data, do
//
//     final defaultAddress = defaultAddressFromJson(jsonString);

import 'dart:convert';

DefaultAddress defaultAddressFromJson(String str) =>
    DefaultAddress.fromJson(json.decode(str));

String defaultAddressToJson(DefaultAddress data) => json.encode(data.toJson());

class DefaultAddress {
  DefaultAddress({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<Datum>? data;

  factory DefaultAddress.fromJson(Map<String, dynamic> json) => DefaultAddress(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.address,
    this.latitude,
    this.longitude,
    this.isDefault,
  });

  String? id;
  String? address;
  String? latitude;
  String? longitude;
  String? isDefault;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        isDefault: json["is_default"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "is_default": isDefault,
      };
}
