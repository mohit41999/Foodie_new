import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:food_app/model/BeanDepositPayment.dart';
import 'package:food_app/model/BeanVerifyOtp.dart';
import 'package:food_app/network/ApiProvider.dart';
import 'package:food_app/res.dart';
import 'package:food_app/screen/HomeBaseScreen.dart';
import 'package:food_app/screen/WebViewContainer.dart';
import 'package:food_app/utils/Constents.dart';
import 'package:food_app/utils/HttpException.dart';
import 'package:food_app/utils/Utils.dart';
import 'package:food_app/utils/progress_dialog.dart';

class Wallet extends StatefulWidget {
  var wallet;

  Wallet(this.wallet);

  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  var amount = TextEditingController();
  late BeanVerifyOtp userBean;
  late ProgressDialog progressDialog;
  var userId = "";
  var url = "";
  final _key = UniqueKey();

  var currentBalance = '';

  void getUser() async {
    userBean = await Utils.getUser();
    userId = userBean.data!.id.toString();
    setState(() {});
  }

  @override
  void initState() {
    getUser();
    super.initState();

    Future.delayed(Duration.zero, () {});
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context);
    // FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    // FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
        key: _scaffoldKey,
        drawer: MyDrawers(),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          Navigator.pop(context);
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 20),
                        child: Image.asset(
                          Res.ic_right_arrow,
                          width: 40,
                          height: 40,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                        height: 180,
                        child: Center(
                          child: Image.asset(
                            Res.ic_payment_default,
                          ),
                        )),
                    SizedBox(height: 25),
                    Padding(
                      padding: EdgeInsets.only(left: 25, top: 16),
                      child: Text(
                        "Total Balance",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 35,
                            fontFamily: AppConstant.fontRegular),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 25, top: 5),
                      child: Text(
                        AppConstant.rupee + widget.wallet,
                        style: TextStyle(
                            color: AppConstant.lightGreen,
                            fontSize: 30,
                            fontFamily: AppConstant.fontBold),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {
                    addBalanceDialog();

/*                  payment();*/
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        left: 16, right: 16, bottom: 16, top: 16),
                    height: 55,
                    decoration: BoxDecoration(
                        color: AppConstant.appColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Center(
                        child: Text(
                          "ADD BALANCE",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: AppConstant.fontBold,
                              fontSize: 10),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  void addBalanceDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            elevation: 6,
            backgroundColor: Colors.transparent,
            child: dialog(context),
          );
        });
  }

  Widget dialog(BuildContext context) => Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              TextFormField(
                maxLines: 1,
                autofocus: false,
                controller: amount,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Add Balance',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Close",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                    color: AppConstant.appColor,
                    child: Text(
                      "Add".toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      if (amount.text.isEmpty) {
                        Utils.showToast("Please enter withdraw amount");
                      } else {
                        Navigator.pop(context);
                        withdrawPayment(amount.text);
                      }

                      // return Navigator.of(context).pop(true);
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      );

  withdrawPayment(String text) async {
    progressDialog = ProgressDialog(context);
    progressDialog.show();
    try {
      BeanVerifyOtp user = await Utils.getUser();
      FormData from = FormData.fromMap(
          {"user_id": user.data!.id, "amount": text, "token": "123456789"});

      BeanDepositPayment? bean = await ApiProvider().depositPayment(from);
      print(bean!.data);
      progressDialog.dismiss(context);
      if (bean.status == true) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WebViewContainer(bean.data!.url)));

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
