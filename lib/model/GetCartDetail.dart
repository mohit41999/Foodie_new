class GetCartDetail {
  bool? status;
  String? message;
  Data? data;

  GetCartDetail({this.status, this.message, this.data});

  GetCartDetail.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
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
  List<CartItems>? cartItems;
  String? distanceInKm;
  String? totalAmount;
  String? taxAmount;
  String? deliveryCharge;
  MyLocation? myLocation;

  Data(
      {this.cartItems,
        this.distanceInKm,
        this.totalAmount,
        this.taxAmount,
        this.deliveryCharge,
        this.myLocation});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['cart_items'] != null) {
      cartItems = <CartItems>[];
      json['cart_items'].forEach((v) {
        cartItems!.add(new CartItems.fromJson(v));
      });
    }
    distanceInKm = json['distance_in_km'];
    totalAmount = json['total_amount'];
    taxAmount = json['tax_amount'];
    deliveryCharge = json['delivery_charge'];
    myLocation = json['my_location'] != null
        ? new MyLocation.fromJson(json['my_location'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cartItems != null) {
      data['cart_items'] = this.cartItems!.map((v) => v.toJson()).toList();
    }
    data['distance_in_km'] = this.distanceInKm;
    data['total_amount'] = this.totalAmount;
    data['tax_amount'] = this.taxAmount;
    data['delivery_charge'] = this.deliveryCharge;
    if (this.myLocation != null) {
      data['my_location'] = this.myLocation!.toJson();
    }
    return data;
  }
}

class CartItems {
  String? cartId;
  String? kitchenId;
  String? itemName;
  String? menuimage;
  String? quantity;
  String? price;
  String? totalPrice;
  String? mealtype;
  String? cuisinetype;
  String? deliveryDate;
  String? deliveryFromtime;
  String? deliveryTotime;
  String? includingSaturday;
  String? includingSunday;
  String? createddate;
  var count =1;

  CartItems(
      {this.cartId,
        this.kitchenId,
        this.itemName,
        this.menuimage,
        this.quantity,
        this.price,
        this.totalPrice,
        this.mealtype,
        this.cuisinetype,
        this.deliveryDate,
        this.deliveryFromtime,
        this.deliveryTotime,
        this.includingSaturday,
        this.includingSunday,
        this.createddate});

  CartItems.fromJson(Map<String, dynamic> json) {
    cartId = json['cart_id'];
    kitchenId = json['kitchen_id'];
    itemName = json['item_name'];
    menuimage = json['menuimage'];
    quantity = json['quantity'];
    price = json['price'];
    totalPrice = json['total_price'];
    mealtype = json['mealtype'];
    cuisinetype = json['cuisinetype'];
    deliveryDate = json['delivery_date'];
    deliveryFromtime = json['delivery_fromtime'];
    deliveryTotime = json['delivery_totime'];
    includingSaturday = json['including_saturday'];
    includingSunday = json['including_sunday'];
    createddate = json['createddate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_id'] = this.cartId;
    data['kitchen_id'] = this.kitchenId;
    data['item_name'] = this.itemName;
    data['menuimage'] = this.menuimage;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['total_price'] = this.totalPrice;
    data['mealtype'] = this.mealtype;
    data['cuisinetype'] = this.cuisinetype;
    data['delivery_date'] = this.deliveryDate;
    data['delivery_fromtime'] = this.deliveryFromtime;
    data['delivery_totime'] = this.deliveryTotime;
    data['including_saturday'] = this.includingSaturday;
    data['including_sunday'] = this.includingSunday;
    data['createddate'] = this.createddate;
    return data;
  }
}

class MyLocation {
  String? address;
  String? latitude;
  String? longitude;

  MyLocation({this.address, this.latitude, this.longitude});

  MyLocation.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}