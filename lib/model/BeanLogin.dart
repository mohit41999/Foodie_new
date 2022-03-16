class BeanLogin {
  bool? status;
  String? message;
  Data? data;

  BeanLogin({this.status, this.message, this.data});

  BeanLogin.fromJson(Map<String, dynamic> json) {
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
  String? otpcode;
  String? mobilenumber;

  Data({this.otpcode, this.mobilenumber});

  Data.fromJson(Map<String, dynamic> json) {
    otpcode = json['otpcode'];
    mobilenumber = json['mobilenumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['otpcode'] = this.otpcode;
    data['mobilenumber'] = this.mobilenumber;
    return data;
  }
}