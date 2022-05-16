import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_app/model/BeanConfirmLocation.dart';
import 'package:food_app/model/BeanVerifyOtp.dart';
import 'package:food_app/network/ApiProvider.dart';
import 'package:food_app/screen/OrderDispatchedScreen.dart';
import 'package:food_app/utils/Constents.dart';
import 'package:food_app/utils/HttpException.dart';
import 'package:food_app/utils/PrefManager.dart';
import 'package:food_app/utils/Utils.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';

import '../utils/progress_dialog.dart';

class SetLocationScreen extends StatefulWidget {
  final PickResult pickResult;
  final bool isEdit;
  final String address_id;
  const SetLocationScreen(
      {Key? key,
      required this.pickResult,
      this.isEdit = false,
      this.address_id = ''})
      : super(key: key);

  @override
  State<SetLocationScreen> createState() => _SetLocationScreenState();
}

class _SetLocationScreenState extends State<SetLocationScreen> {
  TextEditingController _controller1 = TextEditingController();
  late ProgressDialog progressDialog;
  @override
  void initState() {
    progressDialog = ProgressDialog(context);
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      _controller1.text = widget.pickResult.formattedAddress!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              maxLines: null,
              controller: _controller1,
            ),
            TextButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppConstant.appColor)),
                onPressed: () {
                  (widget.isEdit)
                      ? editLocation(widget.pickResult, widget.address_id)
                      : confirmLocation(widget.pickResult);
                },
                child: Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }

  Future confirmLocation(PickResult selectedPlace) async {
    progressDialog = ProgressDialog(context);
    progressDialog = ProgressDialog(context);
    progressDialog.show();
    try {
      BeanVerifyOtp user = await Utils.getUser();
      FormData data = FormData.fromMap({
        "userid": user.data!.id,
        "token": "123456789",
        "location": _controller1.text,
        "pincode": '123456',
        "latitude": selectedPlace.geometry!.location.lat,
        "longitude": selectedPlace.geometry!.location.lng
      });
      print("data>>" + data.toString());
      BeanConfirmLocation? bean = await ApiProvider().confirmlocation(data);
      print("bean>>" + data.toString());
      print(bean!.data);
      progressDialog.dismiss(context);
      if (bean.status == true) {
        PrefManager.putBool(AppConstant.session, true);

        Utils.showToast(bean.message!);
        Navigator.pop(context);
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => OrderDispatchedScreen(
        //           // currentPostion!.latitude,
        //           // currentPostion!.longitude,
        //           // selectedPlace.formattedAddress
        //           orderitems_id: '',
        //           orderid: '',
        //           deliveryAddress: '',
        //           kitchenid: '',
        //         )));
      } else {
        Utils.showToast(bean.message!);
      }
    } on HttpException catch (exception) {
      progressDialog.dismiss(context);
      print(exception);
    } catch (exception) {
      progressDialog.dismiss(context);
      print(exception);
    }
  }

  Future editLocation(PickResult selectedPlace, String address_id) async {
    progressDialog = ProgressDialog(context);
    progressDialog = ProgressDialog(context);
    progressDialog.show();
    try {
      print(address_id);
      BeanVerifyOtp user = await Utils.getUser();
      FormData data = FormData.fromMap({
        "userid": user.data!.id,
        "token": "123456789",
        "address_id": address_id,
        "location": _controller1.text,
        "pincode": '123456',
        "latitude": selectedPlace.geometry!.location.lat,
        "longitude": selectedPlace.geometry!.location.lng
      });
      print("data>>" + data.toString());
      BeanConfirmLocation? bean = await ApiProvider().editLocation(data);
      print("bean>>" + data.toString());
      print(bean!.data);
      progressDialog.dismiss(context);
      if (bean.status == true) {
        PrefManager.putBool(AppConstant.session, true);

        Utils.showToast(bean.message!);
        Navigator.pop(context);
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => OrderDispatchedScreen(
        //           // currentPostion!.latitude,
        //           // currentPostion!.longitude,
        //           // selectedPlace.formattedAddress
        //           orderitems_id: '',
        //           orderid: '',
        //           deliveryAddress: '',
        //           kitchenid: '',
        //         )));
      } else {
        Utils.showToast(bean.message!);
      }
    } on HttpException catch (exception) {
      progressDialog.dismiss(context);
      print(exception);
    } catch (exception) {
      progressDialog.dismiss(context);
      print(exception);
    }
  }
}
