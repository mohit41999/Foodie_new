import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_app/model/BeanForgotPassword.dart';
import 'package:food_app/network/ApiProvider.dart';
import 'package:food_app/res.dart';
import 'package:food_app/screen/DashboardScreen.dart';
import 'package:food_app/utils/Constents.dart';
import 'package:food_app/utils/HttpException.dart';
import 'package:food_app/utils/Utils.dart';
import 'package:food_app/utils/progress_dialog.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  var email = TextEditingController();
  late ProgressDialog progressDialog;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context);
    // FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    // FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                        padding: EdgeInsets.only(top: 16, left: 16),
                        child: Image.asset(
                          Res.ic_back,
                          width: 16,
                          height: 16,
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, top: 16),
                    child: Text(
                      "Forgot password",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: AppConstant.fontBold,
                          fontSize: 16),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                  padding: EdgeInsets.only(left: 16, top: 20, right: 16),
                  child: TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                      labelText: "Enter Email ",
                      fillColor: Colors.grey,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  )),
              Expanded(
                child: SizedBox(
                  height: 1,
                ),
              ),
              InkWell(
                onTap: () {
                  forgotPasswod();
                },
                child: Container(
                  margin:
                      EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
                  decoration: BoxDecoration(
                      color: AppConstant.appColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                          "CONTINUE",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  height: 50,
                ),
              ),
            ],
          ),
        ));
  }

  Future<BeanForgotPassword?> forgotPasswod() async {
    progressDialog = ProgressDialog(context);
    progressDialog.show();
    try {
      FormData from = FormData.fromMap(
          {"email": email.text.toString(), "token": "123456789"});
      BeanForgotPassword? bean = await ApiProvider().forgotPassword(from);
      print(bean!.data);
      progressDialog.dismiss(context);
      if (bean.status == true) {
        Utils.showToast(bean.message!);
        setState(() {
          email.text = "";
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
