import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_app/model/BeanAddCustomizePackageTime.dart';
import 'package:food_app/model/BeanVerifyOtp.dart';
import 'package:food_app/model/GetDeliveryTime.dart';
import 'package:food_app/network/ApiProvider.dart';
import 'package:food_app/screen/KitchenDetails/CustomizePackageScreen.dart';
import 'package:food_app/utils/Constents.dart';
import 'package:food_app/utils/Utils.dart';
import 'package:food_app/utils/progress_dialog.dart';
import 'package:scrollable_clean_calendar/controllers/clean_calendar_controller.dart';
import 'package:scrollable_clean_calendar/utils/enums.dart';

import '../res.dart';
import 'package:scrollable_clean_calendar/scrollable_clean_calendar.dart';

class SelectDateTime extends StatefulWidget {
  var packageId;
  var kitchenId;
  var bookType;
  SelectDateTime(this.packageId, this.kitchenId, this.bookType);

  @override
  _SelectDateTimeState createState() => _SelectDateTimeState();
}

class _SelectDateTimeState extends State<SelectDateTime> {
  late ProgressDialog progressDialog;
  int? _radioValue = 0;
  var isSelected = -1;
  Future? future;
  DateTime? first;
  DateTime? endDate;
  var time = "";
  var endTime = "";
  List<String>? data;

  @override
  void initState() {
    print(widget.packageId);
    print(widget.bookType);
    Future.delayed(Duration.zero, () {
      future = getDeliveryTime(widget.packageId);
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
                child: Container(
                    height: 300,
                    child: ScrollableCleanCalendar(
                      calendarController: CleanCalendarController(
                        minDate: DateTime.now(),
                        maxDate: DateTime(DateTime.now().year + 1),
                        initialDateSelected: first,
                        endDateSelected: endDate,
                        onRangeSelected: (firstDate, secondDate) {
                          first = firstDate;
                          endDate = secondDate!;
                        },
                        onDayTapped: (date) {},

                        onPreviousMinDateTapped: (date) {},
                        onAfterMaxDateTapped: (date) {},
                        weekdayStart: DateTime.monday,

                        // initialDateSelected: DateTime(2022, 3, 15),
                        // endDateSelected: DateTime(2022, 3, 20),
                      ),
                      layout: Layout.BEAUTY,
                      daySelectedBackgroundColorBetween:
                          AppConstant.appColor.withOpacity(0.2),
                      daySelectedBackgroundColor: AppConstant.appColor,
                      calendarCrossAxisSpacing: 0,
                    )),
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
                    print(DateTime(first!.year, first!.month, first!.day + 30));
                    if (first == null) {
                      Utils.showToast("Please select start end  date");
                    } else if (endDate == null) {
                      Utils.showToast("Please select end date");
                    } else if (time.isEmpty) {
                      Utils.showToast("Please select Time ");
                    } else if ((widget.bookType == 'weekly')
                        ? DateTime(first!.year, first!.month, first!.day + 6) !=
                            endDate
                        : DateTime(
                                first!.year, first!.month, first!.day + 30) !=
                            endDate) {
                      (widget.bookType == 'weekly')
                          ? Utils.showToast("Please select upto 7 days only ")
                          : Utils.showToast(
                              "Valid date is select upto 30 days only ");
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

  Future<GetDeliveryTime?> getDeliveryTime(String packageId) async {
    try {
      FormData from =
          FormData.fromMap({"token": "123456789", "package_id": packageId});

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
        "delivery_startdate": '${first!.year}-${first!.month}-${first!.day}',
        "delivery_enddate":
            '${endDate!.year}-${endDate!.month}-${endDate!.day}',
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
                  builder: (context) => CustomizePackageScreen(
                      widget.packageId, widget.kitchenId, widget.bookType)));
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
