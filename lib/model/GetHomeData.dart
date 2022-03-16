class BeanHomeData {
  bool? status;
  String? message;
  List<Data>? data;

  BeanHomeData({this.status, this.message, this.data});

  BeanHomeData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
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
  String? kitchenId;
  String? kitchenname;
  String? address;
  String? mealtype;
  String? cuisinetype;
  String? discount;
  String? image;
  String? averageRating;
  String? totalReview;
  String? time;
  String? isFavourite;


  Data({this.kitchenId,
    this.kitchenname,
    this.address,
    this.mealtype,
    this.cuisinetype,
    this.discount,
    this.image,
    this.averageRating,
    this.totalReview,
    this.time,
    this.isFavourite});

  Data.fromJson(Map<String, dynamic> json) {
    kitchenId = json['kitchen_id'];
    kitchenname = json['kitchenname'];
    address = json['address'];
    mealtype = json['mealtype'];
    cuisinetype = json['cuisinetype'];
    discount = json['discount'];
    image = json['image'];
    averageRating = json['average_rating'];
    totalReview = json['total_review'];
    time = json['time'];
    isFavourite = json['is_favourite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kitchen_id'] = this.kitchenId;
    data['kitchenname'] = this.kitchenname;
    data['address'] = this.address;
    data['mealtype'] = this.mealtype;
    data['cuisinetype'] = this.cuisinetype;
    data['discount'] = this.discount;
    data['image'] = this.image;
    data['average_rating'] = this.averageRating;
    data['total_review'] = this.totalReview;
    data['time'] = this.time;
    data['is_favourite'] = this.isFavourite;
    return data;
  }
}