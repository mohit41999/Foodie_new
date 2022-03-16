import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_app/model/BeanAddCustomizePackageTime.dart';
import 'package:food_app/model/BeanVerifyOtp.dart';
import 'package:food_app/model/GetDeliveryTime.dart';
import 'package:food_app/network/ApiProvider.dart';
import 'package:food_app/screen/CustomizePackageScreen.dart';
import 'package:food_app/utils/Constents.dart';
import 'package:food_app/utils/Utils.dart';
import 'package:food_app/utils/progress_dialog.dart';

import '../res.dart';

class SelectDateTime extends StatefulWidget {
  var packageId;
  var kitchenId;
  SelectDateTime(this.packageId, this.kitchenId);

  @override
  _SelectDateTimeState createState() => _SelectDateTimeState();
}

class _SelectDateTimeState extends State<SelectDateTime> {
  late ProgressDialog progressDialog;
  int? _radioValue = 0;
  var isSelected = -1;
  Future? future;
  var first = "";
  var endDate = "";
  var time = "";
  var endTime = "";
  List<String>? data;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      future = getDeliveryTime();
    });
    super.initState();
  }

  void _handleRadioValueChange(int? value) {
    setState(() {
      _radioValue = value;
      switch (_radioValue) {
        case 0:
          setState(() {});
          break;

        case 1:
          setState(() {});
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 16),
              Row(
                children: [
                  SizedBox(
                    width: 16,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      Res.ic_back,
                      width: 16,
                      height: 16,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Text(
                      "When would you like to start meal?",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: AppConstant.fontBold,
                          fontSize: 16),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                // child: Container(
                //   height: 220,
                //   child: ScrollableCleanCalendar(
                //     selectedDateColor: AppConstant.appColor,
                //     rangeSelectedDateColor:
                //         AppConstant.appColor.withOpacity(0.6),
                //     monthLabelStyle:
                //         TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                //     dayWeekLabelStyle: TextStyle(fontWeight: FontWeight.w400),
                //     onRangeSelected: (firstDate, secondDate) {

                //       first=firstDate.toString();
                //       endDate=secondDate.toString();
                //       print('onRangeSelected first $first');
                //       print('onRangeSelected second $endDate');
                //     },
                //     onTapDate: (date) {
                //       print('onTap $date');
                //     },
                //     minDate: DateTime.now(),
                //     maxDate: DateTime.now().add(
                //       Duration(days: 365),
                //     ),
                //     renderPostAndPreviousMonthDates: true,
                //   ),
                // ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Radio(
                            value: 0,
                            groupValue: _radioValue,
                            activeColor: Color(0xff7EDABF),
                            onChanged: _handleRadioValueChange,
                          ),
                          Text('Include Saturday')
                        ],
                      ),
                    ),
                    // Calendar(
                    //   //startOnMonday: true,
                    //   weekDays: ['Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa', 'So'],
                    //   // events: _events,
                    //   onRangeSelected: (range) =>
                    //       print('Range is ${range.from}, ${range.to}'),
                    //   //onDateSelected: (date) => _handleNewDate(date),
                    //   isExpandable: true,
                    //   eventDoneColor: Colors.green,
                    //   selectedColor: Colors.pink,
                    //   todayColor: Colors.blue,
                    //   eventColor: Colors.grey,
                    //   // locale: 'de_DE',
                    //   // todayButtonText: 'Heute',
                    //   // expandableDateFormat: 'EEEE, dd. MMMM yyyy',
                    //   dayOfWeekStyle: TextStyle(
                    //       color: Colors.black,
                    //       fontWeight: FontWeight.w800,
                    //       fontSize: 11),
                    // ),
                    SizedBox(width: 10),
                    Container(
                      child: Row(
                        children: [
                          Radio(
                            value: 1,
                            groupValue: _radioValue,
                            activeColor: Color(0xff7EDABF),
                            onChanged: _handleRadioValueChange,
                          ),
                          Text('Include Sunday')
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "At what time you want delivery?",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: AppConstant.fontBold,
                      fontSize: 16),
                ),
              ),
              Container(
                child: Wrap(
                  children: [
                    data != null
                        ? Container(
                            child: GridView.count(
                              crossAxisCount: 3,
                              childAspectRatio: 2 / 1,
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              children: List.generate(data!.length, (index) {
                                return getItem(data![index], index);
                              }),
                            ),
                          )
                        : Container(
                            child: Center(child: CircularProgressIndicator()),
                          )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Text('Done'),
                  ),
                  onPressed: () {
                    if (first.isEmpty) {
                      Utils.showToast("Please select start end  date");
                    } else if (endDate == null ||
                        endDate.isEmpty ||
                        endDate.length == 0) {
                      Utils.showToast("Please select end date");
                    } else if (time.isEmpty) {
                      Utils.showToast("Please select Time ");
                    } else {
                      addCutomizePackageTime();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<GetDeliveryTime?> getDeliveryTime() async {
    try {
      FormData from =
          FormData.fromMap({"token": "123456789", "package_id": "9"});

      GetDeliveryTime? bean = await ApiProvider().getDeliveryTime(from);
      print(bean!.data);

      if (bean.status == true) {
        data = bean.data;
        setState(() {});
        return bean;
      } else {
        Utils.showToast(bean.message!);
      }

      return null;
    } on HttpException catch (exception) {
      print(exception);
    } catch (exception) {
      print(exception);
    }
  }

  Widget getItem(String data, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          setState(() {
            isSelected = index;
            time = data.toString();
            time.split(" ");
          });
        },
        child: isSelected == index
            ? Container(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    data.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                decoration: BoxDecoration(
                    color: AppConstant.appColor,
                    borderRadius: BorderRadius.circular(5)),
              )
            : Container(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(data.toString(),
                      style: TextStyle(color: Colors.black)),
                ),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: AppConstant.appColor,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(5)),
              ),
      ),
    );
  }

  addCutomizePackageTime() async {
    try {
      progressDialog.show();
      BeanVerifyOtp user = await Utils.getUser();
      FormData from = FormData.fromMap({
        "kitchen_id": widget.kitchenId,
        "package_id": widget.packageId,
        "token": "123456789",
        "user_id": user.data!.id,
        "delivery_startdate": first,
        "delivery_enddate": endDate,
        "delivery_time": time,
      });
      BeanAddCustomizeTime? bean =
          await ApiProvider().addCustomizedPackageDateTime(from);
      print(bean!.data);
      progressDialog.dismiss(context);

      if (bean.status == true) {
        progressDialog.dismiss(context);
        setState(() {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      CustomizePackageScreen(widget.packageId)));
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
}
