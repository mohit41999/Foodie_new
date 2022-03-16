import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_app/model/BeanAddCard.dart';
import 'package:food_app/model/BeanGetCard.dart' as card;
import 'package:food_app/model/BeanVerifyOtp.dart';
import 'package:food_app/network/ApiProvider.dart';
import 'package:food_app/res.dart';
import 'package:food_app/utils/Constents.dart';
import 'package:food_app/utils/HttpException.dart';
import 'package:food_app/utils/PrefManager.dart';
import 'package:food_app/utils/Utils.dart';
import 'package:food_app/utils/progress_dialog.dart';

class MakePaymentScreen extends StatefulWidget {
  var address;
  MakePaymentScreen(this.address);

  @override
  _MakePaymentScreenState createState() => _MakePaymentScreenState();
}

class _MakePaymentScreenState extends State<MakePaymentScreen> {
  int _radioValue = -1;
  bool? isChecked = false;
  late ProgressDialog progressDialog;
  var number = TextEditingController();
  var cardholdername = TextEditingController();
  var cardName = TextEditingController();
  var valid = TextEditingController();
  var cvv = TextEditingController();
  List<card.Data>? data;
  Future? future;
  var name = "";
  String? holderName = "";
  String? numbercard = "";
  String? expirydate = "";
  var through = "";

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      future = getCard(context);
    });
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
    progressDialog = ProgressDialog(context);
    // FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    // FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
        backgroundColor: Colors.white,
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
                Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(13)),
                    margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                    width: double.infinity,
                    height: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          child: Text(
                            "Car Number",
                            style:
                                TextStyle(color: Colors.yellow, fontSize: 14),
                          ),
                          padding:
                              EdgeInsets.only(left: 16, right: 16, top: 16),
                        ),
                        Padding(
                          child: Text(
                            numbercard!,
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          padding:
                              EdgeInsets.only(left: 16, right: 16, top: 16),
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  child: Text(
                                    "Holder Name",
                                    style: TextStyle(
                                        color: Colors.yellow, fontSize: 14),
                                  ),
                                  padding: EdgeInsets.only(
                                      left: 16, right: 16, top: 16),
                                ),
                                Padding(
                                  child: Text(
                                    holderName!,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                  padding: EdgeInsets.only(
                                      left: 16, right: 16, top: 16),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  child: Text(
                                    "Expiry Date",
                                    style: TextStyle(
                                        color: Colors.yellow, fontSize: 14),
                                  ),
                                  padding: EdgeInsets.only(
                                      left: 16, right: 16, top: 16),
                                ),
                                Padding(
                                  child: Text(
                                    expirydate!,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                  padding: EdgeInsets.only(
                                      left: 16, right: 16, top: 16),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 16),
                  child: Text(
                    "Type your card details",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: AppConstant.fontBold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: number,
                    decoration: InputDecoration(hintText: 'Card Number'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                  child: TextField(
                    controller: cardholdername,
                    decoration: InputDecoration(hintText: 'Card holder name'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                  child: TextField(
                    controller: cardName,
                    decoration: InputDecoration(hintText: 'Card name'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                  child: TextField(
                    controller: valid,
                    decoration: InputDecoration(hintText: 'Valid thru'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                  child: TextField(
                    controller: cvv,
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    decoration: InputDecoration(hintText: 'cvv'),
                  ),
                ),
                Row(
                  children: [
                    Checkbox(
                      activeColor: Color(0xff7EDABF),
                      onChanged: (value) {
                        setState(() {
                          isChecked = value;
                        });
                      },
                      value: isChecked == null ? false : isChecked,
                    ),
                    Text(
                      "Mark card as a default for all payments",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: AppConstant.fontRegular,
                          fontSize: 14),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    validation();

                    /*     showDetailsVerifyDialog();*/
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 16, right: 16, top: 26),
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(13)),
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "CHECKOUT",
                            style: TextStyle(color: Colors.white),
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
            ),
          ),
        ));
  }

  void showDetailsVerifyDialog() {
    showDialog(
        context: context,
        builder: (_) => Center(
                // Aligns the container to center
                child: GestureDetector(
              onTap: () {},
              child: Wrap(
                children: [
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ), // A simplified version of dialog.
                      width: 270.0,
                      height: 260.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Padding(
                                  child: Image.asset(
                                    Res.ic_cross,
                                    width: 20,
                                    height: 20,
                                    fit: BoxFit.cover,
                                  ),
                                  padding: EdgeInsets.only(right: 16),
                                ),
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Image.asset(
                              Res.ic_success,
                              width: 150,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                                padding: EdgeInsets.only(
                                    left: 16, top: 10, right: 16),
                                child: Text(
                                  "Payment Completed\nSuccessfully!",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      color: Colors.black,
                                      fontFamily: AppConstant.fontRegular,
                                      fontSize: 16),
                                )),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Center(
                            child: Container(
                              height: 35,
                              width: 120,
                              margin: EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                  color: AppConstant.appColor,
                                  borderRadius: BorderRadius.circular(6)),
                              child: Center(
                                child: Text(
                                  "View Booking",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      decoration: TextDecoration.none),
                                ),
                              ),
                            ),
                          )
                        ],
                      )),
                ],
              ),
            )));
  }

  void validation() {
    if (number.text.isEmpty) {
      Utils.showToast("Enter Card Number");
    } else if (cardholdername.text.isEmpty) {
      Utils.showToast("Enter Card Holder Name");
    } else if (valid.text.isEmpty) {
      Utils.showToast("Enter Valid ");
    } else if (cardName.text.isEmpty) {
      Utils.showToast("Enter Card Name ");
    } else if (cvv.text.isEmpty) {
      Utils.showToast("Enter Cvv ");
    } else {
      addCardDetail();
    }
  }

  Future addCardDetail() async {
    progressDialog = ProgressDialog(context);
    progressDialog.show();
    try {
      BeanVerifyOtp user = await Utils.getUser();
      FormData from = FormData.fromMap({
        "token": "123456789",
        "userid": user.data!.id,
        "card_number": number.text.toString(),
        "card_name": cardName.text.toString(),
        "valid_thru": valid.text.toString(),
        "holder_name": cardholdername.text.toString(),
        "is_default": "y",
        "cvv": cvv.text.toString(),
        "image": ""
      });
      BeanAddCard? bean =
          await ApiProvider().beanAddcard(from);
      print(bean!.data);
      progressDialog.dismiss(context);
      if (bean.status == true) {
        Utils.showToast(bean.message!);
        setState(() {
          valid.clear();
          number.clear();
          cardholdername.clear();
          Navigator.pop(context, true);
        });
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
          await ApiProvider().beanGetCard(from);
      print(bean!.data);
      progressDialog.dismiss(context);
      if (bean.status == true) {
        Utils.showToast(bean.message!);
        data = bean.data;
        setState(() {
          holderName = bean.data![0].holderName;
          numbercard = bean.data![0].cardNumber;
          expirydate = bean.data![0].validThru;
        });
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
}
