import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_app/model/BeanKitchenDetail.dart';
import 'package:food_app/model/BeanVerifyOtp.dart';
import 'package:food_app/model/GetDashBoard.dart';
import 'package:food_app/model/GetProfile.dart';
import 'package:food_app/network/ApiProvider.dart';
import 'package:food_app/res.dart';
import 'package:food_app/screen/StartDeliveryScreen.dart';
import 'package:food_app/utils/Constents.dart';
import 'package:food_app/utils/HttpException.dart';
import 'package:food_app/utils/PrefManager.dart';
import 'package:food_app/utils/Utils.dart';
import 'package:food_app/utils/progress_dialog.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class OrderDispatchedScreen extends StatefulWidget {
  var lattitude;
  var longtitude;
  var formattedAddress;

  OrderDispatchedScreen(this.lattitude, this.longtitude, this.formattedAddress);

  @override
  OrderDispatchedScreenState createState() => OrderDispatchedScreenState();
}

class OrderDispatchedScreenState extends State<OrderDispatchedScreen> {
  late ProgressDialog progressDialog;
  String? username = "";
  String? email = "";
  String? kitchenName = "";
  String? foodtype = "";
  String? orderId = "";
  String? address = "";
  String? timing = "";
  String? open_status = "";
  String? total_review = "";
  var avg_review = "";
  var arrivngTime;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      getProfile(context);
      kithchenDetail(context);
      getOrderDashboard(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context);
    // FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    // FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
        backgroundColor: AppConstant.appColor,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 30, right: 16),
                alignment: Alignment.topRight,
                child: Image.asset(
                  Res.ic_close,
                  width: 18,
                  height: 18,
                  color: Colors.white,
                ),
              ),
              Center(
                child: CircularPercentIndicator(
                  radius: 180.0,
                  animation: true,
                  animationDuration: 1200,
                  lineWidth: 8.0,
                  percent: 0.8,
                  center: Container(
                      width: 155,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14)),
                      height: 155,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Stack(
                            children: [
                              Container(
                                  height: 150,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(100)),
                                  child: Stack(
                                    children: [
                                      Image.asset(
                                        Res.delivery_boy,
                                        width: 150,
                                        height: 150,
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: 50, top: 16),
                                        child: Text(
                                          arrivngTime != null
                                              ? arrivngTime
                                              : "",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  )),
                            ],
                          ))),
                  circularStrokeCap: CircularStrokeCap.butt,
                  backgroundColor: Color(0xffFCC647),
                  progressColor: Color(0xff7EDABF),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Order Dispatched",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: AppConstant.fontBold),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Image.asset(
                      Res.ic_down_arrow,
                      width: 25,
                      height: 25,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Center(
                  child: Text(
                "Expecting a slight delay in finding valet due to high\norder volumes",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontFamily: AppConstant.fontBold),
              )),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StartDeliveryScreen(orderId)));
                },
                child: Container(
                    color: Colors.white,
                    margin: EdgeInsets.only(top: 20, right: 16, left: 16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 6,
                            ),
                            Image.asset(
                              Res.ic_boy,
                              width: 50,
                              height: 50,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 16, top: 6),
                                    child: Text(
                                      username!,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily: AppConstant.fontBold),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 16, top: 4),
                                    child: Text(
                                      email!,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                          fontFamily: AppConstant.fontBold),
                                    ),
                                  ),
                                  Divider(
                                    color: Color(0xffA7A8BC),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 16),
                              child: Image.asset(
                                Res.ic_call,
                                width: 40,
                                height: 40,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Text(
                            "John can speak hindi & english He is from nagpur",
                            style: TextStyle(
                                color: Color(0xffA7A8BC), fontSize: 12),
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                                padding: EdgeInsets.only(left: 16),
                                child: Image.asset(
                                  Res.ic_check,
                                  width: 20,
                                  height: 20,
                                )),
                            Padding(
                              padding: EdgeInsets.only(left: 10, top: 6),
                              child: Text(
                                "Thank you for the tip john!",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 10, bottom: 16, top: 6),
                          child: Text(
                            AppConstant.rupee +
                                "20 will be transferred to him at end of the week",
                            style: TextStyle(
                                color: Color(0xffA7A8BC), fontSize: 12),
                          ),
                        ),
                      ],
                    )),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/homebase');
                },
                child: Container(
                    color: Colors.white,
                    margin: EdgeInsets.only(top: 20, right: 16, left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 6,
                            ),
                            Image.asset(
                              Res.kitchen,
                              width: 50,
                              height: 50,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 16, top: 6),
                                    child: Text(
                                      kitchenName!,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily: AppConstant.fontBold),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 16, top: 4),
                                    child: Text(
                                      timing!,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                          fontFamily: AppConstant.fontBold),
                                    ),
                                  ),
                                  Divider(
                                    color: Color(0xffA7A8BC),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 16),
                              child: Image.asset(
                                Res.ic_call,
                                width: 40,
                                height: 40,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 16),
                              child: Text(
                                "Today's Launch Menu",
                                style: TextStyle(
                                    color: Color(0xffA7A8BC), fontSize: 12),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 16),
                              child: Text(
                                "Customized",
                                style: TextStyle(
                                    color: AppConstant.appColor,
                                    fontSize: 12,
                                    fontFamily: AppConstant.fontBold),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                                padding: EdgeInsets.only(left: 16),
                                child: Image.asset(
                                  Res.ic_breakfast,
                                  width: 20,
                                  height: 20,
                                )),
                            Padding(
                              padding: EdgeInsets.only(left: 10, top: 6),
                              child: Text(
                                foodtype!,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: Color(0xffA7A8BC),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16, top: 10),
                          child: Text(
                            username!,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontFamily: AppConstant.fontBold),
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 16, bottom: 16, top: 10),
                                child: Image.asset(
                                  Res.ic_location,
                                  width: 20,
                                  height: 20,
                                )),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 10, top: 10, bottom: 16),
                              child: Text(
                                address!,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
              Container(
                  color: Colors.white,
                  margin: EdgeInsets.only(top: 20, right: 16, left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 10, top: 10, bottom: 16),
                                child: Text(
                                  "Have an issue with your order",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontFamily: AppConstant.fontBold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 10, top: 10, bottom: 6),
                                child: Text(
                                  "Chat with us",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontFamily: AppConstant.fontBold),
                                ),
                              ),
                            ],
                          )),
                          Padding(
                              padding: EdgeInsets.only(
                                  right: 16, bottom: 16, top: 10),
                              child: Image.asset(
                                Res.ic_order_issue,
                                width: 40,
                                height: 40,
                              )),
                        ],
                      ),
                    ],
                  )),
              Container(
                  width: double.infinity,
                  color: Colors.white,
                  margin:
                      EdgeInsets.only(top: 20, right: 16, left: 16, bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10, top: 10, bottom: 16),
                        child: Text(
                          "Enjoy the NoHung app?",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontFamily: AppConstant.fontBold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, top: 5, bottom: 6),
                        child: Text(
                          "Spread the word by rating us on play store.",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontFamily: AppConstant.fontRegular),
                        ),
                      ),
                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 40,
                              width: 100,
                              margin: EdgeInsets.only(
                                  left: 10, right: 10, bottom: 10, top: 10),
                              decoration: BoxDecoration(
                                  color: Color(0xffF3F6FA),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Center(
                                child: Text(
                                  "Not Now",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 13),
                                ),
                              ),
                            ),
                            Container(
                              height: 40,
                              width: 100,
                              margin: EdgeInsets.only(
                                  left: 10, right: 10, bottom: 10, top: 10),
                              decoration: BoxDecoration(
                                  color: AppConstant.appColor,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Center(
                                child: Text(
                                  "Rating NoHung",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )),
            ],
          ),
        ));
  }

  Future<GetProfile?> getProfile(BuildContext context) async {
    progressDialog = ProgressDialog(context);
    progressDialog.show();
    try {
      var user = await Utils.getUser();
      FormData from =
          FormData.fromMap({"user_id": user.data!.id, "token": "123456789"});
      GetProfile? bean = await ApiProvider().getProfile(from);
      print(bean!.data);
      progressDialog.dismiss(context);
      if (bean.status == true) {
        setState(() {
          username = bean.data![0].username;
          email = bean.data![0].email;
        });
        return bean;
      } else {
        Utils.showToast(bean.message!);
      }

      return null;
    } on HttpException catch (exception) {
      progressDialog.dismiss(context);
      print(exception);
    } catch (exception) {
      progressDialog.dismiss(context);
      print(exception);
    }
  }

  Future<KitchenDetail?> kithchenDetail(BuildContext context) async {
    progressDialog = ProgressDialog(context);
    progressDialog.show();
    try {
      BeanVerifyOtp user = await Utils.getUser();
      FormData from = FormData.fromMap({
        "kitchenid": user.data!.kitchenid,
        "token": "123456789",
        "meal_plan": "weekly",
        "meal_type": user.data!.mealtype,
        "meal_for": "1"
      });
      KitchenDetail? bean = await ApiProvider().kitchenDetail(from);
      print(bean!.data);
      progressDialog.dismiss(context);
      if (bean.status == true) {
        setState(() {
          kitchenName = bean.data[0].kitchenname;
          foodtype = bean.data[0].foodtype;
          address = bean.data[0].address;
          timing = bean.data[0].timing;
          open_status = bean.data[0].openStatus;
          total_review = bean.data[0].totalReview;
          avg_review = bean.data[0].avgReview.toString();
        });
        return bean;
      } else {
        Utils.showToast(bean.message);
      }

      return null;
    } on HttpException catch (exception) {
      progressDialog.dismiss(context);
      print(exception);
    } catch (exception) {
      progressDialog.dismiss(context);
      print(exception);
    }
  }

  getOrderDashboard(BuildContext context) async {
    progressDialog = ProgressDialog(context);
    progressDialog.show();
    try {
      BeanVerifyOtp user = await Utils.getUser();
      FormData from = FormData.fromMap({
        "userid": user.data!.id,
        "token": "123456789",
      });
      GetDashBoard? bean = await ApiProvider().getDashboard(from);
      print(bean!.data);
      progressDialog.dismiss(context);
      if (bean.status == true) {
        setState(() {
          orderId = bean.data![0].id;
          arrivngTime = bean.data![0].arriving.toString();
        });
        return bean;
      } else {
        Utils.showToast(bean.message!);
      }

      return null;
    } on HttpException catch (exception) {
      progressDialog.dismiss(context);
      print(exception);
    } catch (exception) {
      progressDialog.dismiss(context);
      print(exception);
    }
  }
}
