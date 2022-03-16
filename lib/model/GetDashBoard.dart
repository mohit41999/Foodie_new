class GetDashBoard {
  bool? status;
  String? message;
  List<Data>? data;

  GetDashBoard({this.status, this.message, this.data});

  GetDashBoard.fromJson(Map<String, dynamic> json) {
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
  String? item;
  String? arriving;

  Data({this.id, this.kitchenname, this.item, this.arriving});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kitchenname = json['kitchenname'];
    item = json['item'];
    arriving = json['arriving'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['kitchenname'] = this.kitchenname;
    data['item'] = this.item;
    data['arriving'] = this.arriving;
    return data;
  }
}
