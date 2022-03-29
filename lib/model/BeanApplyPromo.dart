// class BeanApplyPromo {
//   bool? status;
//   String? message;
//   Data? data;
//
//   BeanApplyPromo({this.status, this.message, this.data});
//
//   BeanApplyPromo.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }
//
// class Data {
//   String? discount;
//
//   Data({this.discount});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     discount = json['discount'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['discount'] = this.discount;
//     return data;
//   }
// }

// To parse this JSON data, do
//
//     final beanApplyPromo = beanApplyPromoFromJson(jsonString);

import 'dart:convert';

BeanApplyPromo beanApplyPromoFromJson(String str) =>
    BeanApplyPromo.fromJson(json.decode(str));

String beanApplyPromoToJson(BeanApplyPromo data) => json.encode(data.toJson());

class BeanApplyPromo {
  BeanApplyPromo({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<dynamic>? data;

  factory BeanApplyPromo.fromJson(Map<String, dynamic> json) => BeanApplyPromo(
        status: json["status"],
        message: json["message"],
        data: List<dynamic>.from(json["data"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x)),
      };
}
