class GetCartCount {
  bool? status;
  String? message;
  Data? data;

  GetCartCount({this.status, this.message, this.data});

  GetCartCount.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ?!(json['data'] is List)? new Data.fromJson(json['data']):null : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? cartCount;

  Data({this.cartCount});

  Data.fromJson(Map<String, dynamic> json) {
    cartCount = json['cart_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_count'] = this.cartCount;
    return data;
  }
}