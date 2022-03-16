class GetFeedback {
  bool? status;
  String? message;
  Data? data;

  GetFeedback({this.status, this.message, this.data});

  GetFeedback.fromJson(Map<String, dynamic> json) {
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
  String? totalrating;
  String? totalreview;
  List<Feedback>? feedback;

  Data({this.totalrating, this.totalreview, this.feedback});

  Data.fromJson(Map<String, dynamic> json) {
    totalrating = json['totalrating'];
    totalreview = json['totalreview'];
    if (json['feedback'] != null) {
      feedback = [];
      json['feedback'].forEach((v) {
        feedback!.add(new Feedback.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalrating'] = this.totalrating;
    data['totalreview'] = this.totalreview;
    if (this.feedback != null) {
      data['feedback'] = this.feedback!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Feedback {
  String? customerName;
  String? customerPhoto;
  String? rating;
  String? message;
  String? createdtime;

  Feedback(
      {this.customerName,
      this.customerPhoto,
      this.rating,
      this.message,
      this.createdtime});

  Feedback.fromJson(Map<String, dynamic> json) {
    customerName = json['customer_name'];
    customerPhoto = json['customer_photo'];
    rating = json['rating'];
    message = json['message'];
    createdtime = json['createdtime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_name'] = this.customerName;
    data['customer_photo'] = this.customerPhoto;
    data['rating'] = this.rating;
    data['message'] = this.message;
    data['createdtime'] = this.createdtime;
    return data;
  }
}
