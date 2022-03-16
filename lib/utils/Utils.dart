import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/model/BeanSignUp.dart';
import 'package:food_app/model/BeanVerifyOtp.dart';
import 'package:food_app/utils/Constents.dart';

import 'PrefManager.dart';



class Utils{
  static const gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.05, 0.9],
      colors: [Color(0xffEFEFEF)]);

  static showToast(String msg){
    Fluttertoast.showToast(msg: msg, toastLength: Toast.LENGTH_SHORT,);

  }

  static Widget getLoader(){
    return CircularProgressIndicator();
  }
  static void printWrapped(String text) {
    final pattern = new RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print("${match.group(0)}"));
  }

  static Future<BeanVerifyOtp> getUser() async{
    var data = await PrefManager.getString(AppConstant.user);
    printWrapped("---------------------user data------------------");
    printWrapped(json.encode(data));
    return BeanVerifyOtp.fromJson(json.decode(data));
  }



}