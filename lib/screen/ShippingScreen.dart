import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_app/model/BeanApplyPromo.dart';
import 'package:food_app/model/BeanUpdateCart.dart';
import 'package:food_app/model/BeanVerifyOtp.dart';
import 'package:food_app/model/GetCartDetail.dart' as cart;
import 'package:food_app/model/RemoveCart.dart';
import 'package:food_app/network/ApiProvider.dart';
import 'package:food_app/res.dart';
import 'package:food_app/screen/PaymentScreen.dart';
import 'package:food_app/utils/Constents.dart';
import 'package:food_app/utils/HttpException.dart';
import 'package:food_app/utils/Utils.dart';
import 'package:food_app/utils/progress_dialog.dart';

class ShippingScreen extends StatefulWidget {
  var address;
  var kitchenId;

  ShippingScreen(this.address, this.kitchenId);

  @override
  _ShippingScreenState createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var isSelected = 0;

  Future? future;
  var distancekm = "";
  String? total_amount = "";
  String? kitchen_id = "";
  var applyPromoController = TextEditingController();
  String? tax_amount = "";
  late ProgressDialog progressDialog;
  String? delivery_charge = "";
  var type = "";
  String? deliveryLat = "";
  String? deliveryLong = "";
  String? deliveryAddress = "";

