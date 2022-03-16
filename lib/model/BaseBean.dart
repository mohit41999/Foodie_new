import 'package:food_app/model/GetLiveOffer.dart';

class BaseBean {
  bool? status;
  String? message;

  BaseBean({this.status, this.message});

  BaseBean.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}