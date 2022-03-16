import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_app/model/BeanVerifyOtp.dart';
import 'package:food_app/model/GetOrderHistory.dart' as history;
import 'package:food_app/model/GetOrderHistoryDetail.dart';
import 'package:food_app/model/GetOrderHistoryDetail.dart';
import 'package:food_app/model/GetOrderHistoryDetail.dart';
import 'package:food_app/network/ApiProvider.dart';
import 'package:food_app/res.dart';
import 'package:food_app/screen/HomeBaseScreen.dart';
import 'package:food_app/screen/LoginSignUpScreen.dart';
import 'package:food_app/utils/Constents.dart';
import 'package:food_app/utils/HttpException.dart';
import 'package:food_app/utils/PrefManager.dart';
import 'package:food_app/utils/Utils.dart';
import 'package:food_app/utils/progress_dialog.dart';
import 'package:food_app/model/GetOrderHistoryDetail.dart' as GetOrderHistory;

class OrderScreen extends StatefulWidget {
  @override
  OrderScreenState createState() => OrderScreenState();
}

class OrderScreenState extends State<OrderScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey =  GlobalKey<ScaffoldState>();
  var isSelected = 0;
  Future? future;
  Future? _future;
  late ProgressDialog progressDialog;

  @override
  initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      apiCall();
    });
    // if(isLogined){
    //
    // }else{
    //   Navigator.pushAndRemoveUntil(
    //       context,
    //       MaterialPageRoute(
    //           builder: (context) => LoginSignUpScreen()
    //       ),
    //       ModalRoute.withName("/loginSignUp")
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context);
    // FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    // FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
        drawer: MyDrawers(),
        backgroundColor: AppConstant.appColor,
        key: _scaffoldKey,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 16),
              child: Row(
                children: [
                  SizedBox(
                    width: 16,
                  ),
                  InkWell(
                      onTap: () {
                        setState(() {
                          _scaffoldKey.currentState!.openDrawer();
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Image.asset(
                          Res.ic_menu,
                          width: 30,
                          height: 30,
                          color: Colors.white,
                        ),
                      )),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                      child: Text(
                        "Orders History",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: AppConstant.fontBold),
                      ),
                    ),
                  ),
                ],
              ),
              height: 70,
            ),
            Expanded(
              child: Container(
                  margin: EdgeInsets.only(top: 16, left: 16, right: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: FutureBuilder<history.GetOrderHistory?>(
                              future: future?.then(
                                  (value) => value as history.GetOrderHistory?),
                              builder: (context, projectSnap) {
                                print(projectSnap);
                                if (projectSnap.connectionState ==
                                    ConnectionState.done) {
                                  var result;
                                  if (projectSnap.data != null) {
                                    result = projectSnap.data!.data;
                                    if (result != null) {
                                      print(result.length);
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        physics: BouncingScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return getItem(result[index], index);
                                        },
                                        itemCount: result.length,
                                      );
                                    }
                                  }
                                }
                                return Container(
                                    child: Center(
                                        child: Text("No History Available")));
                              })),
                    ],
                  )),
            ),
          ],
        ));
  }

  Widget getItem(history.Data result, int index) {
    return InkWell(
        onTap: () {
          getOrderHistoryDetail(result.orderId);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                      padding: EdgeInsets.only(left: 16, top: 16),
                      child: Text(
                        result.kitchenname.toString(),
                        style: TextStyle(
                            fontFamily: AppConstant.fontBold,
                            color: Colors.black),
                      )),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.only(right: 16, top: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Color(0xff7EDABF)),
                    width: 60,
                    height: 30,
                    child: Center(
                      child: Text(
                        result.status.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
                padding: EdgeInsets.only(left: 16, top: 16),
                child: Text(
                  result.orderfrom.toString(),
                  style: TextStyle(
                      fontFamily: AppConstant.fontRegular,
                      color: Color(0xffA7A8BC)),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 10),
                  child: Text(
                    result.orderOf.toString(),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: AppConstant.fontBold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: RatingBarIndicator(
                    rating: 4,
                    itemCount: 5,
                    itemSize: 15.0,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 10, bottom: 16),
                  child: Text(
                    "Total Bill: ₹" + result.totalbill.toString(),
                    style: TextStyle(
                        color: Color(0xff7EDABF),
                        fontSize: 15,
                        fontFamily: AppConstant.fontBold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 16, top: 10, bottom: 16),
                  child: Text(
                    "Repeat Order",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontFamily: AppConstant.fontRegular),
                  ),
                ),
              ],
            )
          ],
        ));
  }

  void bottomsheet(BuildContext context, List<GetOrderHistory.Data>? data) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          // <-- for border radius
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
        ),
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setModelState) {
            return Wrap(
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "History of order no",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: AppConstant.fontBold,
                                  fontSize: 18),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(right: 16),
                              child: Image.asset(
                                Res.ic_cross,
                                width: 16,
                                height: 16,
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      data!.isEmpty
                          ? Center(
                              child: Text("No History Detail"),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return getHistory(data[index]);
                              },
                              itemCount: data.length,
                            )
                      /*FutureBuilder<GetOrderHistory>(
                          future: future,
                          builder: (context, projectSnap) {
                            print(projectSnap);
                            if (projectSnap.connectionState ==
                                ConnectionState.done) {
                              var result;
                              if (projectSnap.data != null) {
                                result = projectSnap.data.data;
                                if (result != null) {
                                  print(result.length);
                                  return
                                }
                              }
                            }
                            return Container(
                                child: Center(
                                    child: Text("No History Available")
                                ));
                          })*/
                    ],
                  ),
                ),
              ],
            );
          });
        });
  }

  getHistory(GetOrderHistory.Data data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: data.image!.isEmpty
                  ? Image.asset(
                      Res.ic_poha,
                      width: 50,
                      height: 50,
                    )
                  : Image.network(
                      AppConstant.menuUrl + data.image!,
                      width: 50,
                      height: 50,
                    ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 16, top: 16),
                    child: Text(
                      data.itemName.toString(),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: AppConstant.fontBold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, top: 16),
                    child: Text(
                      data.date.toString(),
                      style: TextStyle(
                          color: Color(0xffA7A8BC),
                          fontSize: 16,
                          fontFamily: AppConstant.fontRegular),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, top: 16, right: 16),
              child: Text(
                data.status.toString(),
                style: TextStyle(
                    color: AppConstant.lightGreen,
                    fontSize: 14,
                    fontFamily: AppConstant.fontRegular),
              ),
            )
          ],
        )
      ],
    );
  }

  Future<history.GetOrderHistory?> getOrderHistory() async {
    progressDialog = ProgressDialog(context);
    progressDialog.show();
    try {
      BeanVerifyOtp user = await Utils.getUser();
      FormData from = FormData.fromMap({
        "token": "123456789",
        "user_id": user.data!.id,
      });
      print(from.fields );
      history.GetOrderHistory? bean = await ApiProvider().getOrderHistory(from);
      print(bean!.data);
      progressDialog.dismiss(context);
      if (bean.status == true) {
        setState(() {});
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

  Future<GetOrderHistoryDetail?> getOrderHistoryDetail(String? orderId) async {
    progressDialog = ProgressDialog(context);
    progressDialog.show();
    try {
      BeanVerifyOtp user = await Utils.getUser();
      FormData from = FormData.fromMap({
        "token": "123456789",
        "user_id": user.data!.id,
        "order_id": orderId,
      });
      print("param" + from.toString());
      GetOrderHistoryDetail? bean =
          await ApiProvider().getOrderHistoryDetail(from)
             ;
      print(bean!.data);
      progressDialog.dismiss(context);
      if (bean.status == true) {
        setState(() {
          bottomsheet(context, bean.data);
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

  Future<void> apiCall() async {
    bool isLogined = await PrefManager.getBool(AppConstant.session);
    if (isLogined) {
      future = getOrderHistory();
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginSignUpScreen()),
          ModalRoute.withName("/loginSignUp"));
    }
  }
}
