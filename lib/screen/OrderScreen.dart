import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_app/res.dart';
import 'package:food_app/screen/HomeBaseScreen.dart';
import 'package:food_app/utils/Constents.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var isSelected = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      bottomsheet(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    // FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    // FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
        drawer: MyDrawers(),
        backgroundColor: AppConstant.appColor,
        key: _scaffoldKey,
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
                      onTap: () {
                        setState(() {
                          _scaffoldKey.currentState!.openDrawer();
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Image.asset(
                          Res.ic_menu,
                          width: 30,
                          height: 30,
                          color: Colors.white,
                        ),
                      )),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                      child: Text(
                        "Orders History",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: AppConstant.fontBold),
                      ),
                    ),
                  ),
                ],
              ),
              height: 70,
            ),
            Expanded(
              child: Container(
                  margin: EdgeInsets.only(top: 16, left: 16, right: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return getItem();
                          },
                          itemCount: 4,
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ));
  }

  Widget getItem() {
    return InkWell(
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                      padding: EdgeInsets.only(left: 16, top: 16),
                      child: Text(
                        "Kitchen Name",
                        style: TextStyle(
                            fontFamily: AppConstant.fontBold,
                            color: Colors.black),
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(right: 16, top: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Color(0xff7EDABF)),
                  width: 60,
                  height: 30,
                  child: Center(
                    child: InkWell(
                      onTap: () {},
                      child: Text(
                        "Active",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
                padding: EdgeInsets.only(left: 16, top: 16),
                child: Text(
                  "1234 |Order From 12 -20 Apr,2021",
                  style: TextStyle(
                      fontFamily: AppConstant.fontRegular,
                      color: Color(0xffA7A8BC)),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 10),
                  child: Text(
                    "Weekly Lunch",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: AppConstant.fontBold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: RatingBarIndicator(
                    rating: 4,
                    itemCount: 5,
                    itemSize: 15.0,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 10, bottom: 16),
                  child: Text(
                    "Total Bill: ₹310",
                    style: TextStyle(
                        color: Color(0xff7EDABF),
                        fontSize: 15,
                        fontFamily: AppConstant.fontBold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 16, top: 10, bottom: 16),
                  child: Text(
                    "Repeat Order",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontFamily: AppConstant.fontRegular),
                  ),
                ),
              ],
            )
          ],
        ));
  }

  void bottomsheet(BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          // <-- for border radius
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
        ),
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setModelState) {
            return Wrap(
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "History of order no",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: AppConstant.fontBold,
                                  fontSize: 18),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(right: 16),
                              child: Image.asset(
                                Res.ic_cross,
                                width: 16,
                                height: 16,
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return getHistory();
                          },
                          itemCount: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          });
        });
  }

  getHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset(
              Res.ic_idle,
              width: 50,
              height: 50,
            ),
            Column(
              children: [
                Text(
                  "Poha",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: AppConstant.fontBold),
                ),
                Text(
                  "13 Feb",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: AppConstant.fontBold),
                ),
              ],
            ),
            Text(
              "Deliverd at 7:35 pm",
              style: TextStyle(
                  color: AppConstant.lightGreen,
                  fontSize: 16,
                  fontFamily: AppConstant.fontBold),
            )
          ],
        )
      ],
    );
  }
}
