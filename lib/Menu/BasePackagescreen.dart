import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_app/Menu/SuccessPackageScreen.dart';
import 'package:food_app/model/BeanAddPackage.dart';
import 'package:food_app/model/BeanGetPackages.dart';
import 'package:food_app/model/BeanVerifyOtp.dart';
import 'package:food_app/network/ApiProvider.dart';
import 'package:food_app/res.dart';
import 'package:food_app/utils/Constents.dart';
import 'package:food_app/utils/HttpException.dart';
import 'package:food_app/utils/PrefManager.dart';
import 'package:food_app/utils/Utils.dart';
import 'package:food_app/utils/progress_dialog.dart';

class BasePackagescreen extends StatefulWidget {
  @override
  _BasePackagescreenState createState() => _BasePackagescreenState();
}

class _BasePackagescreenState extends State<BasePackagescreen> {
  bool isReplaceDefault = true;
  bool isReplaceMenu = false;
  bool isReplaceAddPackages = false;
  bool isCreatePackages = false;
  var isMealType = -1;
  var isSelected = -1;
  var isSelectMenu = -1;
  var isSelectFood = -1;
  var isSelectedNorth = 1;
  var _other2 = false;
  var sunday = false;
  var addDefaultIcon = true;
  Future? future;
  var packagename = TextEditingController();
  var packname = "";
  var date = "";
  late ProgressDialog progressDialog;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context);
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [getPaged()],
      ),
      physics: BouncingScrollPhysics(),
    ));
  }

  getPaged() {
    if (isReplaceDefault == true) {
      return addDafultIcon();
    } else if (isReplaceAddPackages == true) {
      return addPackages();
    } else if (isReplaceMenu == true) {
      return addMenu();
    } else if (isCreatePackages == true) {
      return createPackage();
    }
  }

  addMenu() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 16, top: 16),
            height: 60,
            child: Row(
              children: [
                Text(
                  "Lunch",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: AppConstant.fontBold,
                      fontSize: 16),
                ),
                VerticalDivider(
                  color: Colors.grey,
                  width: 20,
                ),
                SizedBox(
                  width: 16,
                ),
                Image.asset(
                  Res.ic_veg,
                  width: 20,
                  height: 20,
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  "Veg",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: AppConstant.fontBold,
                      fontSize: 16),
                ),
                SizedBox(
                  width: 16,
                ),
                VerticalDivider(color: Colors.grey, width: 20),
                Text(
                  "North Indian Meals",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: AppConstant.fontBold,
                      fontSize: 16),
                ),
                SizedBox(
                  width: 16,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Divider(
            color: Colors.grey.shade400,
          ),
          ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return getList(choices[index]);
            },
            itemCount: choices.length,
          ),
          SizedBox(
            height: 60,
          ),
          InkWell(
            onTap: () {
              setState(() {
                isCreatePackages = true;
                addDefaultIcon = false;
                isReplaceMenu = false;
                isReplaceAddPackages = false;
              });
            },
            child: Container(
              margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
              height: 55,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  "SET PRICE",
                  style: TextStyle(
                      color: Colors.white, fontFamily: AppConstant.fontBold),
                ),
              ),
            ),
          ),
        ],
      ),
      physics: BouncingScrollPhysics(),
    );
  }

  addDafultIcon() {
    return Container(
        margin: EdgeInsets.only(top: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 16),
                    child: Center(
                        child: Padding(
                      padding: EdgeInsets.only(top: 60),
                      child: Image.asset(
                        Res.ic_default_order,
                        width: 220,
                        height: 120,
                      ),
                    )),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Text(
                      "No package added yet",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: AppConstant.fontBold,
                          fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      "look's like you, haven't\n made your package yet.",
                      style: TextStyle(
                          color: Colors.grey,
                          fontFamily: AppConstant.fontRegular,
                          fontSize: 14),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isReplaceDefault = false;
                          isReplaceAddPackages = true;
                        });
                      },
                      child: Container(
                        height: 50,
                        width: 150,
                        margin: EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Color(0xffFFA451),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 2, color: Colors.grey.shade300)
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "CREATE PACKAGE",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontFamily: AppConstant.fontBold),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
          physics: BouncingScrollPhysics(),
        ));
  }

  getList(Choice choic) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: Text(
                choic.title!,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: AppConstant.fontBold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 36),
              child: Image.asset(
                Res.ic_poha,
                width: 55,
                height: 55,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Text(
                "Mutter pAneer+3 Roti\n+Dal Fry+Rice+Salad",
                style: TextStyle(
                    color: Color(0xff707070),
                    fontSize: 14,
                    fontFamily: AppConstant.fontRegular),
              ),
            ),
            SizedBox(
              width: 16,
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/addMeals');
              },
              child: Container(
                height: 50,
                margin: EdgeInsets.only(right: 10),
                width: 50,
                decoration: BoxDecoration(
                    color: AppConstant.appColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Image.asset(
                    Res.ic_plus,
                    width: 15,
                    height: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  addPackages() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16, top: 16),
            child: Text(
              "Packages Name",
              style: TextStyle(
                  color: AppConstant.appColor,
                  fontFamily: AppConstant.fontRegular),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: 16, top: 16),
              child: TextField(
                controller: packagename,
                decoration: InputDecoration(hintText: "Package 1"),
              )),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, top: 16),
            child: Text(
              "Type of Cuisine",
              style: TextStyle(
                  color: Colors.black, fontFamily: AppConstant.fontRegular),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      isSelectFood = 1;
                    });
                  },
                  child: Container(
                    height: 50,
                    width: 110,
                    margin: EdgeInsets.only(left: 16, top: 16),
                    decoration: BoxDecoration(
                        color: isSelectFood == 1
                            ? Color(0xffFEDF7C)
                            : Color(0xffF3F6FA),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        "South Indian",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: AppConstant.fontBold),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      isSelectFood = 2;
                    });
                  },
                  child: Container(
                      margin: EdgeInsets.only(left: 16, top: 16),
                      height: 50,
                      width: 110,
                      decoration: BoxDecoration(
                          color: isSelectFood == 2
                              ? Color(0xffFEDF7C)
                              : Color(0xffF3F6FA),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          "North Indian",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: AppConstant.fontBold),
                        ),
                      )),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      isSelectFood = 3;
                    });
                  },
                  child: Container(
                      margin: EdgeInsets.only(left: 16, top: 16, right: 10),
                      height: 50,
                      width: 110,
                      decoration: BoxDecoration(
                          color: isSelectFood == 3
                              ? Color(0xffFEDF7C)
                              : Color(0xffF3F6FA),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          "Other",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: AppConstant.fontBold),
                        ),
                      )),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, top: 16),
            child: Text(
              "Meal Type",
              style: TextStyle(
                  color: Colors.black, fontFamily: AppConstant.fontRegular),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      isMealType = 1;
                    });
                  },
                  child: Container(
                      margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                      height: 45,
                      width: 110,
                      decoration: BoxDecoration(
                          color: isMealType == 1
                              ? Color(0xff7EDABF)
                              : Color(0xffF3F6FA),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 30,
                          ),
                          Image.asset(
                            Res.ic_veg,
                            width: 20,
                            height: 20,
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            "Veg",
                            style: TextStyle(
                                color: isMealType == 1
                                    ? Colors.white
                                    : Colors.black,
                                fontFamily: AppConstant.fontBold),
                          )
                        ],
                      )),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      isMealType = 2;
                    });
                  },
                  child: Container(
                      margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                      height: 45,
                      width: 110,
                      decoration: BoxDecoration(
                          color: isMealType == 2
                              ? Color(0xff7EDABF)
                              : Color(0xffF3F6FA),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 30,
                          ),
                          Image.asset(
                            Res.ic_chiken,
                            width: 20,
                            height: 20,
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            "Non Veg",
                            style: TextStyle(
                                color: isMealType == 2
                                    ? Colors.white
                                    : Colors.black,
                                fontFamily: AppConstant.fontBold),
                          )
                        ],
                      )),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, top: 16),
            child: Text(
              "Meal For",
              style: TextStyle(
                  color: Colors.black, fontFamily: AppConstant.fontRegular),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      isSelectMenu = 1;
                    });
                  },
                  child: Container(
                    height: 50,
                    width: 110,
                    margin: EdgeInsets.only(left: 16, top: 16),
                    decoration: BoxDecoration(
                        color: isSelectMenu == 1
                            ? Color(0xffFEDF7C)
                            : Color(0xffF3F6FA),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        "Breakfast",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: AppConstant.fontBold),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      isSelectMenu = 2;
                    });
                  },
                  child: Container(
                      margin: EdgeInsets.only(left: 16, top: 16),
                      height: 50,
                      width: 110,
                      decoration: BoxDecoration(
                          color: isSelectMenu == 2
                              ? Color(0xffFEDF7C)
                              : Color(0xffF3F6FA),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          "Lunch",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: AppConstant.fontBold),
                        ),
                      )),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      isSelectMenu = 3;
                    });
                  },
                  child: Container(
                      margin: EdgeInsets.only(left: 16, top: 16, right: 10),
                      height: 50,
                      width: 110,
                      decoration: BoxDecoration(
                          color: isSelectMenu == 3
                              ? Color(0xffFEDF7C)
                              : Color(0xffF3F6FA),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          "Dinner",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: AppConstant.fontBold),
                        ),
                      )),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, top: 26),
            child: Text(
              "Start Date",
              style: TextStyle(
                  color: AppConstant.appColor,
                  fontFamily: AppConstant.fontBold),
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: 16,
              ),
              Expanded(child: Text(date == "" ? "select date" : date)),
              InkWell(
                onTap: () async {
                  var result = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2022));
                  print('$result');
                  setState(() {
                    date = result!.year.toString() +
                        "-" +
                        result.month.toString() +
                        "-" +
                        result.day.toString();
                  });
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Image.asset(
                    Res.ic_calendar,
                    width: 20,
                    height: 20,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 16, top: 16),
                    child: Text(
                      'Including Saturday',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: AppConstant.fontRegular),
                    ),
                  ),
                ),
                Container(
                  height: 30,
                  width: 30,
                  margin: EdgeInsets.only(right: 20, top: 10),
                  child: CupertinoSwitch(
                    activeColor: Color(0xff7EDABF),
                    value: _other2,
                    onChanged: (newValue) {
                      setState(() {
                        _other2 = newValue;
                        if (_other2 == true) {
                        } else {}
                      });
                    },
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 16, top: 16),
                    child: Text(
                      'Including Saturday',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: AppConstant.fontRegular),
                    ),
                  ),
                ),
                Container(
                  height: 30,
                  width: 30,
                  margin: EdgeInsets.only(right: 20, top: 10),
                  child: CupertinoSwitch(
                    activeColor: Color(0xff7EDABF),
                    value: sunday,
                    onChanged: (newValue) {
                      setState(() {
                        sunday = newValue;
                        if (sunday == true) {
                        } else {}
                      });
                    },
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 80,
          ),
          InkWell(
            onTap: () {
              setState(() {
                validation();
              });
            },
            child: Container(
              margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
              height: 55,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  "SET MENU",
                  style: TextStyle(
                      color: Colors.white, fontFamily: AppConstant.fontBold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  createPackage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 30),
          height: 150,
          child: Center(
            child: Image.asset(Res.ic_create_package, width: 130, height: 130),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                child: Text(
                  AppConstant.rupee + "3,000",
                  style: TextStyle(
                      color: Color(0xff7EDABF),
                      fontFamily: AppConstant.fontBold,
                      fontSize: 18),
                ),
                padding: EdgeInsets.only(left: 16, top: 16),
              ),
            ),
            Padding(
              child: Text(
                AppConstant.rupee + "12,000",
                style: TextStyle(
                    color: Color(0xff7EDABF),
                    fontFamily: AppConstant.fontBold,
                    fontSize: 18),
              ),
              padding: EdgeInsets.only(left: 16, top: 16, right: 16),
            ),
          ],
        ),
        SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                child: Text(
                  "Actual Total Price",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: AppConstant.fontRegular,
                      fontSize: 14),
                ),
                padding: EdgeInsets.only(left: 16, top: 16, right: 16),
              ),
            ),
            Padding(
              child: Text(
                "Actual Total Price",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: AppConstant.fontRegular,
                    fontSize: 14),
              ),
              padding: EdgeInsets.only(top: 16, right: 16),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                child: Text(
                  "Weekly Package",
                  style: TextStyle(
                      color: Color(0xff555555),
                      fontFamily: AppConstant.fontBold,
                      fontSize: 14),
                ),
                padding: EdgeInsets.only(left: 16, top: 8, right: 16),
              ),
            ),
            Padding(
              child: Text(
                "Monthly Package",
                style: TextStyle(
                    color: Color(0xff555555),
                    fontFamily: AppConstant.fontBold,
                    fontSize: 14),
              ),
              padding: EdgeInsets.only(top: 8, right: 16),
            ),
          ],
        ),
        Padding(
          child: Text(
            "Set your price (weekly)",
            style: TextStyle(
                color: AppConstant.appColor,
                fontFamily: AppConstant.fontBold,
                fontSize: 14),
          ),
          padding: EdgeInsets.only(left: 16, top: 30, right: 16),
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                width: 100,
                margin: EdgeInsets.only(right: 16, left: 16),
                child: TextField(
                  decoration:
                      InputDecoration(hintText: AppConstant.rupee + "25,00"),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 16),
              child: Text(
                "Variation",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontFamily: AppConstant.fontRegular),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 16),
              child: Text(
                "-16.5%",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: AppConstant.fontRegular),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                width: 100,
                margin: EdgeInsets.only(right: 16, left: 16),
                child: TextField(
                  decoration:
                      InputDecoration(hintText: AppConstant.rupee + "25,00"),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 16),
              child: Text(
                "Variation",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontFamily: AppConstant.fontRegular),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 16),
              child: Text(
                "-16.5%",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: AppConstant.fontRegular),
              ),
            ),
          ],
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SuccessPackageScreen()),
            );
          },
          child: Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 60, bottom: 15),
              height: 55,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Color(0xffFFA451),
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  "CREATE PACKAGE",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: AppConstant.fontBold),
                ),
              )),
        ),
      ],
    );
  }

  Future<BeanAddPackage?> addPackage(
      BuildContext context, String packName) async {
    progressDialog = ProgressDialog(context);
    progressDialog.show();
    try {
      BeanVerifyOtp user = await Utils.getUser();
      FormData from = FormData.fromMap({
        "user_id": user.data!.id,
        "token": "123456789",
        "package_name": packName,
        "cuisine_type": isSelectFood == 0
            ? "0"
            : isSelectFood == 1
                ? "1"
                : isSelectFood == 2
                    ? "2"
                    : "",
        "meal_type": isMealType == 0
            ? "0"
            : isMealType == 1
                ? "1"
                : "",
        "meal_for": isSelectMenu == 0
            ? "0"
            : isSelectMenu == 1
                ? "1"
                : isSelectMenu == 2
                    ? "2"
                    : "",
        "weekly_plan_type": "1",
        "monthly_plan_type": "1",
        "start_date": date,
        "including_saturday": _other2 == false ? "0" : "1",
        "including_sunday": sunday == false ? "0" : "1"
      });
      BeanAddPackage? bean =
          await ApiProvider().addPackage(from) ;
      print(bean!.data);
      progressDialog.dismiss(context);
      if (bean.status == true) {
        Utils.showToast(bean.message!);
        setState(() {
          addDefaultIcon = false;
          isReplaceMenu = true;
          isReplaceAddPackages = false;
        });

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

  void validation() {
    var packName = packagename.text.toString();
    if (packName.isEmpty) {
      Utils.showToast("please select package name");
    } else if (isSelectFood == -1) {
      Utils.showToast("please select cuisine type");
    } else if (isMealType == -1) {
      Utils.showToast("please select meal type");
    } else if (isSelectMenu == -1) {
      Utils.showToast("please select meal for");
    } else if (date.isEmpty) {
      Utils.showToast("please add start date");
    } else {
      addPackage(context, packName);
    }
  }
}

class Choice {
  Choice({this.title, this.image});

  String? title;
  String? image;
}

List<Choice> choices = <Choice>[
  Choice(title: 'Monday'),
  Choice(title: 'Tuesday'),
  Choice(title: 'Wednesday'),
  Choice(title: 'Thursday'),
  Choice(title: 'Friday'),
  Choice(title: 'Saturday'),
  Choice(title: 'Sunday'),
];
