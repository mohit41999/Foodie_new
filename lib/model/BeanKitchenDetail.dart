// To parse this JSON data, do
//
//     final kitchenDetail = kitchenDetailFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

KitchenDetail kitchenDetailFromJson(String str) =>
    KitchenDetail.fromJson(json.decode(str));

String kitchenDetailToJson(KitchenDetail data) => json.encode(data.toJson());

class KitchenDetail {
  KitchenDetail({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool status;
  final String message;
  final List<KitchenDetailsData> data;

  factory KitchenDetail.fromJson(Map<String, dynamic> json) => KitchenDetail(
        status: json["status"],
        message: json["message"],
        data: List<KitchenDetailsData>.from(
            json["data"].map((x) => KitchenDetailsData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class KitchenDetailsData {
  KitchenDetailsData({
    required this.kitchenId,
    required this.kitchenname,
    required this.foodtype,
    required this.address,
    required this.timing,
    required this.openStatus,
    required this.totalReview,
    required this.avgReview,
    required this.isFavourite,
    required this.offers,
    required this.breakfast,
    required this.lunch,
    required this.dinner,
  });

  final String kitchenId;
  final String kitchenname;
  final String foodtype;
  final String address;
  final String timing;
  final String openStatus;
  final String totalReview;
  final int avgReview;
  final String isFavourite;
  final List<Offer> offers;
  final Breakfast breakfast;
  final Breakfast lunch;
  final Breakfast dinner;

  factory KitchenDetailsData.fromJson(Map<String, dynamic> json) =>
      KitchenDetailsData(
        kitchenId: json["kitchen_id"],
        kitchenname: json["kitchenname"],
        foodtype: json["foodtype"],
        address: json["address"],
        timing: json["timing"],
        openStatus: json["open_status"],
        totalReview: json["total_review"],
        avgReview: json["avg_review"],
        isFavourite: json["is_favourite"],
        offers: List<Offer>.from(json["offers"].map((x) => Offer.fromJson(x))),
        breakfast: Breakfast.fromJson(json["breakfast"]),
        lunch: Breakfast.fromJson(json["lunch"]),
        dinner: Breakfast.fromJson(json["dinner"]),
      );

  Map<String, dynamic> toJson() => {
        "kitchen_id": kitchenId,
        "kitchenname": kitchenname,
        "foodtype": foodtype,
        "address": address,
        "timing": timing,
        "open_status": openStatus,
        "total_review": totalReview,
        "avg_review": avgReview,
        "is_favourite": isFavourite,
        "offers": List<dynamic>.from(offers.map((x) => x.toJson())),
        "breakfast": breakfast.toJson(),
        "lunch": lunch.toJson(),
        "dinner": dinner.toJson(),
      };
}

class Breakfast {
  Breakfast({
    required this.menu,
  });

  final List<Menu> menu;

  factory Breakfast.fromJson(Map<String, dynamic> json) => Breakfast(
        menu: List<Menu>.from(json["menu"].map((x) => Menu.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "menu": List<dynamic>.from(menu.map((x) => x.toJson())),
      };
}

class Menu {
  Menu({
    required this.itemid,
    required this.bookType,
    required this.itemname,
    required this.cuisinetype,
    required this.including,
    required this.itemprice,
    required this.image,
  });

  final String itemid;
  final String bookType;
  final String itemname;
  final String cuisinetype;
  final String including;
  final String itemprice;
  final String image;

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        itemid: json["itemid"],
        bookType: json["book_type"],
        itemname: json["itemname"],
        cuisinetype: json["cuisinetype"],
        including: json["including"],
        itemprice: json["itemprice"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "itemid": itemid,
        "book_type": bookType,
        "itemname": itemname,
        "cuisinetype": cuisinetype,
        "including": including,
        "itemprice": itemprice,
        "image": image,
      };
}

class Offer {
  Offer({
    required this.offercode,
    required this.discounttype,
    required this.discount,
  });

  final String offercode;
  final String discounttype;
  final int discount;

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        offercode: json["offercode"],
        discounttype: json["discounttype"],
        discount: json["discount"],
      );

  Map<String, dynamic> toJson() => {
        "offercode": offercode,
        "discounttype": discounttype,
        "discount": discount,
      };
}
