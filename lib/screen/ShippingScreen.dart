import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app/model/BeanAddCart.dart';
import 'package:food_app/model/BeanApplyPromo.dart';
import 'package:food_app/model/BeanUpdateCart.dart';
import 'package:food_app/model/BeanVerifyOtp.dart';
import 'package:food_app/model/GetCartDetail.dart' as cart;
import 'package:food_app/model/RemoveCart.dart';
import 'package:food_app/network/ApiProvider.dart';
import 'package:food_app/res.dart';
import 'package:food_app/screen/PaymentScreen.dart';
import 'package:food_app/utils/Constents.dart';
import 'package:food_app/utils/HttpException.dart';
import 'package:food_app/utils/Utils.dart';
import 'package:food_app/utils/progress_dialog.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

class ShippingScreen extends StatefulWidget {
  var address;
  var kitchenId;

  ShippingScreen(this.address, this.kitchenId);

  @override
  _ShippingScreenState createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var isSelected = 0;

  Future? future;
  var distancekm = "";
  String? total_amount = "";
  String? kitchen_id = "";
  var applyPromoController = TextEditingController();
  String? tax_amount = "";
  late ProgressDialog progressDialog;
  String? delivery_charge = "";
  String? CouponDiscount = "";
  var type = "";
  String? deliveryLat = "";
  String? deliveryLong = "";
  String? deliveryAddress = "";
  Position? position;

  bool showDiscount = false;
  String? address;
  Future<void> GetAddressFromLatLong(Position position) async {
    deliveryAddress = "";
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    print(placemarks);
    Placemark place = placemarks[0];
    deliveryAddress =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
  }

  getCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Utils.showToast('permission denied- please enable it from app settings');
      // Permissions are denied forever, handle appropriately.

      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    position = await Geolocator.getCurrentPosition();
    GetAddressFromLatLong(position!);
  }

  getUserAddress() async {
    print("get USer address api call");
    //call this async method from whereever you need

    LocationData? myLocation;
    String error;

    try {
      await getCurrentLocation();
      setState(() {});
      //myLocation = await location.getLocation();
    } on PlatformException catch (e) {
      print(e);
      if (e.code == 'PERMISSION_DENIED') {
        error = 'please grant permission';
        await getCurrentLocation();
        print(error);
      }
      if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error = 'permission denied- please enable it from app settings';
        await getCurrentLocation();
        print(error);
      }
      //myLocation = null;
    }
    var currentLocation = myLocation;
    // final coordinates =
    //     new Coordinates(myLocation?.latitude, myLocation?.longitude);
  }

  List<cart.CartItem>? data;
  Future initialize() async {
    await getUserAddress();
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      future = getCartDetail();
      initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context);
    // FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    // FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 26,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context, true);
                      },
                      child: Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Image.asset(
                            Res.ic_back,
                            width: 16,
                            height: 16,
                          )),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Text(
                              "Your Location",
                              style: TextStyle(color: Color(0xffA7A8BC)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Text(
                              widget.address,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: AppConstant.fontBold,
                                  fontSize: 14),
                            ),
                          )
                        ],
                      ),
                    ),
                    /*  Padding(
                      padding: EdgeInsets.only(right: 6),
                      child: Text(
                        "Change",
                        style: TextStyle(color: AppConstant.appColor),
                      ),
                    ),*/
                    Column(
                      children: [],
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: applyPromoController,
                          decoration: InputDecoration(hintText: 'Apply Offer'),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (applyPromoController.text.toString().isEmpty) {
                            Utils.showToast("Please enter promo");
                          } else {
                            applyPromo();
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppConstant.appColor,
                              borderRadius: BorderRadius.circular(13)),
                          height: 40,
                          width: 80,
                          child: Center(
                            child: Text(
                              "Apply",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 16),
                  child: Text(
                    "Services",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontFamily: AppConstant.fontBold),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FutureBuilder<cart.GetCartDetail?>(
                            future: future
                                ?.then((value) => value as cart.GetCartDetail?),
                            builder: (context, projectSnap) {
                              print(projectSnap);
                              if (projectSnap.connectionState ==
                                  ConnectionState.done) {
                                var result;
                                if (projectSnap.data != null) {
                                  result = projectSnap.data!.data!.cartItems;
                                  if (result != null) {
                                    print(result.length);
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      physics: BouncingScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return getServices(result[index]);
                                      },
                                      itemCount: result.length,
                                    );
                                  }
                                }
                              }
                              if (projectSnap.connectionState ==
                                  ConnectionState.waiting) {
                                return Container(
                                    child: Center(
                                        child: CircularProgressIndicator()));
                              } else {
                                return Container(
                                    child:
                                        Center(child: Text("No Item Found")));
                              }
                            }),
                        SizedBox(
                          height: 16,
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                        /*   Row(
                        children: [
                          SizedBox(
                            width: 16,
                          ),
                          Image.asset(
                            Res.ic_veg,
                            width: 16,
                            height: 16,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 16),
                              child: Text(
                                "Package 1",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: AppConstant.fontBold,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Text(
                              "₹3,000",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: AppConstant.fontBold,
                                  fontSize: 16),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Text(
                          "South indian",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: AppConstant.fontRegular,
                              fontSize: 13),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Text(
                          "including ,saturday,sunday",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: AppConstant.fontRegular,
                              fontSize: 13),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Text(
                          "11 Apr to  March 2021",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: AppConstant.fontRegular,
                              fontSize: 13),
                        ),
                      ),*/
                        SizedBox(
                          height: 16,
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                        data != null
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Text(
                                            "Taxes",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily:
                                                    AppConstant.fontRegular,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 16),
                                        child: Text(
                                          "₹" + tax_amount!,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily:
                                                  AppConstant.fontRegular,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Text(
                                            "Delivery Charge",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily:
                                                    AppConstant.fontRegular,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 16),
                                        child: Text(
                                          "₹" + delivery_charge!,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily:
                                                  AppConstant.fontRegular,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Text(
                                            "Coupon",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily:
                                                    AppConstant.fontRegular,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 16),
                                        child: Text(
                                          "-₹ " + CouponDiscount!,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily:
                                                  AppConstant.fontRegular,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  // Visibility(
                                  //   visible: showDiscount,
                                  //   child: Row(
                                  //     children: [
                                  //       Expanded(
                                  //         child: Padding(
                                  //           padding: EdgeInsets.only(left: 10),
                                  //           child: Text(
                                  //             "Discount",
                                  //             style: TextStyle(
                                  //                 color: Colors.black,
                                  //                 fontFamily:
                                  //                     AppConstant.fontRegular,
                                  //                 fontSize: 16),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //       Padding(
                                  //         padding: EdgeInsets.only(left: 16),
                                  //         child: Text(
                                  //           AppConstant.rupee + discount,
                                  //           style: TextStyle(
                                  //               color: Colors.black,
                                  //               fontFamily:
                                  //                   AppConstant.fontRegular,
                                  //               fontSize: 16),
                                  //         ),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Text(
                                            "Subtotal",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily:
                                                    AppConstant.fontBold,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 16),
                                        child: Text(
                                          "₹" + total_amount!,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: AppConstant.fontBold,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Divider(
                                    color: Colors.grey,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Text(
                                            "Ordering for",
                                            style: TextStyle(
                                                color: Color(0xffA7A8BC),
                                                fontFamily:
                                                    AppConstant.fontBold,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ),
                                      /*    Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Text(
                              "Change",
                              style: TextStyle(
                                  color: AppConstant.appColor,
                                  fontFamily: AppConstant.fontRegular,
                                  fontSize: 16),
                            ),
                          ),*/
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text(
                                      "Prepared joshi, +91997777979",
                                      style: TextStyle(
                                          color: Color(0xffA7A8BC),
                                          fontFamily: AppConstant.fontBold,
                                          fontSize: 16),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (data != null) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PaymentScreen(
                                                        total_amount,
                                                        deliveryAddress,
                                                        tax_amount,
                                                        delivery_charge,
                                                        applyPromoController
                                                            .text
                                                            .toString(),
                                                        kitchen_id,
                                                        position!
                                                            .latitude
                                                            .toString(),
                                                        position!.longitude
                                                            .toString(),
                                                        "shipping")));
                                      } else {
                                        Utils.showToast(
                                            "Please add item in cart");
                                      }
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: 16, right: 16, top: 16),
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(13)),
                                      child: Center(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "ADD PAYMENT DETAILS",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            SizedBox(
                                              width: 16,
                                            ),
                                            Image.asset(
                                              Res.ic_next_arrow,
                                              width: 17,
                                              height: 17,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : Container()
                      ],
                    ))
              ],
            ),
          ),
        ));
  }

  Future<cart.GetCartDetail?> getCartDetail() async {
    try {
      BeanVerifyOtp user = await Utils.getUser();
      print(user.data!.id);
      FormData from = FormData.fromMap({
        "token": "123456789",
        "user_id": user.data!.id,
      });
      print(
        "param" + user.data!.id!,
      );
      cart.GetCartDetail? bean = await ApiProvider().getCartDetail(from);
      print(bean!.data);
      if (bean.status == true) {
        total_amount = bean.data!.subTotal;
        tax_amount = bean.data!.taxAmount;
        delivery_charge = bean.data!.deliveryCharge;
        CouponDiscount = bean.data!.couponDiscount;
        data = bean.data!.cartItems;
        kitchen_id = data![0].kitchenId;
        deliveryLat = bean.data!.myLocation!.latitude;
        deliveryLong = bean.data!.myLocation!.longitude;
        // deliveryAddress = bean.data!.myLocation!.address;

        setState(() {});
        return bean;
      } else {
        Utils.showToast(bean.message!);
      }

      return null;
    } on HttpException catch (exception) {
      setState(() {
        data = null;
      });
      print(exception);
    } catch (exception) {
      setState(() {
        data = null;
      });
      print(exception);
    }
  }

  Widget getServices(cart.CartItem result) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: result.menuimage!.isEmpty
                  ? Image.asset(
                      Res.ic_poha,
                      width: 60,
                      height: 60,
                    )
                  : Image.network(
                      result.menuimage!,
                      width: 60,
                      height: 60,
                    )),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 4),
                  child: Text(
                    result.itemName!,
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: AppConstant.fontBold,
                        fontSize: 16),
                  )),
              Text(
                result.cuisinetype!,
                style: TextStyle(color: Color(0xffA7A8BC)),
              ),
              Text(
                "₹" + result.price!,
                style: TextStyle(color: Color(0xff7EDABF)),
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      result.deliveryDate! +
                          "/" +
                          result.deliveryFromtime! +
                          "/" +
                          result.deliveryTotime!,
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: Text(
                      "₹" + result.price!,
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ],
          )),
          (result.mealtype == 'trial')
              ? Container(
                  margin: EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                      color: AppConstant.appColor,
                      borderRadius: BorderRadius.circular(100)),
                  height: 30,
                  width: 70,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 16,
                      ),
                      InkWell(
                        onTap: () {
                          addToCart(result.typeid!, '2');
                        },
                        child: Text(
                          "-",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        result.quantity.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          addToCart(result.typeid!, '1');
                        },
                        child: Text(
                          "+",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ],
                  ))
              : Container(
                  margin: EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                      color: AppConstant.appColor,
                      borderRadius: BorderRadius.circular(100)),
                  height: 30,
                  width: 90,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          removeItem(result.cartId);
                        },
                        child: Center(
                          child: Text(
                            "Remove Item",
                            style: TextStyle(color: Colors.white, fontSize: 11),
                          ),
                        ),
                      ),
                    ],
                  )),
        ],
      ),
    );
  }

  Future<BeanApplyPromo?> applyPromo() async {
    progressDialog = ProgressDialog(context);
    progressDialog.show();
    try {
      BeanVerifyOtp user = await Utils.getUser();
      FormData from = FormData.fromMap({
        "kitchen_id": widget.kitchenId,
        "token": "123456789",
        "user_id": user.data!.id,
        "coupon_code": applyPromoController.text.toString()
      });

      BeanApplyPromo? bean = await ApiProvider().applyPromo(from);
      print(bean!.data);
      progressDialog.dismiss(context);
      if (bean.status == true) {
        setState(() {
          showDiscount = true;
          future = getCartDetail();
        });
        return bean;
      } else {
        Utils.showToast(bean.message!);
        setState(() {
          showDiscount = true;
          future = getCartDetail();
        });
      }

      return null;
    } on HttpException catch (exception) {
      progressDialog.dismiss(context);
      setState(() {
        showDiscount = true;
        future = getCartDetail();
      });
      print(exception);
    } catch (exception) {
      progressDialog.dismiss(context);
      setState(() {
        showDiscount = true;
        future = getCartDetail();
      });
      print(exception);
    }
  }

  updateCart(int count, String cartId) async {
    try {
      BeanVerifyOtp user = await Utils.getUser();
      FormData from = FormData.fromMap({
        "user_id": user.data!.id,
        "token": "123456789",
        "cart_id": cartId,
        "quantity": count,
        "quantity_type": type == "minus"
            ? "2"
            : type == "plus"
                ? "1"
                : "0",
      });
      print(from);
      print("quantitytype" + type);
      print("carttt" + cartId);
      print(
        "quantity" + count.toString(),
      );
      print(type);
      BeanUpdateCart? bean = await ApiProvider().updateCart(from);
      print(bean!.data);
      if (bean.status == true) {
        setState(() {
          getCartDetail();
        });
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

  addToCart(String itemid, String quantity_type) async {
    print(itemid + 'papa');
    progressDialog = ProgressDialog(context);
    progressDialog.show();
    try {
      BeanVerifyOtp user = await Utils.getUser();
      FormData from = FormData.fromMap({
        "user_id": user.data!.id,
        "token": "123456789",
        "kitchen_id": widget.kitchenId,
        "type_id": itemid,
        "mealplan": 'trial',
        "quantity": "1",
        "quantity_type": quantity_type
      });

      print("itemId>>" + itemid);
      BeanAddCart? bean = await ApiProvider().addCart(from);
      progressDialog.dismiss(context);
      print(bean!.data);
      if (bean.status == true) {
        setState(() {
          future = getCartDetail();
        });

        progressDialog.dismiss(context);
        Utils.showToast(bean.message!);

        return bean;
      } else {
        Utils.showToast(bean.message!);
      }
      return null;
    } on HttpException catch (exception) {
      print(exception);
      progressDialog.dismiss(context);
    } catch (exception) {
      progressDialog.dismiss(context);
      print(exception);
    }
  }

  removeItem(String? cartId) async {
    var progressDialog = ProgressDialog(context);
    try {
      progressDialog.show();
      BeanVerifyOtp user = await Utils.getUser();
      FormData from = FormData.fromMap({
        "user_id": user.data!.id,
        "token": "123456789",
        "cart_id": cartId,
      });
      print(from);
      print(type);
      RemoveCart? bean = await ApiProvider().removeCart(from);
      progressDialog.dismiss(context);
      print(bean!.data);
      if (bean.status == true) {
        progressDialog.dismiss(context);
        // Navigator.pop(context, true);
        setState(() {
          future = getCartDetail();
        });

        return bean;
      } else {
        Utils.showToast(bean.message!);
      }

      return null;
    } on HttpException catch (exception) {
      print(exception);
      progressDialog.dismiss(context);
    } catch (exception) {
      progressDialog.dismiss(context);
      print(exception);
    }
  }
}
