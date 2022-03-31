import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/Menu/menu_bean.dart';
import 'package:food_app/model/AddOffer.dart';
import 'package:food_app/model/BaseBean.dart';
import 'package:food_app/model/BeanActivePackageHistory.dart';
import 'package:food_app/model/BeanAddCard.dart';
import 'package:food_app/model/BeanAddCart.dart';
import 'package:food_app/model/BeanAddCustomizePackageTime.dart';
import 'package:food_app/model/BeanAddOrder.dart';
import 'package:food_app/model/BeanAddPackage.dart';
import 'package:food_app/model/BeanApplyPromo.dart';
import 'package:food_app/model/BeanBanner.dart';
import 'package:food_app/model/BeanCartDetail.dart';
import 'package:food_app/model/BeanClearRecentsearch.dart';
import 'package:food_app/model/BeanConfirmLocation.dart';
import 'package:food_app/model/BeanCustomizedPackage.dart';
import 'package:food_app/model/BeanDepositPayment.dart';
import 'package:food_app/model/BeanFavKitchen.dart';
import 'package:food_app/model/BeanForgotPassword.dart';
import 'package:food_app/model/BeanGetCard.dart';
import 'package:food_app/model/BeanGetPackages.dart';
import 'package:food_app/model/BeanKitchenDetail.dart';
import 'package:food_app/model/BeanLogin.dart';
import 'package:food_app/model/BeanMakePayment.dart';
import 'package:food_app/model/BeanPackageDetail.dart';
import 'package:food_app/model/BeanRemoveKitchen.dart';
import 'package:food_app/model/BeanSearchData.dart';
import 'package:food_app/model/BeanSignUp.dart';
import 'package:food_app/model/BeanStartDelivery.dart';
import 'package:food_app/model/BeanUpdateCart.dart';
import 'package:food_app/model/BeanUpdateSetting.dart';
import 'package:food_app/model/BeanVerifyOtp.dart';
import 'package:food_app/model/CustomizedPackageDetail.dart';
import 'package:food_app/model/GetAccountDetail.dart';
import 'package:food_app/model/GetActiveOrder.dart';
import 'package:food_app/model/GetAddressList.dart';
import 'package:food_app/model/GetArchieveOffer.dart';
import 'package:food_app/model/GetCartCount.dart';
import 'package:food_app/model/GetCartDetail.dart';
import 'package:food_app/model/GetDashBoard.dart';
import 'package:food_app/model/GetDeliveryTime.dart';
import 'package:food_app/model/GetHomeData.dart';
import 'package:food_app/model/GetLiveOffer.dart';
import 'package:food_app/model/GetOrderHistory.dart';
import 'package:food_app/model/GetOrderHistoryDetail.dart';
import 'package:food_app/model/GetOverAllReview.dart';
import 'package:food_app/model/GetProfile.dart';
import 'package:food_app/model/GetReview.dart';
import 'package:food_app/model/GetUserAddress.dart';
import 'package:food_app/model/RemoveCart.dart';
import 'package:food_app/model/UpdateMenuDetails.dart';
import 'package:food_app/network/EndPoints.dart';
import 'package:http/http.dart' as http;

class ApiProvider {
  static const baseUrl =
      "https://nohungkitchen.notionprojects.tech/api/foodies/";

  //static const _baseUrl = "https://nohung.com/api/foodies/";
  static const String TAG = "ApiProvider";

  final Dio _dio = Dio();
  late DioError _dioError;

  // ApiProvider() {
  //   BaseOptions dioOptions = BaseOptions()..baseUrl = ApiProvider._baseUrl;
  //   _dio = Dio(dioOptions);
  //   _dio.interceptors
  //       .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
  //     options.headers = {
  //       'Content-Type':'multipart/form-data',
  //     };
  //     DioLogger.onSend(TAG, options);
  //     return options;
  //   }, onResponse: (Response response) {
  //     DioLogger.onSuccess(TAG, response);
  //     return response;
  //   }, onError: (DioError error) {
  //     DioLogger.onError(TAG, error);
  //     return error;
  //   }));
  // }

