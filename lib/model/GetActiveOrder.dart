class GetActiveOrder {
  bool? status;
  String? message;
  List<Data>? data;

  GetActiveOrder({this.status, this.message, this.data});

  GetActiveOrder.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? kitchenname;
  String? orderid;
  String? orderfrom;
  String? orderItems;
  String? meal_type;
  String? meal_plan;
  String? address;

  Data(
      {this.id,
      this.kitchenname,
      this.orderid,
      this.orderfrom,
      this.orderItems,
      this.meal_plan,
      this.meal_type,
      this.address});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kitchenname = json['kitchenname'];
    orderid = json['orderid'];
    meal_plan = json['meal_plan'];
    meal_type = json['meal_type'];
    orderfrom = json['orderfrom'];
    orderItems = json['order_items'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['kitchenname'] = this.kitchenname;
    data['orderid'] = this.orderid;
    data['meal_plan'] = this.meal_plan;
    data['meal_type'] = this.meal_type;
    data['orderfrom'] = this.orderfrom;
    data['order_items'] = this.orderItems;
    data['address'] = this.address;
    return data;
  }
}
