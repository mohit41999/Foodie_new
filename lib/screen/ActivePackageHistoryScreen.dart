import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_app/model/BeanActivePackageHistory.dart';
import 'package:food_app/model/BeanCustomizedPackage.dart' as custom;
import 'package:food_app/model/BeanPackageDetail.dart';
import 'package:food_app/model/BeanVerifyOtp.dart';
import 'package:food_app/network/ApiProvider.dart';
import 'package:food_app/res.dart';
import 'package:food_app/utils/Constents.dart';
import 'package:food_app/utils/Utils.dart';
import 'package:food_app/utils/progress_dialog.dart';

class ActivePackageHistoryScreen extends StatefulWidget {
  var orderid;
  var kitchenname;
  var address;
  ActivePackageHistoryScreen(this.orderid, this.kitchenname, this.address);

  @override
  State<StatefulWidget> createState() => ActivePackageHistoryScreenState();
}

class ActivePackageHistoryScreenState
    extends State<ActivePackageHistoryScreen> {
  late ProgressDialog progressDialog;
  var mealFor = "";
  String? cusineType = "";
  var mealType = "";
  List<DayList>? dayList;
  final _listItems = List.generate(200, (i) => "Item $i");

  // Used to generate random integers
  final _random = Random();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      packageHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context);
    // FlutterStatusbarcolor.setStatusBarColor(Colors.white);
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
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                    onPressed: () => Navigator.pop(context, false),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 16, top: 16),
                        child: Text(
                          widget.kitchenname,
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 6, left: 16),
                        child: Text(
                          widget.address,
                          style: TextStyle(color: Colors.black, fontSize: 13),
                        ),
                      ),
                    ],
                  )
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
                      "Lunch",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Image.asset(
                      Res.ic_veg,
                      width: 20,
                      height: 20,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Text(
                      "Veg",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Text(
                      cusineType!.isEmpty ? "South Indian" : cusineType!,
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                color: Colors.grey,
              ),
              dayList == null
                  ? Center(
                      child: Text("No History Available"),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return getPackage(dayList![index]);
                      },
                      itemCount: dayList!.length,
                    )
            ],
          ),
        )));
  }

  Future<BeanActivePackageHistory?> packageHistory() async {
    try {
      progressDialog.show();
      FormData from = FormData.fromMap({
        "token": "123456789",
        "orderid": widget.orderid,
      });
      BeanActivePackageHistory? bean = await ApiProvider()
          .activePackageHistory(from);
      print(bean!.data);
      progressDialog.dismiss(context);
      if (bean.status == true) {
        cusineType = bean.data![0].cuisinetype;
        dayList = bean.data![0].dayList;
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

  Widget getPackage(DayList dayList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16, top: 8),
              child: Text(
                dayList.day!,
                style: TextStyle(color: AppConstant.appColor, fontSize: 14),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.only(right: 16, top: 8),
                child: Text(
                  dayList.time!,
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(left: 16, top: 8),
                child: Text(
                  dayList.menuItem!,
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
              ),
            ),
            Container(
                height: 40,
                width: 100,
                margin: EdgeInsets.only(right: 16, top: 16),
                color:
                    Colors.primaries[_random.nextInt(Colors.primaries.length)]
                        [_random.nextInt(9) * 100],
                child: Center(
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: Text(
                        dayList.status!,
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ],
    );
  }
}
