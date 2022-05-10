class BeanStartDelivery {
  bool? status;
  String? message;
  List<BeanStartDeliveryData>? data;

  BeanStartDelivery({this.status, this.message, this.data});

  BeanStartDelivery.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <BeanStartDeliveryData>[];
      json['data'].forEach((v) {
        data!.add(new BeanStartDeliveryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BeanStartDeliveryData {
  BeanStartDeliveryData({
    required this.kitchenLatitude,
    required this.kitchenLongitude,
    required this.riderLatitude,
    required this.riderLongitude,
    required this.deliverylatitude,
    required this.deliverylongitude,
    required this.deliveryaddress,
  });

  final String kitchenLatitude;
  final String kitchenLongitude;
  final String riderLatitude;
  final String riderLongitude;
  final String deliverylatitude;
  final String deliverylongitude;
  final String deliveryaddress;

  factory BeanStartDeliveryData.fromJson(Map<String, dynamic> json) =>
      BeanStartDeliveryData(
        kitchenLatitude: json["kitchen_latitude"],
        kitchenLongitude: json["kitchen_longitude"],
        riderLatitude: json["rider_latitude"],
        riderLongitude: json["rider_longitude"],
        deliverylatitude: json["deliverylatitude"],
        deliverylongitude: json["deliverylongitude"],
        deliveryaddress: json["deliveryaddress"],
      );

  Map<String, dynamic> toJson() => {
        "kitchen_latitude": kitchenLatitude,
        "kitchen_longitude": kitchenLongitude,
        "rider_latitude": riderLatitude,
        "rider_longitude": riderLongitude,
        "deliverylatitude": deliverylatitude,
        "deliverylongitude": deliverylongitude,
        "deliveryaddress": deliveryaddress,
      };
}
