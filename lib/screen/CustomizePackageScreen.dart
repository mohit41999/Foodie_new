import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:food_app/model/CustomizedPackageDetail.dart' as custom;
import 'package:food_app/model/BeanPackageDetail.dart';
import 'package:food_app/model/BeanVerifyOtp.dart';
import 'package:food_app/network/ApiProvider.dart';
import 'package:food_app/res.dart';
import 'package:food_app/screen/SelectDateTime.dart';
import 'package:food_app/utils/Constents.dart';
import 'package:food_app/utils/Utils.dart';
import 'package:food_app/utils/progress_dialog.dart';

class CustomizePackageScreen extends StatefulWidget {
  var packageId;
  CustomizePackageScreen(this.packageId);

  @override
  State<StatefulWidget> createState() => PackageDetailScreenState();
}

class PackageDetailScreenState extends State<CustomizePackageScreen> {
  late ProgressDialog progressDialog;
  List<custom.PackageDetail>? packageDetail;

  String? mealFor = "";
  String? packageId = "";
  String? kitchenId = "";
  String? cusineType = "";
  String? mealType = "";
  String? packageName = "";

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      packageDetailApi();
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
                Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text(
                    packageName!,
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
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
                    mealFor!,
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
                    mealType!,
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text(
                    cusineType!,
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
            if (packageDetail == null)
              Center(
                child: Text("No Package Available"),
              )
            else
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return getPackage(packageDetail![index]);
                  },
                  itemCount: packageDetail!.length,
                ),
              ),
          ],
        )));
  }

  Future<custom.BeanCustomizedPackageDetail?> packageDetailApi() async {
    try {
      progressDialog.show();
      BeanVerifyOtp user = await Utils.getUser();
      FormData from = FormData.fromMap({
        "token": "123456789",
        "user_id": "25",
        "package_id": "9",
      });
      custom.BeanCustomizedPackageDetail? bean =
          await ApiProvider().customizedPackageDetail(from)
              ;
      print(bean!.data);
      progressDialog.dismiss(context);
      if (bean.status == true) {
        mealFor = bean.data!.mealfor;
        kitchenId = bean.data!.kitchenId;
        packageId = bean.data!.packageId;
        cusineType = bean.data!.cuisinetype;
        mealType = bean.data!.mealtype;
        packageName = bean.data!.packageName;
        if (bean.data!.packageDetail != null) {
          packageDetail = bean.data!.packageDetail;
        }

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

  Widget getPackage(custom.PackageDetail packageDetail) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16, top: 8),
              child: Text(
                packageDetail.daysName!,
                style: TextStyle(color: AppConstant.appColor, fontSize: 14),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.only(right: 16, top: 8),
                child: Text(
                  packageDetail.customisedTime!,
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 16, top: 8),
          child: Text(
            packageDetail.itemName!,
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
        ),
      ],
    );
  }
}
