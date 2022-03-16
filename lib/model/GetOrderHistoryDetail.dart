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
  String? status;

  Data({this.itemName, this.image, this.date, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    itemName = json['item_name'];
    image = json['image'];
    date = json['date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_name'] = this.itemName;
    data['image'] = this.image;
    data['date'] = this.date;
    data['status'] = this.status;
    return data;
  }
}
