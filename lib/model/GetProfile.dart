class GetProfile {
  bool? status;
  String? message;
  List<Data>? data;

  GetProfile({this.status, this.message, this.data});

  GetProfile.fromJson(Map<String, dynamic> json) {
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
  String? username;
  String? email;
  String? mobilenumber;
  String? myWallet;

  Data({this.username, this.email, this.mobilenumber, this.myWallet});

  Data.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    mobilenumber = json['mobilenumber'];
    myWallet = json['my_wallet'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['email'] = this.email;
    data['mobilenumber'] = this.mobilenumber;
    data['my_wallet'] = this.myWallet;
    return data;
  }
}
