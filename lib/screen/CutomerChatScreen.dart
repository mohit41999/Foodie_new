import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_app/Menu/BasePackagescreen.dart';
import 'package:food_app/Menu/OrderScreen.dart';
import 'package:food_app/res.dart';
import 'package:food_app/screen/HomeBaseScreen.dart';
import 'package:food_app/utils/Constents.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class CutomerChatScreen extends StatefulWidget {
  @override
  _CutomerChatScreenState createState() => _CutomerChatScreenState();
}

class _CutomerChatScreenState extends State<CutomerChatScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    // FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
        backgroundColor: AppConstant.appColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 16),
              child: Row(
                children: [
                  SizedBox(
                    width: 16,
                  ),
                  InkWell(
                      onTap: () {},
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Image.asset(
                            Res.ic_right_arrow,
                            width: 30,
                            height: 30,
                            color: Colors.white,
                          ),
                        ),
                      )),
                  SizedBox(
                    width: 16,
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Image.asset(
                        Res.ic_people,
                        width: 50,
                        height: 50,
                      )),
                  Padding(
                    child: Text(
                      "Customer Chat",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: AppConstant.fontBold,
                          fontSize: 20),
                    ),
                    padding: EdgeInsets.only(top: 20, left: 16),
                  )
                ],
              ),
              height: 100,
            ),
            Expanded(
              child: Container(
                  margin: EdgeInsets.only(top: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(left: 10, right: 20, top: 16),
                          decoration: BoxDecoration(
                              color: Color(0xffF3F6FA),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10))),
                          height: 55,
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "Lorem ipsum dolar it asmet",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Text(
                                  "9:15 PM",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ],
                          )),
                      Expanded(
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Container(
                              width: double.infinity,
                              margin:
                                  EdgeInsets.only(left: 20, right: 20, top: 50),
                              decoration: BoxDecoration(
                                  color: Color(0xffBEE8FF),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10))),
                              height: 150,
                              child: Column(
                                children: [
                                  Center(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 16, top: 16, right: 16),
                                      child: Text(
                                        "Lorem ipsum dolar it asmet,Lorem ipsum dolar it asmet Lorem ipsum dolar it asmet Lorem ipsum dolar it asmet Lorem ipsum dolar Lorem ipsum dolar Lorem ipsum dolar Lorem ipsum dolar Lorem ipsum dolar Lorem ipsum dolar ",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 48,
                              margin: EdgeInsets.only(
                                  left: 16, right: 16, bottom: 16),
                              decoration: BoxDecoration(
                                  color: Color(0xffF3F6FA),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: EdgeInsets.only(left: 10, top: 10),
                                child: TextField(
                                  decoration: InputDecoration.collapsed(
                                      hintText: "Write message"),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 16, bottom: 16),
                            child: Image.asset(
                              Res.ic_send,
                              width: 50,
                              height: 50,
                            ),
                          )
                        ],
                      )
                    ],
                  )),
            ),
          ],
        ));
  }
}
