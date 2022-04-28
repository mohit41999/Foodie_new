// To parse this JSON data, do
//
//     final searchKitchenPackageModel = searchKitchenPackageModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SearchKitchenPackageModel searchKitchenPackageModelFromJson(String str) =>
    SearchKitchenPackageModel.fromJson(json.decode(str));

String searchKitchenPackageModelToJson(SearchKitchenPackageModel data) =>
    json.encode(data.toJson());

class SearchKitchenPackageModel {
  SearchKitchenPackageModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool status;
  final String message;
  final List<SearchKitchenPackageModelDatum> data;

  factory SearchKitchenPackageModel.fromJson(Map<String, dynamic> json) =>
      SearchKitchenPackageModel(
        status: json["status"],
        message: json["message"],
        data: List<SearchKitchenPackageModelDatum>.from(json["data"]
            .map((x) => SearchKitchenPackageModelDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class SearchKitchenPackageModelDatum {
  SearchKitchenPackageModelDatum({
    required this.kitchenId,
    required this.kitchenname,
    required this.address,
    required this.mealtype,
    required this.cuisinetype,
    required this.discount,
    required this.image,
    required this.averageRating,
    required this.totalReview,
    required this.isFavourite,
  });

  final String kitchenId;
  final String kitchenname;
  final String address;
  final String mealtype;
  final String cuisinetype;
  final String discount;
  final String image;
  final String averageRating;
  final String totalReview;
  final String isFavourite;

  factory SearchKitchenPackageModelDatum.fromJson(Map<String, dynamic> json) =>
      SearchKitchenPackageModelDatum(
        kitchenId: json["kitchen_id"],
        kitchenname: json["kitchenname"],
        address: json["address"],
        mealtype: json["mealtype"],
        cuisinetype: json["cuisinetype"],
        discount: json["discount"],
        image: json["image"],
        averageRating: json["average_rating"],
        totalReview: json["total_review"],
        isFavourite: json["is_favourite"],
      );

  Map<String, dynamic> toJson() => {
        "kitchen_id": kitchenId,
        "kitchenname": kitchenname,
        "address": address,
        "mealtype": mealtype,
        "cuisinetype": cuisinetype,
        "discount": discount,
        "image": image,
        "average_rating": averageRating,
        "total_review": totalReview,
        "is_favourite": isFavourite,
      };
}
