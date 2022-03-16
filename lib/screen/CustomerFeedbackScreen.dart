import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_app/res.dart';
import 'package:food_app/utils/Constents.dart';

class CustomerFeedbackScreen extends StatefulWidget {
  @override
  CustomerFeedbackScreenState createState() => CustomerFeedbackScreenState();
}

class CustomerFeedbackScreenState extends State<CustomerFeedbackScreen> {
  var isSelect = -1;
  bool _isVertical = false;
  double _initialRating = 0.0;
  late double _rating;

  @override
  void initState() {
    _rating = _initialRating;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    // FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      const Center(
                        child: Text(
                          "Customer Feedback",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: AppConstant.fontBold),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Center(
                        child: Text(
                          "You Just Delivered an order!",
                          style: TextStyle(
                              color: AppConstant.appColor,
                              fontSize: 16,
                              fontFamily: AppConstant.fontBold),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Center(
                        child: Text(
                          "Order ID 123456",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: AppConstant.fontBold),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Center(
                        child: Text(
                          "Akshay K",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: AppConstant.fontBold),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 16, right: 16),
                        child: Divider(
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text("Please rat your experience with customer"),
                      ),
                      RatingBar.builder(
                        initialRating: _initialRating,
                        direction:
                            _isVertical ? Axis.vertical : Axis.horizontal,
                        itemCount: 5,
                        itemSize: 50.0,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 10.0),
                        itemBuilder: (context, index) {
                          switch (index) {
                            case 0:
                              return const Icon(
                                Icons.sentiment_very_dissatisfied,
                                size: 30,
                                color: Colors.red,
                              );
                            case 1:
                              return const Icon(
                                Icons.sentiment_dissatisfied,
                                size: 30,
                                color: Colors.redAccent,
                              );
                            case 2:
                              return const Icon(
                                Icons.sentiment_neutral,
                                size: 30,
                                color: Colors.amber,
                              );
                            case 3:
                              return const Icon(
                                Icons.sentiment_satisfied,
                                size: 30,
                                color: Colors.lightGreen,
                              );
                            case 4:
                              return const Icon(
                                Icons.sentiment_very_satisfied,
                                size: 30,
                                color: Colors.green,
                              );
                            default:
                              return Container();
                          }
                        },
                        onRatingUpdate: (rating) {
                          setState(() {
                            _rating = rating;
                          });
                        },
                        updateOnDrag: true,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Text(
                          "Tell us more so we can improve",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontFamily: AppConstant.fontBold),
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  isSelect = 1;
                                });
                              },
                              child: Container(
                                height: 40,
                                margin: const EdgeInsets.only(
                                    left: 10, top: 16, right: 10),
                                decoration: BoxDecoration(
                                    color: isSelect == 1
                                        ? AppConstant.appColor
                                        : const Color(0xffF3F6FA),
                                    borderRadius: BorderRadius.circular(100)),
                                child: Center(
                                  child: Text(
                                    "Customer said thank you",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: isSelect == 1
                                            ? Colors.white
                                            : Colors.black,
                                        fontFamily: AppConstant.fontRegular),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  isSelect = 2;
                                });
                              },
                              child: Container(
                                height: 40,
                                margin: const EdgeInsets.only(
                                    left: 10, top: 16, right: 10),
                                decoration: BoxDecoration(
                                    color: isSelect == 2
                                        ? AppConstant.appColor
                                        : const Color(0xffF3F6FA),
                                    borderRadius: BorderRadius.circular(100)),
                                child: Center(
                                  child: Text(
                                    "Customer said thank you",
                                    style: TextStyle(
                                        color: isSelect == 2
                                            ? Colors.white
                                            : Colors.black,
                                        fontFamily: AppConstant.fontRegular,
                                        fontSize: 12),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  isSelect = 3;
                                });
                              },
                              child: Container(
                                height: 40,
                                margin: const EdgeInsets.only(
                                    left: 10, top: 16, right: 10),
                                decoration: BoxDecoration(
                                    color: isSelect == 3
                                        ? AppConstant.appColor
                                        : const Color(0xffF3F6FA),
                                    borderRadius: BorderRadius.circular(100)),
                                child: Center(
                                  child: Text(
                                    "Customer gave tip",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: isSelect == 3
                                            ? Colors.white
                                            : Colors.black,
                                        fontFamily: AppConstant.fontRegular),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  isSelect = 4;
                                });
                              },
                              child: Container(
                                height: 40,
                                margin: const EdgeInsets.only(
                                    left: 10, top: 16, right: 10),
                                decoration: BoxDecoration(
                                    color: isSelect == 4
                                        ? AppConstant.lightGreen
                                        : const Color(0xffF3F6FA),
                                    borderRadius: BorderRadius.circular(100)),
                                child: Center(
                                  child: Text(
                                    "Customer was on time",
                                    style: TextStyle(
                                        color: isSelect == 4
                                            ? Colors.white
                                            : Colors.black,
                                        fontFamily: AppConstant.fontRegular,
                                        fontSize: 12),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                isSelect = 5;
                              });
                            },
                            child: Container(
                              height: 40,
                              margin: const EdgeInsets.only(
                                  left: 10, top: 16, right: 10),
                              decoration: BoxDecoration(
                                  color: isSelect == 5
                                      ? AppConstant.lightGreen
                                      : const Color(0xffF3F6FA),
                                  borderRadius: BorderRadius.circular(100)),
                              child: Center(
                                child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      "Customer gave me water",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: isSelect == 5
                                              ? Colors.white
                                              : Colors.black,
                                          fontFamily: AppConstant.fontRegular),
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Text(
                          "Tip received from customer? ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontFamily: AppConstant.fontBold),
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Image.asset(
                                  Res.ic_like_round,
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 16),
                                child: Text(
                                  "Yes",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontFamily: AppConstant.fontBold),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Image.asset(
                                  Res.ic_unlike,
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 16),
                                child: Text(
                                  "NO",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontFamily: AppConstant.fontBold),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/feedback');
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(13)),
                    margin: const EdgeInsets.only(
                        top: 25, left: 16, right: 16, bottom: 16),
                    child: const Center(
                        child: Text(
                      "SUBMIT",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: AppConstant.fontBold,
                        fontSize: 12,
                        decoration: TextDecoration.none,
                      ),
                    )),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget getItem(Choice choic) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Image.asset(
        choic.image!,
        width: 50,
        height: 50,
      ),
    );
  }
}

class Choice {
  Choice({this.image});

  String? image;
}

List<Choice> choices = <Choice>[
  Choice(image: Res.ic_emoji_one),
  Choice(image: Res.ic_emoji_two),
  Choice(image: Res.ic_emoji_three),
  Choice(image: Res.ic_emoji_four),
  Choice(image: Res.ic_emoji_five),
];
