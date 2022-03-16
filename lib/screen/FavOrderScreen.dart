import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_app/model/BeanAddOrder.dart';
import 'package:food_app/model/BeanVerifyOtp.dart';
import 'package:food_app/network/ApiProvider.dart';
import 'package:food_app/res.dart';
import 'package:food_app/model/GetActiveOrder.dart' as order;
import 'package:food_app/utils/Constents.dart';
import 'package:food_app/utils/HttpException.dart';
import 'package:food_app/utils/Utils.dart';
import 'package:food_app/utils/progress_dialog.dart';

class FavOrderScreen extends StatefulWidget {
  @override
  _FavOrderScreenState createState() => _FavOrderScreenState();
}

class _FavOrderScreenState extends State<FavOrderScreen> {
  Future? _future;
  late ProgressDialog progressDialog;
  var like = false;
  var disLike = true;
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      _future = getActiveOrder(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                SizedBox(
                  width: 16,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    Res.ic_back,
                    width: 20,
                    height: 20,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text(
                    "Fav Orders",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: AppConstant.fontRegular,
                        color: Colors.black),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: FutureBuilder<order.GetActiveOrder?>(
                  future:
                      _future?.then((value) => value as order.GetActiveOrder?),
                  builder: (context, projectSnap) {
                    print(projectSnap);
                    if (projectSnap.connectionState == ConnectionState.done) {
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
                              return getActveOrder(result[index]);
                            },
                            itemCount: result.length,
                          );
                        }
                      }
                    }
                    return Container(
                        child: Center(child: Text("No Address Found")));
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Future<order.GetActiveOrder?> getActiveOrder(BuildContext context) async {
    progressDialog = ProgressDialog(context);
    progressDialog.show();
    try {
      BeanVerifyOtp user = await Utils.getUser();
      FormData from = FormData.fromMap({
        "token": "123456789",
        "user_id": user.data!.id,
      });
      order.GetActiveOrder? bean = await ApiProvider().getActiveOrder(from);
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

  Widget getActveOrder(order.Data result) {
    return GestureDetector(
      onTap: () {},
      child: Container(
          color: Colors.white,
          margin: EdgeInsets.only(top: 20, right: 16, left: 16, bottom: 16),
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
                            result.kitchenname!,
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
                            result.orderfrom!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                fontFamily: AppConstant.fontBold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16, top: 10),
                          child: Text(
                            "Customized",
                            style: TextStyle(
                                color: AppConstant.appColor, fontSize: 12),
                          ),
                        ),
                        Divider(
                          color: Color(0xffA7A8BC),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  "Today Lunch Menu",
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
              ),
              Row(
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: 16, top: 6),
                      child: Image.asset(
                        Res.ic_breakfast,
                        width: 20,
                        height: 20,
                      )),
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, top: 6),
                      child: Text(
                        result.orderItems!,
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: 16, top: 6),
                      child: Image.asset(
                        Res.ic_location,
                        width: 20,
                        height: 20,
                      )),
                  Padding(
                    padding: EdgeInsets.only(left: 10, top: 6),
                    child: Text(
                      result.address!,
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      width: 0,
                    ),
                  ),
                  Visibility(
                    visible: disLike,
                    child: InkWell(
                      onTap: () {
                        addFavOrder(result.orderid!);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: 16),
                        child: Image.asset(
                          Res.ic_deslike,
                          width: 80,
                          height: 80,
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: like,
                    child: InkWell(
                      onTap: () {
                        removeFavOrder(result.orderid);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: 16),
                        child: Image.asset(
                          Res.ic_like,
                          width: 80,
                          height: 80,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Divider(
                color: Color(0xffA7A8BC),
              ),
            ],
          )),
    );
  }

  addFavOrder(String orderid) async {
    progressDialog = ProgressDialog(context);
    progressDialog.show();
    try {
      BeanVerifyOtp user = await Utils.getUser();
      FormData from = FormData.fromMap({
        "token": "123456789",
        "userid": user.data!.id,
        "orderid": orderid,
      });
      print("ordeidd" + orderid);
      print("hgh" + user.data!.id!);
      BeanAddOrder? bean =
          await ApiProvider().addFavOrder(from);
      progressDialog.dismiss(context);
      print(bean!.data);

      if (bean.status == true) {
        setState(() {
          like = true;
          disLike = false;
        });
        return bean;
      } else {
        Utils.showToast(bean.message.toString());
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

  removeFavOrder(String? orderid) async {
    progressDialog = ProgressDialog(context);
    progressDialog.show();
    try {
      BeanVerifyOtp user = await Utils.getUser();
      FormData from = FormData.fromMap({
        "token": "123456789",
        "userid": user.data!.id,
        "orderid": orderid,
      });
      BeanAddOrder? bean =
          await ApiProvider().removeFavOrder(from) ;
      print(bean!.data);
      progressDialog.dismiss(context);
      if (bean.status == true) {
        Utils.showToast("Remove Favourite Order");

        setState(() {
          disLike = true;
          like = false;
        });

        return bean;
      } else {
        Utils.showToast(bean.message.toString());
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

/*

  Widget getLunch() {
    return  Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 10, right: 16),
                  child: Image.asset(
                    Res.ic_veg,
                    width: 30,
                    height: 30,
                  )),
              Expanded(
                child: Padding(
                    padding: EdgeInsets.only(left: 6,top: 10),
                    child: Text(
                      "Package 1",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: AppConstant.fontBold,
                          fontSize: 16),
                    )),
              ),
              Text(
                "₹3,000",
                style: TextStyle(color: Color(0xff7EDABF)),
              ),

            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 10,top: 6),
            child: Text(
              "South indian",
              style: TextStyle(color: Color(0xffA7A8BC),fontSize: 13,fontFamily: AppConstant.fontRegular),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10,top: 5),
            child: Text(
              "Including Saturday, Sunday",
              style: TextStyle(color: Color(0xffA7A8BC),fontSize: 13,fontFamily: AppConstant.fontRegular),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: RatingBarIndicator(
              rating: 4,
              itemCount: 5,
              itemSize: 16.0,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
            ),
          ),
        ],
      ),
    );
  }
*/

}
