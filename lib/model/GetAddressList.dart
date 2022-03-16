class GetAddressList {
  bool? status;
  String? message;
  List<Data>? data;

  GetAddressList({this.status, this.message, this.data});

  GetAddressList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add( Data.fromJson(v));
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
  List<NearbyKitchen>? nearbyKitchen;
  List<Recent>? recent;

  Data({this.nearbyKitchen, this.recent});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['nearby_kitchen'] != null) {
      nearbyKitchen = [];
      json['nearby_kitchen'].forEach((v) {
        nearbyKitchen!.add( NearbyKitchen.fromJson(v));
      });
    }
    if (json['recent'] != null) {
      recent = [];
      json['recent'].forEach((v) {
        recent!.add( Recent.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    if (this.nearbyKitchen != null) {
      data['nearby_kitchen'] =
          this.nearbyKitchen!.map((v) => v.toJson()).toList();
    }
    if (this.recent != null) {
      data['recent'] = this.recent!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NearbyKitchen {
  String? id;
  String? kitchenname;
  String? deliveryaddress;

  NearbyKitchen({this.id, this.kitchenname, this.deliveryaddress});

  NearbyKitchen.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kitchenname = json['kitchenname'];
    deliveryaddress = json['deliveryaddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['kitchenname'] = this.kitchenname;
    data['deliveryaddress'] = this.deliveryaddress;
    return data;
  }
}

class Recent {
  String? id;
  String? kitchenname;
  String? deliveryaddress;

  Recent({this.id, this.kitchenname, this.deliveryaddress});

  Recent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kitchenname = json['kitchenname'];
    deliveryaddress = json['deliveryaddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['kitchenname'] = this.kitchenname;
    data['deliveryaddress'] = this.deliveryaddress;
    return data;
  }
}
