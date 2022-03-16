import 'package:food_app/model/BeanLogin.dart';

class RemoveCart {
  bool? status;
  String? message;
  List<Data>? data;

  RemoveCart({this.status, this.message, this.data});

  RemoveCart.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    // ignore: deprecated_member_use
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
