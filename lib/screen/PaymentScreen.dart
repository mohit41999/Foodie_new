import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_app/model/BeanGetCard.dart' as card;
import 'package:food_app/model/BeanMakePayment.dart';
import 'package:food_app/model/BeanVerifyOtp.dart';
import 'package:food_app/network/ApiProvider.dart';
import 'package:food_app/res.dart';
import 'package:food_app/screen/MakePaymentScreen.dart';
import 'package:food_app/utils/Constents.dart';
import 'package:food_app/utils/Utils.dart';
import 'package:food_app/utils/progress_dialog.dart';

import 'WebViewContainer.dart';

class PaymentScreen extends StatefulWidget {
  var totalAmount;
  var address;
  var tax_amount;
  var delivery_charge;
  var couponCode;
  var kitchen_id;
  var deliveryLat;
  var deliveryLong;
  var navigation;

  PaymentScreen(
      this.totalAmount,
      this.address,
      this.tax_amount,
      this.delivery_charge,
      String couponCode,
      this.kitchen_id,
      this.deliveryLat,
      this.deliveryLong,
      this.navigation);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int _radioValue = -1;

  var isSelect = -1;
  var id = "";
  late ProgressDialog progressDialog;
  List<card.Data>? data;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      getCard(context);
    });
    super.initState();
  }

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
      switch (_radioValue) {
        case 0:
          setState(() {});
          break;

        case 1:
          setState(() {});
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    // FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 26,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
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
                  ],
                ),
                SizedBox(
                  height: 26,
                ),
                InkWell(
                  onTap: () async {
                    var data = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => MakePaymentScreen(widget.address)));
                    if (data != null) {
                      getCard(context);
                    }
                  },
                  child: Container(
                    child: Card(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(13),
                                    color: Colors.black),
                                width: 100,
                                height: 40,
                                alignment: Alignment.topRight,
                                margin: EdgeInsets.only(right: 16, top: 16),
                                child: Center(
                                  child: Text(
                                    "Add Card",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                            mainAxisAlignment: MainAxisAlignment.end,
                          ),
                          Divider(
                            color: Colors.grey,
                          ),
                          Divider(
                            color: Colors.grey,
                          ),
                          data != null
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return getCardDetail(data![index], index);
                                  },
                                  itemCount: data!.length,
                                )
                              : Container()
                        ],
                      ),
                    ),
                  ),
                ),
                widget.navigation == "navigation"
                    ? Container()
                    : InkWell(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(13)),
                          width: double.infinity,
                          height: 70,
                          margin: EdgeInsets.only(
                              left: 16, right: 16, top: 26, bottom: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                child: Text(
                                  AppConstant.rupee + widget.totalAmount,
                                  style: TextStyle(color: Color(0xff7EDABF)),
                                ),
                                padding: EdgeInsets.only(top: 16, left: 16),
                              ),
                              InkWell(
                                onTap: () {
                                  if (isSelect == -1) {
                                    Utils.showToast("Please select card");
                                  } else {
                                    makePayment();
                                  }
                                },
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        child: Text(
                                          "Service",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        padding:
                                            EdgeInsets.only(top: 6, left: 16),
                                      ),
                                    ),
                                    Padding(
                                      child: Text(
                                        "Make Payment",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      padding: EdgeInsets.only(
                                          top: 6, left: 16, bottom: 10),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(right: 16),
                                        child: Image.asset(
                                          Res.ic_next_arrow,
                                          width: 16,
                                          height: 16,
                                        )),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ));
  }

  Future getCard(BuildContext context) async {
    progressDialog = ProgressDialog(context);
    progressDialog.show();
    try {
      BeanVerifyOtp user = await Utils.getUser();
      FormData from = FormData.fromMap({
        "token": "123456789",
        "userid": user.data!.id,
      });
      card.BeanGetCard? bean =
          await ApiProvider().beanGetCard(from) ;
      print(bean!.data);
      progressDialog.dismiss(context);
      if (bean.status == true) {
        Utils.showToast(bean.message!);
        if (bean.data!.length != null) {
          data = bean.data;
        }
        setState(() {});
      } else {
        Utils.showToast(bean.message!);
      }
    } on HttpException catch (exception) {
      progressDialog.dismiss(context);
      print(exception);
    } catch (exception) {
      progressDialog.dismiss(context);
      print(exception);
    }
  }

  Widget getCardDetail(card.Data data, int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              isSelect = index;
              id = data.id.toString();
            });
          },
          child: Container(
            margin: EdgeInsets.only(left: 16, top: 6, bottom: 6),
            child: isSelect == index
                ? Image.asset(
                    Res.radio,
                    width: 25,
                    height: 25,
                  )
                : Image.asset(
                    Res.circle,
                    width: 25,
                    height: 25,
                  ),
          ),
        ),
        Padding(
          child: Image.network(
            data.image!,
            width: 25,
            height: 25,
          ),
          padding: EdgeInsets.only(top: 1),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16, top: 1),
          child: Text(data.cardName!),
        )
      ],
    );
  }

  makePayment() async {
    progressDialog = ProgressDialog(context);
    progressDialog.show();
    try {
      BeanVerifyOtp user = await Utils.getUser();
      FormData from = FormData.fromMap({
        "token": "123456789",
        "user_id": user.data!.id,
        "kitchen_id": widget.kitchen_id,
        "customer_name": user.data!.kitchenname,
        "customer_mobileno": user.data!.mobilenumber,
        "orderingforname": user.data!.kitchenname,
        "orderingformobileno": user.data!.mobilenumber,
        "deliveryaddress": widget.address,
        "deliverylatitude": widget.deliveryLat,
        "deliverylongitude": widget.deliveryLong,
        "orderamount": widget.totalAmount,
        "netamount": widget.totalAmount,
        "taxamount": widget.tax_amount,
        "deliverycharge": widget.delivery_charge,
        "couponcode": "",
        "couponamount": "",
        "card_id": id,
      });

      BeanMakePayment? bean =
          await ApiProvider().makePayment(from);

      print(id);
      print(widget.totalAmount);
      print(widget.tax_amount);
      print(widget.delivery_charge);
      print(widget.address);
      print(user.data!.mobilenumber);
      print(user.data!.kitchenname);
      print(
        widget.kitchen_id,
      );
      print(
        user.data!.id,
      );

      progressDialog.dismiss(context);
      if (bean!.status == true) {
        Utils.showToast(bean.message!);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WebViewContainer(bean.data!.url)));

        setState(() {});
      } else {
        Utils.showToast(bean.message!);
      }
    } on HttpException catch (exception) {
      progressDialog.dismiss(context);
      print(exception);
    } catch (exception) {
      progressDialog.dismiss(context);
      print(exception);
    }
  }
  //

}
