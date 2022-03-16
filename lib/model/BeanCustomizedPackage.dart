class BeanCustomizedPackage {
  bool? status;
  String? message;
  List<Data>? data;

  BeanCustomizedPackage({this.status, this.message, this.data});

  BeanCustomizedPackage.fromJson(Map<String, dynamic> json) {
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
  String? category;
  List<Menuitems>? menuitems;

  Data({this.category, this.menuitems});

  Data.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    if (json['menuitems'] != null) {
      menuitems = [];
      json['menuitems'].forEach((v) {
        menuitems!.add(new Menuitems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    if (this.menuitems != null) {
      data['menuitems'] = this.menuitems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Menuitems {
  String? menuId;
  String? itemname;
  String? itemprice;
  int itemQty = 0;

  bool? isCheckedDays = false;

  Menuitems({this.menuId, this.itemname, this.itemprice});

  Menuitems.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    itemname = json['itemname'];
    itemprice = json['itemprice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['itemname'] = this.itemname;
    data['itemprice'] = this.itemprice;
    return data;
  }
}
