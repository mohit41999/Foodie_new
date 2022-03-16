class KitchenDetail {
  bool? status;
  String? message;
  List<Data>? data;

  KitchenDetail({this.status, this.message, this.data});

  KitchenDetail.fromJson(Map<String, dynamic> json) {
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
  String? kitchenname;
  String? foodtype;
  String? address;
  String? timing;
  String? openStatus;
  String? totalReview;
  int? avgReview;

  List<Offers>? offers;
  List<Menu>? menu;

  Data(
      {this.kitchenname,
        this.foodtype,
        this.address,
        this.timing,
        this.openStatus,
        this.totalReview,
        this.avgReview,
        this.offers,

        this.menu});

  Data.fromJson(Map<String, dynamic> json) {
    kitchenname = json['kitchenname'];
    foodtype = json['foodtype'];
    address = json['address'];
    timing = json['timing'];
    openStatus = json['open_status'];
    totalReview = json['total_review'];
    avgReview = json['avg_review'];

    if (json['offers'] != null) {
      offers = <Offers>[];
      json['offers'].forEach((v) {
        offers!.add(new Offers.fromJson(v));
      });
    }
    if (json['menu'] != null) {
      menu = <Menu>[];
      json['menu'].forEach((v) {
        menu!.add(new Menu.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kitchenname'] = this.kitchenname;
    data['foodtype'] = this.foodtype;
    data['address'] = this.address;
    data['timing'] = this.timing;
    data['open_status'] = this.openStatus;
    data['total_review'] = this.totalReview;
    data['avg_review'] = this.avgReview;

    if (this.offers != null) {
      data['offers'] = this.offers!.map((v) => v.toJson()).toList();
    }
    if (this.menu != null) {
      data['menu'] = this.menu!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Offers {
  String? offercode;
  String? discounttype;
  int? discount;

  Offers({this.offercode, this.discounttype, this.discount});

  Offers.fromJson(Map<String, dynamic> json) {
    offercode = json['offercode'];
    discounttype = json['discounttype'];
    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['offercode'] = this.offercode;
    data['discounttype'] = this.discounttype;
    data['discount'] = this.discount;
    return data;
  }
}

class Menu {
  String? itemid;
  String? bookType;
  String? itemname;
  String? cuisinetype;
  String? including;
  String? itemprice;
  var count=0;

  Menu(
      {this.itemid,
        this.bookType,
        this.itemname,
        this.cuisinetype,
        this.including,
        this.itemprice});

  Menu.fromJson(Map<String, dynamic> json) {
    itemid = json['itemid'];
    bookType = json['book_type'];
    itemname = json['itemname'];
    cuisinetype = json['cuisinetype'];
    including = json['including'];
    itemprice = json['itemprice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemid'] = this.itemid;
    data['book_type'] = this.bookType;
    data['itemname'] = this.itemname;
    data['cuisinetype'] = this.cuisinetype;
    data['including'] = this.including;
    data['itemprice'] = this.itemprice;
    return data;
  }
}