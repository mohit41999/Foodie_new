// class BeanPackageDetail {
//   bool? status;
//   String? message;
//   Data? data;
//
//   BeanPackageDetail({this.status, this.message, this.data});
//
//   BeanPackageDetail.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     data = json['data'] != null
//         ? json['data'] is List
//             ? null
//             : new Data.fromJson(json['data'])
//         : null;
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
//   String? kitchenId;
//   String? packageId;
//   String? packageName;
//   String? mealfor;
//   String? mealtype;
//   String? cuisinetype;
//   String? price;
//   List<PackageDetail>? packageDetail;
//
//   Data(
//       {this.kitchenId,
//       this.packageId,
//       this.packageName,
//       this.mealfor,
//       this.mealtype,
//       this.cuisinetype,
//       this.price,
//       this.packageDetail});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     kitchenId = json['kitchen_id'];
//     packageId = json['package_id'];
//     packageName = json['package_name'];
//     mealfor = json['mealfor'];
//     mealtype = json['mealtype'];
//     cuisinetype = json['cuisinetype'];
//     price = json['price'];
//     if (json['package_detail'] != null) {
//       packageDetail = [];
//       json['package_detail'].forEach((v) {
//         packageDetail!.add(new PackageDetail.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['kitchen_id'] = this.kitchenId;
//     data['package_id'] = this.packageId;
//     data['package_name'] = this.packageName;
//     data['mealfor'] = this.mealfor;
//     data['mealtype'] = this.mealtype;
//     data['cuisinetype'] = this.cuisinetype;
//     data['price'] = this.price;
//     if (this.packageDetail != null) {
//       data['package_detail'] =
//           this.packageDetail!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class PackageDetail {
//   String? weeklyPackageId;
//   String? days;
//   String? daysName;
//   String? itemName;
//
//   PackageDetail(
//       {this.weeklyPackageId, this.days, this.daysName, this.itemName});
//
//   PackageDetail.fromJson(Map<String, dynamic> json) {
//     weeklyPackageId = json['weekly_package_id'];
//     days = json['days'];
//     daysName = json['days_name'];
//     itemName = json['item_name'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['weekly_package_id'] = this.weeklyPackageId;
//     data['days'] = this.days;
//     data['days_name'] = this.daysName;
//     data['item_name'] = this.itemName;
//     return data;
//   }
// }
// To parse this JSON data, do
//
//     final beanPackageDetail = beanPackageDetailFromJson(jsonString);

// To parse this JSON data, do
//
//     final beanPackageDetail = beanPackageDetailFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

BeanPackageDetail beanPackageDetailFromJson(String str) =>
    BeanPackageDetail.fromJson(json.decode(str));

String beanPackageDetailToJson(BeanPackageDetail data) =>
    json.encode(data.toJson());

class BeanPackageDetail {
  BeanPackageDetail({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? status;
  final String? message;
  final BeanPackageDetailData? data;

  factory BeanPackageDetail.fromJson(Map<String, dynamic> json) =>
      BeanPackageDetail(
        status: json["status"],
        message: json["message"],
        data: BeanPackageDetailData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
      };
}

class BeanPackageDetailData {
  BeanPackageDetailData({
    required this.kitchenId,
    required this.packageId,
    required this.packageName,
    required this.mealfor,
    required this.mealtype,
    required this.cuisinetype,
    required this.price,
    required this.packageDetail,
  });

  final String kitchenId;
  final String packageId;
  final String packageName;
  final String mealfor;
  final String mealtype;
  final String cuisinetype;
  final String price;
  final List<PackageDetail> packageDetail;

  factory BeanPackageDetailData.fromJson(Map<String, dynamic> json) =>
      BeanPackageDetailData(
        kitchenId: json["kitchen_id"],
        packageId: json["package_id"],
        packageName: json["package_name"],
        mealfor: json["mealfor"],
        mealtype: json["mealtype"],
        cuisinetype: json["cuisinetype"],
        price: json["price"],
        packageDetail: List<PackageDetail>.from(
            json["package_detail"].map((x) => PackageDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "kitchen_id": kitchenId,
        "package_id": packageId,
        "package_name": packageName,
        "mealfor": mealfor,
        "mealtype": mealtype,
        "cuisinetype": cuisinetype,
        "price": price,
        "package_detail":
            List<dynamic>.from(packageDetail.map((x) => x.toJson())),
      };
}

class PackageDetail {
  PackageDetail({
    required this.weeklyPackageId,
    required this.days,
    required this.daysName,
    required this.itemName,
    required this.menuItem,
  });

  final String? weeklyPackageId;
  final String? days;
  final String? daysName;
  final String? itemName;
  final List<MenuItem> menuItem;

  factory PackageDetail.fromJson(Map<String, dynamic> json) => PackageDetail(
        weeklyPackageId: json["weekly_package_id"],
        days: json["days"],
        daysName: json["days_name"],
        itemName: json["item_name"],
        menuItem: List<MenuItem>.from(
            json["menu_item"].map((x) => MenuItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "weekly_package_id": weeklyPackageId,
        "days": days,
        "days_name": daysName,
        "item_name": itemName,
        "menu_item": List<dynamic>.from(menuItem.map((x) => x.toJson())),
      };
}

class MenuItem {
  MenuItem({
    required this.category,
    required this.menuitems,
  });

  final String category;
  final List<Menuitem> menuitems;

  factory MenuItem.fromJson(Map<String, dynamic> json) => MenuItem(
        category: json["category"],
        menuitems: List<Menuitem>.from(
            json["menuitems"].map((x) => Menuitem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "menuitems": List<dynamic>.from(menuitems.map((x) => x.toJson())),
      };
}

class Menuitem {
  Menuitem({
    required this.itemId,
    required this.itemName,
    required this.itemQty,
    required this.itemPrice,
  });
  final String itemId;
  bool? isChecked = false;
  final String itemName;
  int itemQty;
  int qtytoincrease = 0;

  final String itemPrice;

  factory Menuitem.fromJson(Map<String, dynamic> json) => Menuitem(
        itemId: json["item_id"],
        itemName: json["item_name"],
        itemQty: int.parse(json["item_qty"]),
        itemPrice: json["item_price"],
      );

  Map<String, dynamic> toJson() => {
        "item_id": itemId,
        "item_name": itemName,
        "item_qty": itemQty,
        "item_price": itemPrice,
      };
}

// class MenuItem {
//   MenuItem({
//     required this.itemId,
//     required this.itemName,
//     required this.itemQty,
//   });
//
//   final String itemId;
//   bool? isChecked = false;
//   final String itemName;
//   int itemQty;
//   int qtytoincrease = 0;
//
//   factory MenuItem.fromJson(Map<String, dynamic> json) => MenuItem(
//         itemId: json["item_id"],
//         itemName: json["item_name"],
//         itemQty: int.parse(json["item_qty"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "item_id": itemId,
//         "item_name": itemName,
//         "item_qty": itemQty,
//       };
// }
