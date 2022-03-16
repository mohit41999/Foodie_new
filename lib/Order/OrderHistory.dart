import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_app/res.dart';
import 'package:food_app/utils/Constents.dart';

class OrderHistory extends StatefulWidget {
  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    // FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 210,
                margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Color(0xffF3F6FA)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 16),
                              child: Text(
                                "15",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontFamily: AppConstant.fontBold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 16, top: 8),
                              child: Text(
                                "Booked",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: AppConstant.fontRegular),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 16),
                              child: Text(
                                "13",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontFamily: AppConstant.fontBold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 16, top: 8),
                              child: Text(
                                "Paid",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: AppConstant.fontRegular),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 30),
                                child: Text(
                                  "2",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 24,
                                      fontFamily: AppConstant.fontBold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 16, top: 8),
                                child: Text(
                                  "Cancelled",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontFamily: AppConstant.fontRegular),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: Image.asset(
                              Res.ic_order_history,
                              width: 100,
                              height: 120,
                              fit: BoxFit.cover,
                            )),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Text(
                            "Today's Sales",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: AppConstant.fontRegular),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Text(
                            AppConstant.rupee + "14,425",
                            style: TextStyle(
                                color: AppConstant.lightGreen,
                                fontSize: 18,
                                fontFamily: AppConstant.fontBold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Text(
                            "Project Sales for Tomorow",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: AppConstant.fontRegular),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Text(
                            AppConstant.rupee + "15,425",
                            style: TextStyle(
                                color: AppConstant.appColor,
                                fontSize: 18,
                                fontFamily: AppConstant.fontBold),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return getOrderList();
                },
                itemCount: 10,
              ),
            ],
          ),
          physics: BouncingScrollPhysics(),
        ));
  }

  Widget getOrderList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10, top: 10),
              child: Image.asset(
                Res.ic_people,
                width: 60,
                height: 60,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 16, top: 16),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 1),
                              child: Text(
                                "Kunal Shah",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: AppConstant.fontBold),
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 10),
                  child: Text(
                    "1234 | From MArch 1st.2021 ",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: AppConstant.fontRegular),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(
                        "Weekly Plan",
                        style: TextStyle(
                            color: Color(0xffA7A8BC),
                            fontSize: 14,
                            fontFamily: AppConstant.fontBold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(
                        "Monthly Plan",
                        style: TextStyle(
                            color: Color(0xffA7A8BC),
                            fontSize: 14,
                            fontFamily: AppConstant.fontBold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 10, top: 6),
                        child: Image.asset(
                          Res.ic_breakfast,
                          width: 16,
                          height: 16,
                        )),
                    Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(
                        "Breakfast",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: AppConstant.fontBold),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 16, top: 6),
                        child: Image.asset(
                          Res.ic_dinner,
                          width: 16,
                          height: 16,
                        )),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "Lunch",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: AppConstant.fontBold),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 16, top: 6),
                        child: Image.asset(
                          Res.ic_dinner,
                          width: 16,
                          height: 16,
                        )),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "Dinner",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: AppConstant.fontBold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 1,
                ),
                Divider(
                  color: Colors.grey,
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16, top: 10),
                      child: Image.asset(
                        Res.ic_loc,
                        width: 20,
                        height: 20,
                        color: AppConstant.lightGreen,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5, top: 10),
                      child: Text(
                        "H.no 43223 Manish Height Manish",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: AppConstant.fontRegular),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
