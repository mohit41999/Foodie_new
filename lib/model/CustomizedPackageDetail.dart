class BeanCustomizedPackageDetail {
  bool? status;
  String? message;
  Data? data;

  BeanCustomizedPackageDetail({this.status, this.message, this.data});

  BeanCustomizedPackageDetail.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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
  String? kitchenId;
  String? packageId;
  String? packageName;
  String? mealfor;
  String? mealtype;
  String? cuisinetype;
  String? price;
  List<PackageDetail>? packageDetail;

  Data(
      {this.kitchenId,
      this.packageId,
      this.packageName,
      this.mealfor,
      this.mealtype,
      this.cuisinetype,
      this.price,
      this.packageDetail});

  Data.fromJson(Map<String, dynamic> json) {
    kitchenId = json['kitchen_id'];
    packageId = json['package_id'];
    packageName = json['package_name'];
    mealfor = json['mealfor'];
    mealtype = json['mealtype'];
    cuisinetype = json['cuisinetype'];
    price = json['price'];
    if (json['package_detail'] != null) {
      packageDetail = <PackageDetail>[];
      json['package_detail'].forEach((v) {
        packageDetail!.add(new PackageDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kitchen_id'] = this.kitchenId;
    data['package_id'] = this.packageId;
    data['package_name'] = this.packageName;
    data['mealfor'] = this.mealfor;
    data['mealtype'] = this.mealtype;
    data['cuisinetype'] = this.cuisinetype;
    data['price'] = this.price;
    if (this.packageDetail != null) {
      data['package_detail'] =
          this.packageDetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PackageDetail {
  String? weeklyPackageId;
  String? days;
  dynamic? daysName;
  String? itemName;
  String? customisedTime;

  PackageDetail(
      {this.weeklyPackageId,
      this.days,
      this.daysName,
      this.itemName,
      this.customisedTime});

  PackageDetail.fromJson(Map<String, dynamic> json) {
    weeklyPackageId = json['weekly_package_id'];
    days = json['days'];
    daysName = json['days_name'];
    itemName = json['item_name'];
    customisedTime = json['customised_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['weekly_package_id'] = this.weeklyPackageId;
    data['days'] = this.days;
    data['days_name'] = this.daysName;
    data['item_name'] = this.itemName;
    data['customised_time'] = this.customisedTime;
    return data;
  }
}