  bool showDiscount = false;
  var discount = "";
  List<cart.CartItems>? data;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      future = getCartDetail();
    });
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context);
    // FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    // FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 26,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context, true);
                      },
                      child: Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Image.asset(
                            Res.ic_back,
                            width: 16,
                            height: 16,
                          )),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Text(
                              "Your Location",
                              style: TextStyle(color: Color(0xffA7A8BC)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Text(
                              widget.address,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: AppConstant.fontBold,
                                  fontSize: 14),
                            ),
                          )
                        ],
                      ),
                    ),
                    /*  Padding(
                      padding: EdgeInsets.only(right: 6),
                      child: Text(
                        "Change",
                        style: TextStyle(color: AppConstant.appColor),
                      ),
                    ),*/
                    Column(
                      children: [],
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: applyPromoController,
                          decoration: InputDecoration(hintText: 'Apply Offer'),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (applyPromoController.text.toString().isEmpty) {
                            Utils.showToast("Please enter promo");
                          } else {
                            applyPromo();
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppConstant.appColor,
                              borderRadius: BorderRadius.circular(13)),
                          height: 40,
                          width: 80,
                          child: Center(
                            child: Text(
                              "Apply",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 16),
                  child: Text(
                    "Services",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontFamily: AppConstant.fontBold),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FutureBuilder<cart.GetCartDetail?>(
                            future: future
                                ?.then((value) => value as cart.GetCartDetail?),
                            builder: (context, projectSnap) {
                              print(projectSnap);
                              if (projectSnap.connectionState ==
                                  ConnectionState.done) {
                                var result;
                                if (projectSnap.data != null) {
                                  result = projectSnap.data!.data!.cartItems;
                                  if (result != null) {
                                    print(result.length);
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      physics: BouncingScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return getServices(result[index]);
                                      },
                                      itemCount: result.length,
                                    );
                                  }
                                }
                              }
                              return Container(
                                  child: Center(child: Text("No Item Found")));
                            }),
                        SizedBox(
                          height: 16,
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                        /*   Row(
                        children: [
                          SizedBox(
                            width: 16,
                          ),
                          Image.asset(
                            Res.ic_veg,
                            width: 16,
                            height: 16,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 16),
                              child: Text(
                                "Package 1",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: AppConstant.fontBold,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Text(
                              "₹3,000",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: AppConstant.fontBold,
                                  fontSize: 16),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Text(
                          "South indian",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: AppConstant.fontRegular,
                              fontSize: 13),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Text(
                          "including ,saturday,sunday",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: AppConstant.fontRegular,
                              fontSize: 13),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Text(
                          "11 Apr to  March 2021",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: AppConstant.fontRegular,
                              fontSize: 13),
                        ),
                      ),*/
                        SizedBox(
                          height: 16,
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                        data != null
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Text(
                                            "Taxes",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily:
                                                    AppConstant.fontRegular,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 16),
                                        child: Text(
                                          "₹" + tax_amount!,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily:
                                                  AppConstant.fontRegular,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Text(
                                            "Delivery Charge",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily:
                                                    AppConstant.fontRegular,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 16),
                                        child: Text(
                                          "₹" + delivery_charge!,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily:
                                                  AppConstant.fontRegular,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Text(
                                            "Coupon",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily:
                                                    AppConstant.fontRegular,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 16),
                                        child: Text(
                                          "₹0",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily:
                                                  AppConstant.fontRegular,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Visibility(
                                    visible: showDiscount,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Text(
                                              "Discount",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily:
                                                      AppConstant.fontRegular,
                                                  fontSize: 16),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 16),
                                          child: Text(
                                            AppConstant.rupee + discount,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily:
                                                    AppConstant.fontRegular,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Text(
                                            "Subtotal",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily:
                                                    AppConstant.fontBold,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 16),
                                        child: Text(
                                          "₹" + total_amount!,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: AppConstant.fontBold,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Divider(
                                    color: Colors.grey,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Text(
                                            "Ordering for",
                                            style: TextStyle(
                                                color: Color(0xffA7A8BC),
                                                fontFamily:
                                                    AppConstant.fontBold,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ),
                                      /*    Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Text(
                              "Change",
                              style: TextStyle(
                                  color: AppConstant.appColor,
                                  fontFamily: AppConstant.fontRegular,
                                  fontSize: 16),
                            ),
                          ),*/
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text(
                                      "Prepared joshi, +91997777979",
                                      style: TextStyle(
                                          color: Color(0xffA7A8BC),
                                          fontFamily: AppConstant.fontBold,
                                          fontSize: 16),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (data != null) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PaymentScreen(
                                                        total_amount,
                                                        deliveryAddress,
                                                        tax_amount,
                                                        delivery_charge,
                                                        applyPromoController
                                                            .text
                                                            .toString(),
                                                        kitchen_id,
                                                        deliveryLat,
                                                        deliveryLong,
                                                        "shipping")));
                                      } else {
                                        Utils.showToast(
                                            "Please add item in cart");
                                      }
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: 16, right: 16, top: 16),
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(13)),
                                      child: Center(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "ADD PAYMENT DETAILS",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            SizedBox(
                                              width: 16,
                                            ),
                                            Image.asset(
                                              Res.ic_next_arrow,
                                              width: 17,
                                              height: 17,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : Container()
                      ],
                    ))
              ],
            ),
          ),
        ));
  }

  Future<cart.GetCartDetail?> getCartDetail() async {
    try {
      BeanVerifyOtp user = await Utils.getUser();
      FormData from = FormData.fromMap({
        "token": "123456789",
        "user_id": user.data!.id,
      });
      print(
        "param" + user.data!.id!,
      );
      cart.GetCartDetail? bean = await ApiProvider().getCartDetail(from);
      print(bean!.data);
      if (bean.status == true) {
        total_amount = bean.data!.totalAmount;
        tax_amount = bean.data!.taxAmount;
        delivery_charge = bean.data!.deliveryCharge;
        data = bean.data!.cartItems;
        kitchen_id = data![0].kitchenId;
        deliveryLat = bean.data!.myLocation!.latitude;
        deliveryLong = bean.data!.myLocation!.longitude;
        deliveryAddress = bean.data!.myLocation!.address;

        setState(() {});
        return bean;
      } else {
        Utils.showToast(bean.message!);
      }

      return null;
    } on HttpException catch (exception) {
      print(exception);
    } catch (exception) {
      print(exception);
    }
  }

  Widget getServices(cart.CartItems result) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: result.menuimage!.isEmpty
                  ? Image.asset(
                      Res.ic_poha,
                      width: 60,
                      height: 60,
                    )
                  : Image.network(
                      result.menuimage!,
                      width: 60,
                      height: 60,
                    )),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 4),
                  child: Text(
                    result.itemName!,
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: AppConstant.fontBold,
                        fontSize: 16),
                  )),
              Text(
                result.cuisinetype!,
                style: TextStyle(color: Color(0xffA7A8BC)),
              ),
              Text(
                "₹" + result.price!,
                style: TextStyle(color: Color(0xff7EDABF)),
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      result.deliveryDate! +
                          "/" +
                          result.deliveryFromtime! +
                          "/" +
                          result.deliveryTotime!,
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: Text(
                      "₹" + result.price!,
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ],
          )),
          Container(
              margin: EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                  color: AppConstant.appColor,
                  borderRadius: BorderRadius.circular(100)),
              height: 30,
              width: 70,
              child: Row(
                children: [
                  SizedBox(
                    width: 16,
                  ),
                  InkWell(
                    onTap: () {
                      if (result.count >= 0) {
                        setState(() {
                          result.count--;

                          type = "minus";
                        });

                        if (result.count == 0) {
                          removeItem(result.cartId);
                        } else {
                          updateCart(result.count, result.cartId!);
                        }
                      }
                    },
                    child: Text(
                      "-",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    result.count.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      if (result.count >= 0) {
                        setState(() {
                          result.count++;
                          type = "plus";
                        });
                      }
                      updateCart(result.count, result.cartId!);
                    },
                    child: Text(
                      "+",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  Future<BeanApplyPromo?> applyPromo() async {
    progressDialog = ProgressDialog(context);
    progressDialog.show();
    try {
      BeanVerifyOtp user = await Utils.getUser();
      FormData from = FormData.fromMap({
        "kitchen_id": widget.kitchenId,
        "token": "123456789",
        "order_amount": total_amount,
        "coupon_code": applyPromoController.text.toString()
      });

      BeanApplyPromo? bean =
          await ApiProvider().applyPromo(from) ;
      print(bean!.data);
      progressDialog.dismiss(context);
      if (bean.status == true) {
        discount = bean.data!.discount.toString();

        setState(() {
          showDiscount = true;
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

  updateCart(int count, String cartId) async {
    try {
      BeanVerifyOtp user = await Utils.getUser();
      FormData from = FormData.fromMap({
        "user_id": user.data!.id,
        "token": "123456789",
        "cart_id": cartId,
        "quantity": count,
        "quantity_type": type == "minus"
            ? "2"
            : type == "plus"
                ? "1"
                : "0",
      });
      print(from);
      print("quantitytype" + type);
      print("carttt" + cartId);
      print(
        "quantity" + count.toString(),
      );
      print(type);
      BeanUpdateCart? bean =
          await ApiProvider().updateCart(from) ;
      print(bean!.data);
      if (bean.status == true) {
        setState(() {
          getCartDetail();
        });
        return bean;
      } else {
        Utils.showToast(bean.message!);
      }

      return null;
    } on HttpException catch (exception) {
      print(exception);
    } catch (exception) {
      print(exception);
    }
  }

  removeItem(String? cartId) async {
    var progressDialog = ProgressDialog(context);
    try {
      progressDialog.show();
      BeanVerifyOtp user = await Utils.getUser();
      FormData from = FormData.fromMap({
        "user_id": user.data!.id,
        "token": "123456789",
        "cart_id": cartId,
      });
      print(from);
      print(type);
      RemoveCart? bean =
          await ApiProvider().removeCart(from) ;
      progressDialog.dismiss(context);
      print(bean!.data);
      if (bean.status == true) {
        progressDialog.dismiss(context);
        Navigator.pop(context, true);
        setState(() {});

        return bean;
      } else {
        Utils.showToast(bean.message!);
      }

      return null;
    } on HttpException catch (exception) {
      print(exception);
      progressDialog.dismiss(context);
    } catch (exception) {
      progressDialog.dismiss(context);
      print(exception);
    }
  }
}
