class GetOrderHistory {
  bool? status;
  String? message;
  List<Data>? data;

  GetOrderHistory({this.status, this.message, this.data});

  GetOrderHistory.fromJson(Map<String, dynamic> json) {
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
  String? orderId;
  String? kitchenname;
  String? ordernumber;
  String? orderfrom;
  String? status;
  String? orderOf;
  String? totalbill;

  Data(
      {this.orderId,
      this.kitchenname,
      this.ordernumber,
      this.orderfrom,
      this.status,
      this.orderOf,
      this.totalbill});

  Data.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    kitchenname = json['kitchenname'];
    ordernumber = json['ordernumber'];
    orderfrom = json['orderfrom'];
    status = json['status'];
    orderOf = json['order_of'];
    totalbill = json['totalbill'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['kitchenname'] = this.kitchenname;
    data['ordernumber'] = this.ordernumber;
    data['orderfrom'] = this.orderfrom;
    data['status'] = this.status;
    data['order_of'] = this.orderOf;
    data['totalbill'] = this.totalbill;
    return data;
  }
}
