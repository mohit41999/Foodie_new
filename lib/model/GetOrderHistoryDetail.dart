class GetOrderHistoryDetail {
  bool? status;
  String? message;
  List<Data>? data;

  GetOrderHistoryDetail({this.status, this.message, this.data});

  GetOrderHistoryDetail.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
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
  String? itemName;
  String? image;
  String? date;
  String? orderitems_id;
  String? order_id;
  String? kitchen_id;
  String? delivery_address;

  String? status;

  Data(
      {this.itemName,
      this.image,
      this.date,
      this.kitchen_id,
      this.status,
      this.order_id,
      this.delivery_address,
      this.orderitems_id});

  Data.fromJson(Map<String, dynamic> json) {
    itemName = json['item_name'];
    image = json['image'];
    order_id = json['order_id'];
    kitchen_id = json['kitchen_id'];
    orderitems_id = json['orderitems_id'];
    delivery_address = json['delivery_address'] ?? '';
    date = json['date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_name'] = this.itemName;
    data['image'] = this.image;
    data['kitchen_id'] = this.kitchen_id;
    data['delivery_address'] = this.delivery_address;
    data['orderitems_id'] = this.orderitems_id;
    data['order_id'] = this.order_id;
    data['date'] = this.date;
    data['status'] = this.status;
    return data;
  }
}
