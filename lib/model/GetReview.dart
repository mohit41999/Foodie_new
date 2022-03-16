class GetReview {
  bool? status;
  String? message;
  List<Data>? data;

  GetReview({this.status, this.message, this.data});

  GetReview.fromJson(Map<String, dynamic> json) {
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
  String? riderName;
  String? ratting;
  String? reviewDescription;
  String? time;

  Data({this.riderName, this.ratting, this.reviewDescription, this.time});

  Data.fromJson(Map<String, dynamic> json) {
    riderName = json['rider_name'];
    ratting = json['ratting'];
    reviewDescription = json['review_description'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rider_name'] = this.riderName;
    data['ratting'] = this.ratting;
    data['review_description'] = this.reviewDescription;
    data['time'] = this.time;
    return data;
  }
}