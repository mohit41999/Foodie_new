import 'dart:async';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_app/model/GetAddressList.dart';
import 'package:food_app/network/ApiProvider.dart';
import 'package:food_app/res.dart';
import 'package:food_app/screen/location_setting.dart';
import 'package:food_app/utils/Constents.dart';
import 'package:food_app/utils/HttpException.dart';
import 'package:food_app/utils/PrefManager.dart';
import 'package:food_app/utils/Utils.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  var _visible = true;
  late AnimationController animationController;
  late Animation<double> animation;

  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() async {
    bool isLogined = await PrefManager.getBool(AppConstant.session);
    if (isLogined) {
      var response = await getAddress();
      if (response == null) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => LocationSettingScreen()));
      } else if (response.data!.length == 0) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => LocationSettingScreen()));
      } else {
        Navigator.pushReplacementNamed(context, '/homebase');
      }
    } else {
      Navigator.pushReplacementNamed(context, '/loginSignUp');
    }
  }

  @override
  dispose() {
    animationController.dispose(); // you need this
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 2));
    animation = new CurvedAnimation(
        parent: animationController, curve: Curves.bounceInOut);
    animation.addListener(() => this.setState(() {}));
    animationController.forward();
    setState(() {
      _visible = !_visible;
    });
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    // FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    // FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    return Scaffold(
        backgroundColor: Color(0xffFCC647),
        body: Center(
          child: Stack(
            children: [
              Center(
                child: Image.asset(Res.ic_logo,
                    width: animation.value * 100,
                    height: animation.value * 100),
              ),
            ],
          ),

          /*child: Image.asset(
            Res.ic_logo,
            width: animation.value * 160,
            height: animation.value * 160,
          ),*/
        ));
  }

  Future<GetAddressList?> getAddress() async {
    var userBean = await Utils.getUser();
    try {
      FormData from = FormData.fromMap(
          {"user_id": userBean.data!.id, "token": "123456789"});

      GetAddressList? bean = await ApiProvider().getAddress(from);
      print(bean!.data);

      if (bean.status == true) {
        setState(() {});
        return bean;
      } else {
        Utils.showToast(bean.message!);
      }

      return null;
    } on HttpException catch (exception) {
      Navigator.pushReplacementNamed(context, '/homebase');
      print(exception);
    } catch (exception) {
      Navigator.pushReplacementNamed(context, '/homebase');
      print(exception);
    }
  }
}
