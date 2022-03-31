import 'package:another_xlider/another_xlider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_app/res.dart';
import 'package:food_app/screen/DashboardScreen.dart';
import 'package:food_app/utils/Constents.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  String mealFor = '';
  String cuisine = '';
  String mealType = '';
  String mealplan = '';
  double ratings = 2.5;

  RangeValues currentRangeValues = const RangeValues(0, 1000);
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
        body: SafeArea(
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                        padding: EdgeInsets.only(top: 16, left: 16),
                        child: Image.asset(
                          Res.ic_back,
                          width: 16,
                          height: 16,
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, top: 16),
                    child: Text(
                      "Filter",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: AppConstant.fontBold,
                          fontSize: 16),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, top: 16),
                child: Text(
                  "Meal for",
                  style: TextStyle(
                      color: Colors.black, fontFamily: AppConstant.fontBold),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          mealFor = '0';
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                        decoration: BoxDecoration(
                            color: mealFor == '0'
                                ? AppConstant.appColor
                                : Color(0xffF3F6FA),
                            borderRadius: BorderRadius.circular(13)),
                        width: 100,
                        height: 40,
                        child: Center(
                          child: Text(
                            "Breakfast",
                            style: TextStyle(
                                color: mealFor == '0'
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          mealFor = '1';
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                        decoration: BoxDecoration(
                            color: mealFor == '1'
                                ? AppConstant.appColor
                                : Color(0xffF3F6FA),
                            borderRadius: BorderRadius.circular(13)),
                        width: 100,
                        height: 40,
                        child: Center(
                          child: Text(
                            "Lunch",
                            style: TextStyle(
                                color: mealFor == '1'
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          mealFor = '2';
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                        decoration: BoxDecoration(
                            color: mealFor == '2'
                                ? AppConstant.appColor
                                : Color(0xffF3F6FA),
                            borderRadius: BorderRadius.circular(13)),
                        width: 100,
                        height: 40,
                        child: Center(
                          child: Text(
                            "Dinner",
                            style: TextStyle(
                                color: mealFor == '2'
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 26,
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, top: 16),
                child: Text(
                  "Cuisine Type",
                  style: TextStyle(
                      color: Colors.black, fontFamily: AppConstant.fontBold),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                        onTap: () {
                          setState(() {
                            cuisine = '0';
                          });
                        },
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/images/masaladosa.png",
                              width: 20,
                              height: 20,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Text(
                                "North Indian Meals",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: cuisine == '0'
                                        ? AppConstant.appColor
                                        : Colors.black,
                                    fontSize: 12),
                              ),
                            )
                          ],
                        )),
                  ),
                  Expanded(
                    child: InkWell(
                        onTap: () {
                          setState(() {
                            cuisine = '1';
                          });
                        },
                        child: Column(
                          children: [
                            Image.asset(
                              Res.ic_north_meals,
                              width: 20,
                              height: 20,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Text(
                                "South Indian Meals",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: cuisine == '1'
                                        ? AppConstant.appColor
                                        : Colors.black,
                                    fontSize: 12),
                              ),
                            )
                          ],
                        )),
                  ),
                  Expanded(
                    child: InkWell(
                        onTap: () {
                          setState(() {
                            cuisine = '2';
                          });
                        },
                        child: Column(
                          children: [
                            Image.asset(
                              Res.ic_other_meals,
                              width: 20,
                              height: 20,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Text(
                                "Other Meals",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: cuisine == '2'
                                        ? AppConstant.appColor
                                        : Colors.black,
                                    fontSize: 14),
                              ),
                            )
                          ],
                        )),
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(left: 16, top: 16),
                child: Text(
                  "Meal type",
                  style: TextStyle(
                      color: Colors.black, fontFamily: AppConstant.fontBold),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                        onTap: () {
                          setState(() {
                            mealType = '0';
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: mealType == '0'
                                      ? Colors.orangeAccent
                                      : Colors.transparent,
                                  width: 3)),
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 16, right: 16, top: 16),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xffF3F6FA),
                                ),
                                width: 100,
                                height: 60,
                                child: Center(
                                  child: Image.asset(
                                    Res.ic_veg,
                                    width: 25,
                                    height: 25,
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 1, top: 6),
                                child: Text(
                                  "Veg",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                              )
                            ],
                          ),
                        )),
                  ),
                  Expanded(
                    child: InkWell(
                        onTap: () {
                          setState(() {
                            mealType = '1';
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: mealType == '1'
                                      ? Colors.orangeAccent
                                      : Colors.transparent,
                                  width: 3)),
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 16, right: 16, top: 16),
                                decoration: const BoxDecoration(
                                  color: Color(0xffF3F6FA),
                                  shape: BoxShape.circle,
                                ),
                                width: 100,
                                height: 60,
                                child: Center(
                                  child: Image.asset(
                                    Res.ic_chiken,
                                    width: 25,
                                    height: 25,
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 1, top: 6),
                                child: Text(
                                  "Non-Veg",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                              )
                            ],
                          ),
                        )),
                  ),
                  Expanded(
                    child: InkWell(
                        onTap: () {
                          mealType = '2';
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: mealType == '2'
                                      ? Colors.orangeAccent
                                      : Colors.transparent,
                                  width: 3)),
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 16, right: 16, top: 16),
                                decoration: const BoxDecoration(
                                  color: Color(0xffF3F6FA),
                                  shape: BoxShape.circle,
                                ),
                                width: 100,
                                height: 60,
                                child: Center(
                                  child: Image.asset(
                                    Res.ic_vegnonveg,
                                    width: 25,
                                    height: 25,
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 1, top: 6),
                                child: Text(
                                  "Veg-Non-Veg",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                              )
                            ],
                          ),
                        )),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, top: 16),
                child: Text(
                  "Meal Plan",
                  style: TextStyle(
                      color: Colors.black, fontFamily: AppConstant.fontBold),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          mealplan = '0';
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                        decoration: BoxDecoration(
                            color: mealplan == '0'
                                ? AppConstant.appColor
                                : Color(0xffF3F6FA),
                            borderRadius: BorderRadius.circular(13)),
                        width: 100,
                        height: 40,
                        child: Center(
                          child: Text(
                            "Weekly",
                            style: TextStyle(
                                color: mealplan == '0'
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          mealplan = '1';
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                        decoration: BoxDecoration(
                            color: mealplan == '1'
                                ? AppConstant.appColor
                                : Color(0xffF3F6FA),
                            borderRadius: BorderRadius.circular(13)),
                        width: 100,
                        height: 40,
                        child: Center(
                          child: Text(
                            "Month Plan",
                            style: TextStyle(
                                color: mealplan == '1'
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          mealplan == '2';
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                        decoration: BoxDecoration(
                            color: mealplan == '2'
                                ? AppConstant.appColor
                                : Color(0xffF3F6FA),
                            borderRadius: BorderRadius.circular(13)),
                        width: 100,
                        height: 40,
                        child: Center(
                          child: Text(
                            "Trial Meal",
                            style: TextStyle(
                                color: mealplan == '2'
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, top: 16),
                child: Text(
                  "Price",
                  style: TextStyle(
                      color: Colors.black, fontFamily: AppConstant.fontBold),
                ),
              ),
              RangeSlider(
                activeColor: Colors.teal,
                values: currentRangeValues,
                min: 0,
                max: 3000,
                divisions: 3,
                labels: RangeLabels(
                  "₹" + currentRangeValues.start.round().toString(),
                  "₹" + currentRangeValues.end.round().toString(),
                ),
                onChanged: (RangeValues values) {
                  setState(() {
                    currentRangeValues = values;
                  });
                },
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, top: 16),
                child: Text(
                  "Ratings",
                  style: TextStyle(
                      color: Colors.black, fontFamily: AppConstant.fontBold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, top: 16),
                child:
                    // RatingBar.builder(
                    //   itemSize: 40.0,
                    //   initialRating: 0,
                    //   minRating: 1,
                    //   direction: Axis.horizontal,
                    //   allowHalfRating: true,
                    //   itemCount: 5,
                    //   itemPadding: const EdgeInsets.symmetric(horizontal: 15.0),
                    //   itemBuilder: (context, _) => const Icon(
                    //     Icons.star,
                    //     color: Colors.amber,
                    //   ),
                    //   onRatingUpdate: (rating) {
                    //     _rating.value = rating;
                    //     _rating.notifyListeners();
                    //   },
                    // )
                    RatingBar.builder(
                  initialRating: ratings,
                  minRating: 1,
                  itemSize: 40.0,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 15.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: AppConstant.appColor,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      ratings = rating;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  'Rating: ${ratings}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              InkWell(
                onTap: () {
                  sendData();
                },
                child: Container(
                  margin:
                      EdgeInsets.only(top: 26, bottom: 16, left: 16, right: 16),
                  decoration: BoxDecoration(
                      color: AppConstant.appColor,
                      borderRadius: BorderRadius.circular(13)),
                  height: 50,
                  child: Center(
                    child: Text(
                      "APPLY FILTERS",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          )),
        ));
  }

  void sendData() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => DashboardScreen(
                mealfor: mealFor,
                cuisine: cuisine,
                mealPlan: mealplan,
                mealtype: mealType,
                min: currentRangeValues.start,
                max: currentRangeValues.end,
                fromHome: false,
              )),
    );
  }
}
