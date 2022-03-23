class BeanBanner {
  bool? status;
  String? message;
  Data? data;

  BeanBanner({this.status, this.message, this.data});

  BeanBanner.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != [] ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? orderitemsid;
  String? ordertype;
  String? packagetype;
  String? kitchenName;
  String? kitchenMobileno;
  String? riderName;
  String? riderMobileno;
  String? riderRating;
  String? riderReview;
  String? trackRiderLatitude;
  String? trackRiderLongitude;
  Meal? meal;

  Data(
      {this.orderitemsid,
      this.ordertype,
      this.packagetype,
      this.kitchenName,
      this.kitchenMobileno,
      this.riderName,
      this.riderMobileno,
      this.riderRating,
      this.riderReview,
      this.trackRiderLatitude,
      this.trackRiderLongitude,
      this.meal});

  Data.fromJson(Map<String, dynamic> json) {
    orderitemsid = json['orderitemsid'];
    ordertype = json['ordertype'];
    packagetype = json['packagetype'];
    kitchenName = json['kitchen_name'];
    kitchenMobileno = json['kitchen_mobileno'];
    riderName = json['rider_name'];
    riderMobileno = json['rider_mobileno'];
    riderRating = json['rider_rating'];
    riderReview = json['rider_review'];
    trackRiderLatitude = json['track_rider_latitude'];
    trackRiderLongitude = json['track_rider_longitude'];
    meal = json['meal'] != null ? new Meal.fromJson(json['meal']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderitemsid'] = this.orderitemsid;
    data['ordertype'] = this.ordertype;
    data['packagetype'] = this.packagetype;
    data['kitchen_name'] = this.kitchenName;
    data['kitchen_mobileno'] = this.kitchenMobileno;
    data['rider_name'] = this.riderName;
    data['rider_mobileno'] = this.riderMobileno;
    data['rider_rating'] = this.riderRating;
    data['rider_review'] = this.riderReview;
    data['track_rider_latitude'] = this.trackRiderLatitude;
    data['track_rider_longitude'] = this.trackRiderLongitude;
    if (this.meal != null) {
      data['meal'] = this.meal!.toJson();
    }
    return data;
  }
}

class Meal {
  String? id;
  String? mealplan;
  String? referenceId;
  String? deliveryDate;
  String? deliveryFromtime;
  String? plan;
  String? itemName;

  Meal(
      {this.id,
      this.mealplan,
      this.referenceId,
      this.deliveryDate,
      this.deliveryFromtime,
      this.plan,
      this.itemName});

  Meal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mealplan = json['mealplan'];
    referenceId = json['reference_id'];
    deliveryDate = json['delivery_date'];
    deliveryFromtime = json['delivery_fromtime'];
    plan = json['plan'];
    itemName = json['item_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mealplan'] = this.mealplan;
    data['reference_id'] = this.referenceId;
    data['delivery_date'] = this.deliveryDate;
    data['delivery_fromtime'] = this.deliveryFromtime;
    data['plan'] = this.plan;
    data['item_name'] = this.itemName;
    return data;
  }
}
