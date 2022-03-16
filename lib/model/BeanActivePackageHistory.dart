class BeanActivePackageHistory {
  bool? status;
  String? message;
  List<Data>? data;

  BeanActivePackageHistory({this.status, this.message, this.data});

  BeanActivePackageHistory.fromJson(Map<String, dynamic> json) {
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
  String? packagename;
  String? orderid;
  String? orderDates;
  String? cuisinetype;
  List<DayList>? dayList;

  Data(
      {this.packagename,
      this.orderid,
      this.orderDates,
      this.cuisinetype,
      this.dayList});

  Data.fromJson(Map<String, dynamic> json) {
    packagename = json['packagename'];
    orderid = json['orderid'];
    orderDates = json['order_dates'];
    cuisinetype = json['cuisinetype'];
    if (json['day_list'] != null) {
      dayList = [];
      json['day_list'].forEach((v) {
        dayList!.add(new DayList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['packagename'] = this.packagename;
    data['orderid'] = this.orderid;
    data['order_dates'] = this.orderDates;
    data['cuisinetype'] = this.cuisinetype;
    if (this.dayList != null) {
      data['day_list'] = this.dayList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DayList {
  String? id;
  String? day;
  String? menuItem;
  String? time;
  String? status;

  DayList({this.id, this.day, this.menuItem, this.time, this.status});

  DayList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    day = json['day'];
    menuItem = json['menu_item'];
    time = json['time'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['day'] = this.day;
    data['menu_item'] = this.menuItem;
    data['time'] = this.time;
    data['status'] = this.status;
    return data;
  }
}
