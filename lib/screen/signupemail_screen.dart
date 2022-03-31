import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_app/model/BeanConfirmLocation.dart';
import 'package:food_app/model/BeanForgotPassword.dart';
import 'package:food_app/model/BeanVerifyOtp.dart';
import 'package:food_app/model/GetAddressList.dart';
import 'package:food_app/network/ApiProvider.dart';
import 'package:food_app/res.dart';
import 'package:food_app/screen/DashboardScreen.dart';
import 'package:food_app/utils/Constents.dart';
import 'package:food_app/utils/HttpException.dart';
import 'package:food_app/utils/PrefManager.dart';
import 'package:food_app/utils/Utils.dart';
import 'package:food_app/utils/progress_dialog.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';

import 'package:location/location.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import 'OrderDispatchedScreen.dart';

class SignUpWithEmailScreen extends StatefulWidget {
  @override
  _SignUpWithEmailScreenState createState() => _SignUpWithEmailScreenState();
}

class _SignUpWithEmailScreenState extends State<SignUpWithEmailScreen> {
  var email = TextEditingController();
  var password = TextEditingController();
  var name = TextEditingController();
  var mobilenumber = TextEditingController();
  late ProgressDialog progressDialog;
  late Future<GetAddressList?> future;
  String? userId = "";
  bool isLoggedIn = false;
  bool isApiCalling = false;
  PickResult? selectedPlace;
  LatLng? currentPostion;
  final Geolocator geolocator = Geolocator();
  void onLoginStatusChanged(bool isLoggedIn, {profileData}) {
    setState(() {
      this.isLoggedIn = isLoggedIn;
    });
  }

  @override
  void initState() {
    Random random = new Random();
    int randomNumber = random.nextInt(100);
    Future.delayed(Duration.zero, () {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context);
    // FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    // FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Sign Up'),
          backgroundColor: AppConstant.appColor,
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
              ),
              Padding(
                  padding: EdgeInsets.only(left: 16, top: 20, right: 16),
                  child: TextFormField(
                    controller: name,
                    decoration: InputDecoration(
                      labelText: "Enter Name ",
                      fillColor: Colors.grey,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.only(left: 16, top: 20, right: 16),
                  child: TextFormField(
                    controller: mobilenumber,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Enter Mobile Number ",
                      fillColor: Colors.grey,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  )),
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
              Padding(
                  padding: EdgeInsets.only(left: 16, top: 20, right: 16),
                  child: TextFormField(
                    controller: password,
                    decoration: InputDecoration(
                      labelText: "Enter Password ",
                      fillColor: Colors.grey,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: SizedBox(
                  height: 1,
                ),
              ),
              InkWell(
                onTap: () {
                  if (email.text.isEmpty) {
                    Utils.showToast("Please Enter Email");
                  } else if (password.text.isEmpty) {
                    Utils.showToast("Please Enter Password");
                  } else {
                    SignupWithEmail();
                  }
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

  SignupWithEmail() async {
    progressDialog = ProgressDialog(context);
    progressDialog.show();
    try {
      FormData from = FormData.fromMap({
        "email": email.text.toString(),
        "token": "123456789",
        'name': name.text.toString(),
        "password": password.text.toString(),
        "mobilenumber": mobilenumber.text.toString()
      });
      var bean = await ApiProvider().signupWithEmail(from);
      print(bean.toString());
      progressDialog.dismiss(context);
      if (bean['status'] == true) {
        PrefManager.putBool(AppConstant.session, true);
        PrefManager.putString(AppConstant.user, jsonEncode(bean));
        Utils.showToast(bean['message']);

        setState(() {});
        Navigator.pop(context);
        return bean;
      } else {
        Utils.showToast(bean['message']);
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
