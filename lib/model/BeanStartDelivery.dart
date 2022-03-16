class BeanStartDelivery {
  bool? status;
  String? message;
  List<Data>? data;

  BeanStartDelivery({this.status, this.message, this.data});

  BeanStartDelivery.fromJson(Map<String, dynamic> json) {
    status = json['status'];
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
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? kitchenlatitude;
  String? kitchenlongitude;
  String? deliverylatitude;
  String? deliverylongitude;
  String? deliveryaddress;

  Data(
      {this.kitchenlatitude,
        this.kitchenlongitude,
        this.deliverylatitude,
        this.deliverylongitude,
        this.deliveryaddress});

  Data.fromJson(Map<String, dynamic> json) {
    kitchenlatitude = json['kitchenlatitude'];
    kitchenlongitude = json['kitchenlongitude'];
    deliverylatitude = json['deliverylatitude'];
    deliverylongitude = json['deliverylongitude'];
    deliveryaddress = json['deliveryaddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kitchenlatitude'] = this.kitchenlatitude;
    data['kitchenlongitude'] = this.kitchenlongitude;
    data['deliverylatitude'] = this.deliverylatitude;
    data['deliverylongitude'] = this.deliverylongitude;
    data['deliveryaddress'] = this.deliveryaddress;
    return data;
  }
}