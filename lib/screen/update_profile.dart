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
import 'package:food_app/screen/HomeBaseScreen.dart';
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

class UpdateProfile extends StatefulWidget {
  final String mobile_number;
  final String email;
  final String name;
  final bool fromOtp;

  const UpdateProfile(
      {Key? key,
      required this.mobile_number,
      required this.email,
      required this.name,
      this.fromOtp = false})
      : super(key: key);
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  var email = TextEditingController();
  var name = TextEditingController();
  var mobilenumber = TextEditingController();
  late ProgressDialog progressDialog;

  @override
  void initState() {
    email.text = widget.email;
    name.text = widget.name;
    mobilenumber.text = widget.mobile_number;
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
          title: Text('Profile'),
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
                  } else {
                    updateProfile();
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

  updateProfile() async {
    BeanVerifyOtp user = await Utils.getUser();
    progressDialog = ProgressDialog(context);
    progressDialog.show();
    try {
      FormData from = FormData.fromMap({
        "email": email.text.toString(),
        "user_id": user.data!.id,
        "token": "123456789",
        'name': name.text.toString(),
        "mobile_number": mobilenumber.text.toString()
      });
      BeanVerifyOtp? bean = await ApiProvider().updateProfile(from);
      print(bean.toString());
      progressDialog.dismiss(context);
      if (bean!.status == true) {
        PrefManager.putBool(AppConstant.session, true);
        PrefManager.putString(AppConstant.user, jsonEncode(bean));
        Utils.showToast(bean.message!);

        setState(() {});
        (widget.fromOtp)
            ? Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeBaseScreen()),
                (route) => false)
            : {};
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
