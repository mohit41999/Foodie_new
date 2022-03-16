import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_app/Menu/BasePackagescreen.dart';
import 'package:food_app/Menu/OrderScreen.dart';
import 'package:food_app/model/AddOffer.dart';
import 'package:food_app/model/BeanVerifyOtp.dart';
import 'package:food_app/model/GetArchieveOffer.dart';
import 'package:food_app/model/GetLiveOffer.dart';
import 'package:food_app/network/ApiProvider.dart';
import 'package:food_app/res.dart';
import 'package:food_app/screen/AddOfferScreen.dart';
import 'package:food_app/screen/HomeBaseScreen.dart';
import 'package:food_app/utils/Constents.dart';
import 'package:food_app/utils/HttpException.dart';
import 'package:food_app/utils/PrefManager.dart';
import 'package:food_app/utils/Utils.dart';
import 'package:food_app/utils/progress_dialog.dart';

class OfferManagementScreen extends StatefulWidget {
  @override
  _OfferManagementScreenState createState() => _OfferManagementScreenState();
}

class _OfferManagementScreenState extends State<OfferManagementScreen> {
  var isSelected = 1;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Future? _future, futureLive;
  late ProgressDialog progressDialog;
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      _future = getArchieveOffer(context);
      futureLive = getLiveOffers(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog((context));
    // FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    // FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
        drawer: MyDrawers(),
        key: _scaffoldKey,
        backgroundColor: AppConstant.appColor,
        body: Column(
          children: [
            Container(
              child: Row(
                children: [
                  SizedBox(
                    width: 16,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _scaffoldKey.currentState!.openDrawer();
                      });
                    },
                    child: Image.asset(
                      Res.ic_menu,
                      width: 30,
                      height: 30,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, top: 10),
                    child: Text(
                      "Offer Management",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: AppConstant.fontBold),
                    ),
                  ),
                ],
              ),
              height: 150,
            ),
            Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              height: 55,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: Colors.white)),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                        onTap: () {
                          setState(() {
                            isSelected = 1;
                            print(isSelected);
                          });
                        },
                        child: Container(
                          height: 60,
                          width: 180,
                          decoration: BoxDecoration(
                              color: isSelected == 1
                                  ? Colors.white
                                  : Color(0xffFFA451),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(100),
                                  bottomLeft: Radius.circular(100))),
                          child: Center(
                            child: Text(
                              "Active Promos",
                              style: TextStyle(
                                  color: isSelected == 1
                                      ? Colors.black
                                      : Colors.white,
                                  fontFamily: AppConstant.fontBold),
                            ),
                          ),
                        )),
                  ),
                  Expanded(
                    child: InkWell(
                        onTap: () {
                          setState(() {
                            isSelected = 2;
                            print(isSelected);
                          });
                        },
                        child: Container(
                          height: 60,
                          width: 180,
                          decoration: BoxDecoration(
                              color: isSelected == 2
                                  ? Colors.white
                                  : Color(0xffFFA451),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(100),
                                  bottomRight: Radius.circular(100))),
                          child: Center(
                            child: Text(
                              "Archives",
                              style: TextStyle(
                                  color: isSelected == 2
                                      ? Colors.black
                                      : Colors.white,
                                  fontFamily: AppConstant.fontBold),
                            ),
                          ),
                        )),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  margin: EdgeInsets.only(top: 20),
                  child: MenuSelected()),
            ),
          ],
        ));
  }

  MenuSelected() {
    if (isSelected == 1) {
      return Column(
        children: [
          Expanded(
              child: Stack(
            children: [
              FutureBuilder<GetLiveOffer?>(
                  future: futureLive?.then((value) => value as GetLiveOffer?),
                  builder: (context, projectSnap) {
                    print(projectSnap);
                    if (projectSnap.connectionState == ConnectionState.done) {
                      var result;
                      if (projectSnap.data != null) {
                        result = projectSnap.data!.data;
                        if (result != null) {
                          print(result.length);
                          return ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return getLiveOffer(result[index]);
                            },
                            itemCount: result.length,
                          );
                        }
                      }
                    }
                    return Container(
                        child: Center(
                      child: Text(
                        "No Live Offer",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: AppConstant.fontBold),
                      ),
                    ));
                  }),
              Positioned.fill(
                child: Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                        padding: EdgeInsets.only(right: 16, bottom: 16),
                        child: InkWell(
                          onTap: () {
                            addliveOffer();
                          },
                          child: Image.asset(
                            Res.ic_add_round,
                            width: 65,
                            height: 65,
                          ),
                        ))),
              )
            ],
          )),
        ],
      );
    } else {
      return Column(
        children: [
          Expanded(
              child: Stack(
            children: [
              FutureBuilder<GetArchieveOffer?>(
                  future: _future?.then((value) => value as GetArchieveOffer?),
                  builder: (context, projectSnap) {
                    print(projectSnap);
                    if (projectSnap.connectionState == ConnectionState.done) {
                      var result;
                      if (projectSnap.data != null) {
                        result = projectSnap.data!.data;
                        if (result != null) {
                          print(result.length);
                          return ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return getArcieveOffer(result[index]);
                            },
                            itemCount: result.length,
                          );
                        }
                      }
                    }
                    return Container(
                        child: Center(
                      child: Text(
                        "No Archeive Offer",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: AppConstant.fontBold),
                      ),
                    ));
                  }),
              Positioned.fill(
                child: Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                        padding: EdgeInsets.only(right: 16, bottom: 16),
                        child: InkWell(
                          onTap: () {
                            addArchiveOffer();
                          },
                          child: Image.asset(
                            Res.ic_add_round,
                            width: 65,
                            height: 65,
                          ),
                        ))),
              )
            ],
          )),
        ],
      );
    }
  }

  getArcieveOffer(result) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 10, bottom: 10, top: 10),
          width: 65,
          decoration: BoxDecoration(
              color: AppConstant.lightGreen,
              borderRadius: BorderRadius.circular(5)),
          height: 25,
          child: Center(
            child: Text(
              "Archieve",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: AppConstant.fontBold,
                  fontSize: 11),
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "Get " +
                      result.discountValue +
                      "% off on your first discount",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: AppConstant.fontBold,
                      fontSize: 14),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, bottom: 10, top: 10, right: 10),
              width: 65,
              decoration: BoxDecoration(
                  color: Color(0xffBEE8FF),
                  borderRadius: BorderRadius.circular(5)),
              height: 25,
              child: Center(
                child: Text(
                  result.offercode,
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: AppConstant.fontBold,
                      fontSize: 11),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 10, top: 5),
          child: Text(
            result.title,
            style: TextStyle(
                color: Colors.grey,
                fontFamily: AppConstant.fontBold,
                fontSize: 12),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10, top: 5),
          child: Text(
            result.startdate.toString() + " " + result.enddate.toString(),
            style: TextStyle(
                color: Colors.grey,
                fontFamily: AppConstant.fontBold,
                fontSize: 12),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Divider(
          thickness: 2,
          color: Colors.grey.shade200,
        ),
      ],
    );
  }

  Future<GetArchieveOffer?> getArchieveOffer(BuildContext context) async {
    progressDialog = ProgressDialog(context);
    progressDialog.show();
    try {
      BeanVerifyOtp user = await Utils.getUser();
      FormData from =
          FormData.fromMap({"user_id": user.data!.id, "token": "123456789"});
      GetArchieveOffer? bean = await ApiProvider().getArchieveOffer(from);
      print(bean!.data);
      progressDialog.dismiss(context);
      if (bean.status == true) {
        setState(() {});

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

  Future<GetLiveOffer?> getLiveOffers(BuildContext context) async {
    progressDialog = ProgressDialog(context);
    progressDialog.show();
    try {
      BeanVerifyOtp user = await Utils.getUser();
      FormData from =
          FormData.fromMap({"user_id": user.data!.id, "token": "123456789"});
      GetLiveOffer? bean =
          await ApiProvider().getLiveOffers(from) ;
      print(bean!.data);
      progressDialog.dismiss(context);
      if (bean.status == true) {
        setState(() {});

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

  getLiveOffer(result) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 10, bottom: 10, top: 10),
          width: 65,
          decoration: BoxDecoration(
              color: AppConstant.lightGreen,
              borderRadius: BorderRadius.circular(5)),
          height: 25,
          child: Center(
            child: Text(
              "live",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: AppConstant.fontBold,
                  fontSize: 11),
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "Get " +
                      result.discountValue +
                      "% off on your first discount",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: AppConstant.fontBold,
                      fontSize: 14),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, bottom: 10, top: 10, right: 10),
              width: 65,
              decoration: BoxDecoration(
                  color: Color(0xffBEE8FF),
                  borderRadius: BorderRadius.circular(5)),
              height: 25,
              child: Center(
                child: Text(
                  result.offercode,
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: AppConstant.fontBold,
                      fontSize: 11),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 10, top: 5),
          child: Text(
            result.title,
            style: TextStyle(
                color: Colors.grey,
                fontFamily: AppConstant.fontBold,
                fontSize: 12),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10, top: 5),
          child: Text(
            result.startdate + " " + result.enddate,
            style: TextStyle(
                color: Colors.grey,
                fontFamily: AppConstant.fontBold,
                fontSize: 12),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Divider(
          thickness: 2,
          color: Colors.grey.shade200,
        ),
      ],
    );
  }

  addArchiveOffer() async {
    var data = await Navigator.push(
        context, MaterialPageRoute(builder: (_) => AddOfferScreen()));
    if (data != null) {
      _future = getArchieveOffer(context);
    }
  }

  addliveOffer() async {
    var data = await Navigator.push(
        context, MaterialPageRoute(builder: (_) => AddOfferScreen()));
    if (data != null) {
      futureLive = getLiveOffers(context);
    }
  }
}
