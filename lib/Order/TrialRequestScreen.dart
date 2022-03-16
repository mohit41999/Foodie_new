import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_app/res.dart';
import 'package:food_app/utils/Constents.dart';

class TrialRequestScreen extends StatefulWidget {
  @override
  _TrialRequestScreenState createState() => _TrialRequestScreenState();
}

class _TrialRequestScreenState extends State<TrialRequestScreen> {
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return getOrderList();
                },
                itemCount: 10,
              ),
            ),
          ],
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
                  padding: EdgeInsets.only(left: 16, top: 1),
                  child: Text(
                    "1234 | From MArch 1st.2021 ",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: AppConstant.fontRegular),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 10),
                  child: Text(
                    "Trial Order ",
                    style: TextStyle(
                        color: Color(0xffA7A8BC),
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
                      child: Image.asset(
                        Res.ic_breakfast,
                        width: 20,
                        height: 20,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        "Paneer Sabji+Roti+Dal+Rice+Salad",
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
                Row(
                  children: [
                    Container(
                      height: 50,
                      width: 120,
                      margin: EdgeInsets.only(left: 10, bottom: 10),
                      decoration: BoxDecoration(
                          color: Color(0xffF3F6FA),
                          borderRadius: BorderRadius.circular(14)),
                      child: Center(
                        child: Text(
                          "REJECT",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: AppConstant.fontBold),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, bottom: 10),
                      height: 50,
                      width: 120,
                      decoration: BoxDecoration(
                          color: AppConstant.appColor,
                          borderRadius: BorderRadius.circular(14)),
                      child: Center(
                        child: Text(
                          "ACCEPT",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: AppConstant.fontBold),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ],
        )
      ],
    );
  }
}
