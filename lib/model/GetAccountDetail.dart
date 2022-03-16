class GetAccountDetails {
    bool? status;
    String? message;
    Data? data;

    GetAccountDetails({this.status, this.message, this.data});

    GetAccountDetails.fromJson(Map<String, dynamic> json) {
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
    String? userId;
    String? kitchenName;
    String? address;
    String? email;
    String? mobileNumber;
    String? password;
    String? typeOfFirm;
    String? typeOfFood;
    String? fromTime;
    String? toTime;
    String? openDays;
    String? typeOfMeals;
    String? totalrating;
    String? menufile;
    String? documentfile;

    Data(
        {this.userId,
            this.kitchenName,
            this.address,
            this.email,
            this.mobileNumber,
            this.password,
            this.typeOfFirm,
            this.typeOfFood,
            this.fromTime,
            this.toTime,
            this.openDays,
            this.typeOfMeals,
            this.totalrating,
            this.menufile,
            this.documentfile});

    Data.fromJson(Map<String, dynamic> json) {
        userId = json['user_id'];
        kitchenName = json['kitchen_name'];
        address = json['address'];
        email = json['email'];
        mobileNumber = json['mobile_number'];
        password = json['password'];
        typeOfFirm = json['type_of_firm'];
        typeOfFood = json['type_of_food'];
        fromTime = json['from_time'];
        toTime = json['to_time'];
        openDays = json['open_days'];
        typeOfMeals = json['type_of_meals'];
        totalrating = json['totalrating'];
        menufile = json['menufile'];
        documentfile = json['documentfile'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['user_id'] = this.userId;
        data['kitchen_name'] = this.kitchenName;
        data['address'] = this.address;
        data['email'] = this.email;
        data['mobile_number'] = this.mobileNumber;
        data['password'] = this.password;
        data['type_of_firm'] = this.typeOfFirm;
        data['type_of_food'] = this.typeOfFood;
        data['from_time'] = this.fromTime;
        data['to_time'] = this.toTime;
        data['open_days'] = this.openDays;
        data['type_of_meals'] = this.typeOfMeals;
        data['totalrating'] = this.totalrating;
        data['menufile'] = this.menufile;
        data['documentfile'] = this.documentfile;
        return data;
    }
}