  Future registerUser(FormData params) async {
    try {
      Response response =
          await _dio.post("$baseUrl/${EndPoints.register}", data: params);
      return BeanSignUp.fromJson(jsonDecode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic>? map = _dioError.response!.data;
      if (_dioError.response!.statusCode == 500) {
        throwIfNoSuccess(map!['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  //Login  API  New   Code
  // Future<bool> login(String mobileNumber) async {
  //   try {
  //     http.Response response = await http.post(
  //         Uri.parse("$baseUrl/login_with_mobile.php"),
  //         body: {'mobilenumber': mobileNumber, 'token': "123456789"});
  //     var data = jsonDecode(response.body);
  //
  //     if (response.statusCode == 200 && data['status'] == true) {
  //       Fluttertoast.showToast(msg: "${data['message']}");
  //
  //       if (kDebugMode) {
  //         print(response.body);
  //       }
  //
  //       return true;
  //     } else {
  //       Fluttertoast.showToast(msg: "${data['message']}");
  //       return false;
  //     }
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print("Login  APi  Call  Error $e");
  //     }
  //     return false;
  //   }
  // }

  //Verify Otp   New  API Code

  // Future<bool> verifyOtpForLogin(String mobileNumber, String otp) async {
  //   try {
  //     http.Response response = await http
  //         .post(Uri.parse("$baseUrl/verify_otp.php"), body: {
  //       'mobilenumber': mobileNumber,
  //       'otp': otp,
  //       'token': '123456789'
  //     });
  //
  //     var data = jsonDecode(response.body);
  //
  //     if (response.statusCode == 200 && data['status'] == true) {
  //       Fluttertoast.showToast(msg: "${data['message']}");
  //
  //       return true;
  //     } else {
  //       Fluttertoast.showToast(msg: "${data['message']}");
  //
  //       return true;
  //     }
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print("Verify Otp API  Call Error $e");
  //     }
  //     return false;
  //   }
  // }

  Future<BeanLogin?> loginUser(FormData params) async {
    try {
      Response response =
          await _dio.post("$baseUrl/${EndPoints.login}", data: params);
      return BeanLogin.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic>? map = _dioError.response!.data;
      if (_dioError.response!.statusCode == 500) {
        throwIfNoSuccess(map!['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<BeanVerifyOtp?> verifyOtp(FormData params) async {
    try {
      Response response =
          await _dio.post("$baseUrl/${EndPoints.verify_otp}", data: params);
      return BeanVerifyOtp.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic>? map = _dioError.response!.data;
      if (_dioError.response!.statusCode == 500) {
        throwIfNoSuccess(map!['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<BeanSearchData?> searchData(FormData params) async {
    try {
      Response response =
          await _dio.post("$baseUrl/${EndPoints.search}", data: params);
      return BeanSearchData.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      var map = _dioError.response!.data;
      if (_dioError.response!.statusCode == 500) {
        throwIfNoSuccess(map!['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<GetDeliveryTime?> getDeliveryTime(FormData params) async {
    try {
      Response response = await _dio
          .post("$baseUrl/${EndPoints.get_delivery_time}", data: params);
      return GetDeliveryTime.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic>? map = _dioError.response!.data;
      if (_dioError.response!.statusCode == 500) {
        throwIfNoSuccess(map!['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<BeanAddCustomizeTime?> addCustomizedPackageDateTime(
      FormData params) async {
    try {
      Response response = await _dio.post(
          "$baseUrl/${EndPoints.add_customized_package_date_time}",
          data: params);
      return BeanAddCustomizeTime.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic>? map = _dioError.response!.data;
      if (_dioError.response!.statusCode == 500) {
        throwIfNoSuccess(map!['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<GetDeliveryTime?> getCard(FormData params) async {
    try {
      Response response = await _dio
          .post("$baseUrl/${EndPoints.get_delivery_time}", data: params);
      return GetDeliveryTime.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic>? map = _dioError.response!.data;
      if (_dioError.response!.statusCode == 500) {
        throwIfNoSuccess(map!['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<BeanClearRecentSearch?> clearRecentSearch(FormData params) async {
    try {
      Response response = await _dio
          .post("$baseUrl/${EndPoints.clear_recent_search}", data: params);
      return BeanClearRecentSearch.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic>? map = _dioError.response!.data;
      if (_dioError.response!.statusCode == 500) {
        throwIfNoSuccess(map!['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<BeanFavKitchen?> favKitchen(FormData params) async {
    try {
      Response response = await _dio
          .post("$baseUrl/${EndPoints.add_favorite_kitchen}", data: params);
      return BeanFavKitchen.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic>? map = _dioError.response!.data;
      if (_dioError.response!.statusCode == 500) {
        throwIfNoSuccess(map!['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<BeanRemoveKitchen?> removeKitchen(FormData params) async {
    try {
      Response response =
          await _dio.post("$baseUrl/${EndPoints.removeKitchen}", data: params);
      return BeanRemoveKitchen.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("Exception occurred: $error stackTrace: $stacktrace");
      }
      Map<dynamic, dynamic>? map = _dioError.response!.data;
      if (_dioError.response!.statusCode == 500) {
        throwIfNoSuccess(map!['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<GetAddressList?> getAddress(FormData params) async {
    try {
      Response response = await _dio
          .post("$baseUrl/${EndPoints.search_location}", data: params);
      return GetAddressList.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("Exception occurred: $error stackTrace: $stacktrace");
      }
      Map<dynamic, dynamic>? map = _dioError.response!.data;
      if (_dioError.response!.statusCode == 500) {
        throwIfNoSuccess(map!['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<BeanDepositPayment?> depositPayment(FormData params) async {
    try {
      Response response = await _dio
          .post("$baseUrl/${EndPoints.deposit_payment}", data: params);
      return BeanDepositPayment.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic>? map = _dioError.response!.data;
      if (_dioError.response!.statusCode == 500) {
        throwIfNoSuccess(map!['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<BeanForgotPassword?> forgotPassword(FormData params) async {
    try {
      Response response = await _dio
          .post("$baseUrl/${EndPoints.forgot_password}", data: params);
      return BeanForgotPassword.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic>? map = _dioError.response!.data;
      if (_dioError.response!.statusCode == 500) {
        throwIfNoSuccess(map!['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<BeanVerifyOtp?> loginWithEmail(FormData params) async {
    print(params.fields);
    try {
      Response response =
          await _dio.post("$baseUrl/login_with_email.php", data: params);
      print(response.data);
      return BeanVerifyOtp.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic>? map = _dioError.response!.data;
      if (_dioError.response!.statusCode == 500) {
        throwIfNoSuccess(map!['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future signupWithEmail(FormData params) async {
    print(params.fields);
    try {
      Response response = await _dio.post("$baseUrl/signup.php", data: params);
      print(response.data);
      return json.decode(response.data);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic>? map = _dioError.response!.data;
      if (_dioError.response!.statusCode == 500) {
        throwIfNoSuccess(map!['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<BeanAddCard?> beanAddcard(FormData params) async {
    try {
      Response response = await _dio
          .post("$baseUrl/${EndPoints.add_card_detail}", data: params);
      return BeanAddCard.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic>? map = _dioError.response!.data;
      if (_dioError.response!.statusCode == 500) {
        throwIfNoSuccess(map!['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<BeanGetCard?> beanGetCard(FormData params) async {
    try {
      Response response =
          await _dio.post("$baseUrl/${EndPoints.get_cards}", data: params);
      return BeanGetCard.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic>? map = _dioError.response!.data;
      if (_dioError.response!.statusCode == 500) {
        throwIfNoSuccess(map!['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<GetProfile?> getProfile(FormData params) async {
    try {
      Response response =
          await _dio.post("$baseUrl/${EndPoints.get_my_profile}", data: params);
      return GetProfile.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic>? map = _dioError.response!.data;
      if (_dioError.response!.statusCode == 500) {
        throwIfNoSuccess(map!['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<KitchenDetail?> kitchenDetail(FormData params) async {
    try {
      Response response =
          await _dio.post("$baseUrl/${EndPoints.KitchenDetail}", data: params);
      return KitchenDetail.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic>? map = _dioError.response!.data;
      if (_dioError.response!.statusCode == 500) {
        throwIfNoSuccess(map!['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<GetDashBoard?> getDashboard(FormData params) async {
    try {
      Response response =
          await _dio.post("$baseUrl/${EndPoints.dashboard}", data: params);
      return GetDashBoard.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic>? map = _dioError.response!.data;
      if (_dioError.response!.statusCode == 500) {
        throwIfNoSuccess(map!['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<BeanHomeData?> getHomeData(FormData params) async {
    try {
      Response response =
          await _dio.post("$baseUrl/${EndPoints.search_kitchen}", data: params);
      print("Mine: ${response.data}");
      return BeanHomeData.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic>? map = _dioError.response!.data;
      if (_dioError.response!.statusCode == 500) {
        throwIfNoSuccess(map!['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<BeanCartDetail?> getCart(FormData params) async {
    try {
      Response response =
          await _dio.post("$baseUrl/${EndPoints.search_kitchen}", data: params);
      print("Mine: ${response.data}");
      return BeanCartDetail.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic>? map = _dioError.response!.data;
      if (_dioError.response!.statusCode == 500) {
        throwIfNoSuccess(map!['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<BeanBanner?> bannerData(FormData params) async {
    try {
      Response response = await _dio
          .post("$baseUrl/${EndPoints.get_today_deliver_order}", data: params);
      print("Mine: ${response.data}");
      return BeanBanner.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic>? map = _dioError.response!.data;
      if (_dioError.response!.statusCode == 500) {
        throwIfNoSuccess(map!['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<RemoveCart?> removeCart(FormData params) async {
    try {
      Response response =
          await _dio.post("$baseUrl/remove_cart_item.php", data: params);
      print("Mine: ${response.data}");
      return RemoveCart.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic>? map = _dioError.response!.data;
      if (_dioError.response!.statusCode == 500) {
        throwIfNoSuccess(map!['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<GetCartDetail?> getCartDetail(FormData params) async {
    try {
      Response response = await _dio
          .post("$baseUrl/${EndPoints.get_cart_details}", data: params);

      return GetCartDetail.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic>? map = _dioError.response!.data;
      if (_dioError.response!.statusCode == 500) {
        throwIfNoSuccess(map!['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<BeanStartDelivery?> startDelivery(FormData params) async {
    try {
      Response response = await _dio
          .post("$baseUrl/${EndPoints.track_delivery_map}", data: params);
      return BeanStartDelivery.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic>? map = _dioError.response!.data;
      if (_dioError.response!.statusCode == 500) {
        throwIfNoSuccess(map!['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<BeanPackageDetail?> packageDetail(FormData params) async {
    try {
      Response response = await _dio
          .post("$baseUrl/${EndPoints.get_package_detail}", data: params);
      return BeanPackageDetail.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic>? map = _dioError.response!.data;
      if (_dioError.response!.statusCode == 500) {
        throwIfNoSuccess(map!['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<BeanCustomizedPackage?> customPackage(FormData params) async {
    try {
      Response response = await _dio.post(
          "$baseUrl/${EndPoints.get_package_customizable_item}",
          data: params);
      return BeanCustomizedPackage.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic>? map = _dioError.response!.data;
      if (_dioError.response!.statusCode == 500) {
        throwIfNoSuccess(map!['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<BeanCustomizedPackageDetail?> customizedPackageDetail(
      FormData params) async {
    try {
      Response response = await _dio.post(
          "$baseUrl/${EndPoints.get_customised_package_detail}",
          data: params);
      return BeanCustomizedPackageDetail.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic>? map = _dioError.response!.data;
      if (_dioError.response!.statusCode == 500) {
        throwIfNoSuccess(map!['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<BeanMakePayment?> makePayment(FormData params) async {
    try {
      Response response =
          await _dio.post("$baseUrl/${EndPoints.make_payment}", data: params);
      return BeanMakePayment.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic>? map = _dioError.response!.data;
      if (_dioError.response!.statusCode == 500) {
        throwIfNoSuccess(map!['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<BeanActivePackageHistory?> activePackageHistory(
      FormData params) async {
    try {
      Response response = await _dio
          .post("$baseUrl/${EndPoints.active_packages_history}", data: params);
      return BeanActivePackageHistory.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic>? map = _dioError.response!.data;
      if (_dioError.response!.statusCode == 500) {
        throwIfNoSuccess(map!['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<GetCartCount?> getCartCount(FormData params) async {
    try {
      Response response = await _dio
          .post("$baseUrl/${EndPoints.get_cart_items_count}", data: params);
      return GetCartCount.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic>? map = _dioError.response!.data;
      if (_dioError.response!.statusCode == 500) {
        throwIfNoSuccess(map!['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<BeanUpdateCart?> updateCart(FormData params) async {
    try {
      Response response =
          await _dio.post("$baseUrl/${EndPoints.edit_cart}", data: params);
      return BeanUpdateCart.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic>? map = _dioError.response!.data;
      if (_dioError.response!.statusCode == 500) {
        throwIfNoSuccess(map!['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<BeanAddCart?> addCart(FormData params) async {
    try {
      Response response =
          await _dio.post("$baseUrl/${EndPoints.add_to_cart}", data: params);
      return BeanAddCart.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic>? map = _dioError.response!.data;
      if (_dioError.response!.statusCode == 500) {
        throwIfNoSuccess(map!['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<BeanApplyPromo?> applyPromo(FormData params) async {
    try {
      Response response = await _dio
          .post("$baseUrl/${EndPoints.apply_coupon_code}", data: params);
      return BeanApplyPromo.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic>? map = _dioError.response!.data;
      if (_dioError.response!.statusCode == 500) {
        throwIfNoSuccess(map!['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<GetOrderHistory?> getOrderHistory(FormData params) async {
    try {
      Response response = await _dio
          .post("$baseUrl/${EndPoints.get_order_history}", data: params);
      print("GET>>>${response.data}");
      return GetOrderHistory.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic>? map = _dioError.response!.data;
      if (_dioError.response!.statusCode == 500) {
        throwIfNoSuccess(map!['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<GetOrderHistoryDetail?> getOrderHistoryDetail(FormData params) async {
    try {
      Response response = await _dio.post(
          "$baseUrl/${EndPoints.get_order_history_details}",
          data: params);
      return GetOrderHistoryDetail.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic>? map = _dioError.response!.data;
      if (_dioError.response!.statusCode == 500) {
        throwIfNoSuccess(map!['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<GetUserAddress?> getUserAddress(FormData params) async {
    try {
      Response response = await _dio
          .post("$baseUrl/${EndPoints.get_address_list}", data: params);
      return GetUserAddress.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic>? map = _dioError.response!.data;
      if (_dioError.response!.statusCode == 500) {
        throwIfNoSuccess(map!['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<GetActiveOrder?> getActiveOrder(FormData params) async {
    try {
      Response response = await _dio
          .post("$baseUrl/${EndPoints.get_active_orders}", data: params);
      return GetActiveOrder.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic>? map = _dioError.response!.data;
      if (_dioError.response!.statusCode == 500) {
        throwIfNoSuccess(map!['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<BeanAddOrder?> addFavOrder(FormData params) async {
    try {
      Response response = await _dio
          .post("$baseUrl/${EndPoints.add_favorite_order}", data: params);
      return BeanAddOrder.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic>? map = _dioError.response!.data;
      if (_dioError.response!.statusCode == 500) {
        throwIfNoSuccess(map!['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<BeanAddOrder?> removeFavOrder(FormData params) async {
    try {
      Response response = await _dio
          .post("$baseUrl/${EndPoints.remove_favorite_order}", data: params);
      return BeanAddOrder.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic>? map = _dioError.response!.data;
      if (_dioError.response!.statusCode == 500) {
        throwIfNoSuccess(map!['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<BeanVerifyOtp?> socailLogin(FormData params) async {
    try {
      Response response =
          await _dio.post("$baseUrl/${EndPoints.social_login}", data: params);
      return BeanVerifyOtp.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic>? map = _dioError.response!.data;
      if (_dioError.response!.statusCode == 500) {
        throwIfNoSuccess(map!['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<BeanConfirmLocation?> confirmlocation(FormData params) async {
    try {
      Response response = await _dio
          .post("$baseUrl/${EndPoints.confirm_location}", data: params);
      return BeanConfirmLocation.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic>? map = _dioError.response!.data;
      if (_dioError.response!.statusCode == 500) {
        throwIfNoSuccess(map!['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future getArchieveOffer(FormData params) async {
    try {
      Response response = await _dio
          .post("$baseUrl/${EndPoints.get_archive_offer}", data: params);
      return GetArchieveOffer.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic>? map = _dioError.response!.data;
      if (_dioError.response!.statusCode == 500) {
        throwIfNoSuccess(map!['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<GetReview?> getFeedback(FormData params) async {
    try {
      Response response = await _dio
          .post("$baseUrl/${EndPoints.get_received_reviews}", data: params);
      return GetReview.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic>? map = _dioError.response!.data;
      if (_dioError.response!.statusCode == 500) {
        throwIfNoSuccess(map!['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<GetOverAllReview?> getoverallreview(FormData params) async {
    try {
      Response response = await _dio.post(
          "$baseUrl/${EndPoints.get_overall_received_reviews}",
          data: params);
      return GetOverAllReview.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic>? map = _dioError.response!.data;
      if (_dioError.response!.statusCode == 500) {
        throwIfNoSuccess(map!['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future getMenu(FormData params) async {
    try {
      Response response =
          await _dio.post("$baseUrl/${EndPoints.get_menu}", data: params);
      return MenuBean.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic>? map = _dioError.response!.data;
      if (_dioError.response!.statusCode == 500) {
        throwIfNoSuccess(map!['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future updateSetting(FormData params) async {
    try {
      Response response = await _dio
          .post("$baseUrl/${EndPoints.update_settings}", data: params);
      return BeanUpdateSetting.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic>? map = _dioError.response!.data;
      if (_dioError.response!.statusCode == 500) {
        throwIfNoSuccess(map!['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future updateMenuSetting(FormData params) async {
    try {
      Response response = await _dio
          .post("$baseUrl/${EndPoints.update_account_detail}", data: params);
      return UpdateMenuDetail.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic>? map = _dioError.response!.data;
      if (_dioError.response!.statusCode == 500) {
        throwIfNoSuccess(map!['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future getLiveOffers(FormData params) async {
    try {
      Response response =
          await _dio.post("$baseUrl/${EndPoints.get_live_offer}", data: params);
      return GetLiveOffer.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic>? map = _dioError.response!.data;
      if (_dioError.response!.statusCode == 500) {
        throwIfNoSuccess(map!['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future getPackages(FormData params) async {
    try {
      Response response =
          await _dio.post("$baseUrl/${EndPoints.get_package}", data: params);
      return BeanGetPackages.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic>? map = _dioError.response!.data;
      if (_dioError.response!.statusCode == 500) {
        throwIfNoSuccess(map!['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future addPackage(FormData params) async {
    try {
      Response response =
          await _dio.post("$baseUrl/${EndPoints.add_package}", data: params);
      return BeanAddPackage.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic>? map = _dioError.response!.data;
      if (_dioError.response!.statusCode == 500) {
        throwIfNoSuccess(map!['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future getAccountDetails(FormData params) async {
    try {
      Response response = await _dio
          .post("$baseUrl/${EndPoints.get_account_detail}", data: params);
      return GetAccountDetails.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic>? map = _dioError.response!.data;
      if (_dioError.response!.statusCode == 500) {
        throwIfNoSuccess(map!['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future addOffer(FormData params) async {
    try {
      Response response =
          await _dio.post("$baseUrl/${EndPoints.add_offer}", data: params);
      return AddOffer.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic>? map = _dioError.response!.data;
      if (_dioError.response!.statusCode == 500) {
        throwIfNoSuccess(map!['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future addCustomizePackageItem(FormData params) async {
    try {
      Response response = await _dio.post(
          "$baseUrl/${EndPoints.add_customized_package_item}",
          data: params);
      return BaseBean.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic>? map = _dioError.response!.data;
      if (_dioError.response!.statusCode == 500) {
        throwIfNoSuccess(map!['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  void throwIfNoSuccess(String response) {
    throw new HttpException(response);
  }
}
