import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app/model/BeanVerifyOtp.dart';
import 'package:food_app/network/ApiProvider.dart';
import 'package:food_app/network/EndPoints.dart';
import 'package:food_app/screen/HomeBaseScreen.dart';
import 'package:food_app/screen/update_profile.dart';
import 'package:food_app/utils/Constents.dart';
import 'package:food_app/utils/PrefManager.dart';
import 'package:food_app/utils/Utils.dart';
import 'package:food_app/utils/progress_dialog.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatefulWidget {
  String number;
  final String isExist;

  OtpScreen(this.number, @required this.isExist);

  @override
  State<StatefulWidget> createState() => OtpScreenState();
}

class OtpScreenState extends State<OtpScreen> {
  late ProgressDialog progressDialog;

  var code = "+91";
  late Timer timer;
  int timerMaxSeconds = 60;

  var otp = "";
  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (timerMaxSeconds == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            timerMaxSeconds--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  TextEditingController? pinController = TextEditingController();

  @override
  void dispose() {
    pinController!.dispose();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context);
    // FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    // FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 26),
                child: Text("Verification",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: AppConstant.fontBold,
                        fontSize: 20)),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: EdgeInsets.only(left: 26),
                child: Text(
                  "Enter six digit code we have sent to\n" + widget.number,
                  style: TextStyle(
                      color: Colors.grey,
                      fontFamily: AppConstant.fontRegular,
                      fontSize: 14),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: PinCodeTextField(
                  appContext: context,
                  length: 4,
                  controller: pinController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  obscureText: false,
                  animationType: AnimationType.fade,
                  animationDuration: Duration(milliseconds: 300),
                  onChanged: (value) {
                    print(value);
                  },
                  pinTheme: PinTheme(
                      shape: PinCodeFieldShape.underline,
                      activeColor: Colors.orange,
                      inactiveColor: Colors.purple,
                      selectedColor: Colors.brown),
                  onCompleted: (val) {},
                ),
              ),
              // ),

              (timerMaxSeconds == 0)
                  ? InkWell(
                      onTap: () {
                        setState(() {
                          timerMaxSeconds = 60;
                          startTimer();
                        });
                      },
                      child: Center(
                        child: Text("Resend Code",
                            style: TextStyle(
                                fontFamily: AppConstant.fontBold,
                                fontSize: 14)),
                        /*Text("Resend Code in 19 sec", style: TextStyle(color: Colors.black, fontFamily: AppConstant.fontBold, fontSize: 14),),*/
                      ),
                    )
                  : Center(
                      child: Text(
                          "Resend Code in ${timerMaxSeconds.toString()}",
                          style: TextStyle(
                              color: Colors.grey,
                              fontFamily: AppConstant.fontBold,
                              fontSize: 14)),
                      /*Text("Resend Code in 19 sec", style: TextStyle(color: Colors.black, fontFamily: AppConstant.fontBold, fontSize: 14),),*/
                    ),

              SizedBox(
                height: 100,
              ),
              GestureDetector(
                onTap: () async {
                  if (pinController!.text == "") {
                    Utils.showToast("Please enter otp");
                  } else {
                    verifyOTP(pinController!.text);

                    // bool result = await apiProvider.verifyOtpForLogin(
                    //     widget.number, "1234");
                    // if (result) {
                    //   Navigator.pushAndRemoveUntil(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) => const HomeBaseScreen()),
                    //       (route) => false);
                    // } else {}
                  }
                },
                child: Container(
                  margin:
                      EdgeInsets.only(left: 26, right: 26, top: 25, bottom: 10),
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                      color: AppConstant.appColor,
                      borderRadius: BorderRadius.circular(13)),
                  child: Center(
                    child: Text(
                      "Continue",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: AppConstant.fontBold,
                          fontSize: 16),
                    ),
                  ),
                ),
              )
            ],
          )),
          physics: BouncingScrollPhysics(),
        )),
        appBar: AppBar(
          centerTitle: false,
          brightness: Brightness.light,
          automaticallyImplyLeading: true,
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context, false),
          ),
        ));
  }

  void verifyOTP(String otp) async {
    progressDialog = ProgressDialog(context);
    progressDialog = ProgressDialog(context);
    progressDialog.show();
    print("Otp is here $otp");
    try {
      FormData data = FormData.fromMap({
        "mobilenumber": widget.number,
        "token": "123456789",
        "otp": otp,
      });
      BeanVerifyOtp? bean = await ApiProvider().verifyOtp(data);
      print(bean!.data);
      progressDialog.dismiss(context);
      if (bean.status == true) {
        PrefManager.putBool(AppConstant.session, true);
        PrefManager.putString(AppConstant.user, jsonEncode(bean));
        Utils.showToast(bean.message!);
        (widget.isExist == '0')
            ? Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UpdateProfile(
                          mobile_number: widget.number,
                          name: '',
                          email: '',
                          fromOtp: true,
                        )))
            : Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeBaseScreen()),
                (route) => false);
      } else {
        Utils.showToast(bean.message!);
      }
    } on HttpException catch (exception) {
      progressDialog.dismiss(context);
    } catch (exception) {
      progressDialog.dismiss(context);
    }
  }
}
