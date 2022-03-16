import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_app/model/BeanConfirmLocation.dart';
import 'package:food_app/model/BeanForgotPassword.dart';
import 'package:food_app/model/BeanVerifyOtp.dart';
import 'package:food_app/model/GetAddressList.dart';
import 'package:food_app/network/ApiProvider.dart';
import 'package:food_app/res.dart';
import 'package:food_app/screen/DashboardScreen.dart';
import 'package:food_app/utils/Constents.dart';
import 'package:food_app/utils/HttpException.dart';
import 'package:food_app/utils/PrefManager.dart';
import 'package:food_app/utils/Utils.dart';
import 'package:food_app/utils/progress_dialog.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';

import 'package:location/location.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import 'OrderDispatchedScreen.dart';

class LoginWithEmailScreen extends StatefulWidget {
  @override
  _LoginWithEmailScreenState createState() => _LoginWithEmailScreenState();
}

class _LoginWithEmailScreenState extends State<LoginWithEmailScreen> {
  var email = TextEditingController();
  var password = TextEditingController();
  late ProgressDialog progressDialog;
 late Future <GetAddressList?> future;
  String? userId = "";
  bool isLoggedIn = false;
  bool isApiCalling=false;
   PickResult? selectedPlace;
  LatLng? currentPostion;
  final Geolocator geolocator = Geolocator();
  void onLoginStatusChanged(bool isLoggedIn, {profileData}) {
    setState(() {
      this.isLoggedIn = isLoggedIn;
    });
  }

  @override
  void initState() {
    _getLocation();
    Random random = new Random();
    int randomNumber = random.nextInt(100);
    Future.delayed(Duration.zero, () {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context);
    // FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    // FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
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
                      "",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: AppConstant.fontBold,
                          fontSize: 16),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                  padding: EdgeInsets.only(left: 16, top: 20, right: 16),
                  child: TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                      labelText: "Enter Email ",
                      fillColor: Colors.grey,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.only(left: 16, top: 20, right: 16),
                  child: TextFormField(
                    controller: password,
                    decoration: InputDecoration(
                      labelText: "Enter Password ",
                      fillColor: Colors.grey,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  )),
              Expanded(
                child: SizedBox(
                  height: 1,
                ),
              ),
              InkWell(
                onTap: () {
                  if (email.text.isEmpty) {
                    Utils.showToast("Please Enter Email");
                  } else if (password.text.isEmpty) {
                    Utils.showToast("Please Enter Password");
                  } else {
                    loginWithEmail();
                  }
                },
                child: Container(
                  margin:
                      EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
                  decoration: BoxDecoration(
                      color: AppConstant.appColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                          "CONTINUE",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  height: 50,
                ),
              ),
            ],
          ),
        ));
  }

  loginWithEmail() async {
    progressDialog = ProgressDialog(context);
    progressDialog.show();
    try {
      FormData from = FormData.fromMap({
        "email": email.text.toString(),
        "token": "123456789",
        "password": password.text.toString()
      });
      BeanVerifyOtp? bean = await ApiProvider().loginWithEmail(from);
      print(password.text.toString());
      progressDialog.dismiss(context);
      if (bean!.status == true) {
        PrefManager.putBool(AppConstant.session, true);
        PrefManager.putString(AppConstant.user, jsonEncode(bean));
        Utils.showToast(bean.message!);
        userId = bean.data!.id;
        future =  getAddress(context, userId);
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

  void showDetailsVerifyDialog() {
    showDialog(
        context: context,
        builder: (_) => Center(
                // Aligns the container to center
                child: GestureDetector(
              onTap: () {},
              child: Wrap(
                children: [
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ), // A simplified version of dialog.
                      width: 270.0,
                      height: 260.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 16,
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Image.asset(
                              Res.ic_location,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                                padding: EdgeInsets.only(
                                    left: 16, top: 10, right: 16),
                                child: Text(
                                  "Device location is off",
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      color: Colors.black,
                                      fontFamily: AppConstant.fontBold,
                                      fontSize: 16),
                                )),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Center(
                            child: Text(
                                "Please turn on your device location\nto ensure hassle free experience",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    color: Colors.black,
                                    fontFamily: AppConstant.fontRegular,
                                    fontSize: 13)),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  Res.ic_loca,
                                  width: 16,
                                  height: 16,
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  "Turn on Device Location",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Color(0xffA2A2A2),
                                      fontSize: 13,
                                      decoration: TextDecoration.none,
                                      fontFamily: AppConstant.fontRegular),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Center(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    Res.ic_search,
                                    width: 16,
                                    height: 16,
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Text(
                                    "Select Location Manually",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Color(0xffA2A2A2),
                                        fontSize: 13,
                                        decoration: TextDecoration.none,
                                        fontFamily: AppConstant.fontRegular),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      )),
                ],
              ),
            )));
  }

  void bottomsheetLocation() {
    showModalBottomSheet(
        shape:const RoundedRectangleBorder(
          // <-- for border radius
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
        ),
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return StatefulBuilder(builder: (context, setModelState) {
            return Wrap(
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 16,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 20, left: 10),
                            child: Text(
                              "Search Location",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: AppConstant.fontBold,
                                  fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                        decoration: BoxDecoration(
                            border: Border.all(color: AppConstant.appColor)),
                        height: 50,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration.collapsed(
                                    hintText: '   Search for your location'),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(right: 16),
                                child: Image.asset(
                                  Res.ic_search,
                                  width: 16,
                                  height: 16,
                                ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 16,
                            ),
                            Image.asset(
                              Res.ic_loca,
                              width: 16,
                              height: 16,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Text(
                              "Turn on Device Location",
                              style: TextStyle(
                                  color: Color(0xffA2A2A2),
                                  fontSize: 13,
                                  decoration: TextDecoration.none,
                                  fontFamily: AppConstant.fontRegular),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20, left: 10),
                        child: Text(
                          "Near By Location",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: AppConstant.fontBold,
                              fontSize: 16),
                        ),
                      ),
                    FutureBuilder<GetAddressList?>(
                        future:
                            future,
                        builder: (context, projectSnap) {
                          print(projectSnap.data?.data![0].nearbyKitchen![0].kitchenname);

                            if (projectSnap.data != null) {

                                return ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                                  physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return getAddressList(projectSnap.data!.data![0].nearbyKitchen![index]);
                                //     return Container();
                                  },
                                  itemCount:  projectSnap.data!.data![0].nearbyKitchen?.length,
                                );
                              }


                          return Container(
                              child:
                                  Center(child: CircularProgressIndicator()));
                        }),
                          selectedPlace == null
                              ? Container()
                              : Padding(
                                  child: Text(selectedPlace!.formattedAddress ?? ""),
                                  padding: EdgeInsets.only(left: 16),
                                ),
                          Padding(
                            padding: EdgeInsets.only(top: 20, left: 10),
                            child: Text(
                              "Recent Location",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: AppConstant.fontBold,
                                  fontSize: 16),
                            ),
                          ),
                    FutureBuilder<GetAddressList?>(
                        future:
                            future,
                        builder: (context, projectSnap) {
                          print(projectSnap.data);

                            if (projectSnap.data != null) {

                                return ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                                  physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return getRecent( projectSnap.data!.data![0].recent![index]);

                                  },
                                  itemCount:  projectSnap.data!.data![0].recent?.length,
                                );


                          }
                          return Container(
                              child:
                                  Center(child: CircularProgressIndicator()));
                        }),
                      selectedPlace == null
                          ? Container()
                          : Padding(
                              child: Text(selectedPlace!.formattedAddress ?? ""),
                              padding: EdgeInsets.only(left: 16),
                            ),
                    ],
                  )
                ],
            );
          });
        });
  }

  Future<GetAddressList?> getAddress(
      BuildContext context, String? userId) async {
    progressDialog = ProgressDialog(context);
    progressDialog.show();
    try {
      BeanVerifyOtp user = await Utils.getUser();
      FormData from =
          FormData.fromMap({"userid": userId, "token": "123456789"});

      GetAddressList? bean =
          await ApiProvider().getAddress(from) ;
      print(bean!.data);
      progressDialog.dismiss(context);
      if (bean.status == true) {
        bottomsheetLocation();
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

  getAddressList(NearbyKitchen result) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return PlacePicker(
                    apiKey: "AIzaSyBn9ZKmXc-MN12Fap0nUQotO6RKtYJEh8o",
                    initialPosition: currentPostion!,
                    useCurrentLocation: true,
                    selectInitialPosition: true,
                    //usePlaceDetailSearch: true,
                    onPlacePicked: (result) {
                      selectedPlace = result;
                      confirmLocation(selectedPlace!);
                      setState(() {});
                    },
                    forceSearchOnZoomChanged: true,
                    automaticallyImplyAppBarLeading: false,
                    autocompleteLanguage: "ko",
                    region: 'au',

                    selectedPlaceWidgetBuilder: (_, selectedPlace, state, isSearchBarFocused) {
                      print("state: $state, isSearchBarFocused: $isSearchBarFocused");
                      return isSearchBarFocused
                          ? Container()
                          : FloatingCard(
                              bottomPosition: 0.0, // MediaQuery.of(context) will cause rebuild. See MediaQuery document for the information.
                              leftPosition: 0.0,
                              rightPosition: 0.0,
                              width: 500,
                              borderRadius: BorderRadius.circular(12.0),
                              child: state == SearchingState.Searching
                                  ? const Center(child: CircularProgressIndicator())
                                  : RaisedButton(
                                      child: const Text("Pick Here"),
                                      onPressed: () {
                                        // IMPORTANT: You MUST manage selectedPlace data yourself as using this build will not invoke onPlacePicker as
                                        //            this will override default 'Select here' Button.
                                        print("do something with [selectedPlace] data");
                                        Navigator.of(context).pop();
                                      },
                                    ),
                            );
                    },
                    pinBuilder: (context, state) {
                      if (state == PinState.Idle) {
                        return Icon(Icons.favorite_border);
                      } else {
                        return Icon(Icons.favorite);
                      }
                    },
                  );
                },
              ),
            );
          },
          child: Padding(
              padding: EdgeInsets.only(left: 16, bottom: 6, top: 6),
              child: Text(
                result.kitchenname!,
                style: TextStyle(color: Colors.black, fontSize: 16),
              )),
        ),
        Padding(
            padding: EdgeInsets.only(left: 16, bottom: 6, top: 6),
            child: Text(
              result.deliveryaddress!,
              style: TextStyle(color: Colors.black, fontSize: 16),
            )),
      ],
    );
  }

  getRecent(Recent result) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return PlacePicker(
                    apiKey: "AIzaSyBn9ZKmXc-MN12Fap0nUQotO6RKtYJEh8o",
                    initialPosition: currentPostion!,
                    useCurrentLocation: true,
                    selectInitialPosition: true,

                    //usePlaceDetailSearch: true,
                    onPlacePicked: (result) {
                      selectedPlace = result;
                      confirmLocation(selectedPlace!);

                      setState(() {});
                    },
                    //forceSearchOnZoomChanged: true,
                    //automaticallyImplyAppBarLeading: false,
                    //autocompleteLanguage: "ko",
                    //region: 'au',
                    //selectInitialPosition: true,
                    // selectedPlaceWidgetBuilder: (_, selectedPlace, state, isSearchBarFocused) {
                    //   print("state: $state, isSearchBarFocused: $isSearchBarFocused");
                    //   return isSearchBarFocused
                    //       ? Container()
                    //       : FloatingCard(
                    //           bottomPosition: 0.0, // MediaQuery.of(context) will cause rebuild. See MediaQuery document for the information.
                    //           leftPosition: 0.0,
                    //           rightPosition: 0.0,
                    //           width: 500,
                    //           borderRadius: BorderRadius.circular(12.0),
                    //           child: state == SearchingState.Searching
                    //               ? Center(child: CircularProgressIndicator())
                    //               : RaisedButton(
                    //                   child: Text("Pick Here"),
                    //                   onPressed: () {
                    //                     // IMPORTANT: You MUST manage selectedPlace data yourself as using this build will not invoke onPlacePicker as
                    //                     //            this will override default 'Select here' Button.
                    //                     print("do something with [selectedPlace] data");
                    //                     Navigator.of(context).pop();
                    //                   },
                    //                 ),
                    //         );
                    // },
                    // pinBuilder: (context, state) {
                    //   if (state == PinState.Idle) {
                    //     return Icon(Icons.favorite_border);
                    //   } else {
                    //     return Icon(Icons.favorite);
                    //   }
                    // },
                  );
                },
              ),
            );
          },
          child: Padding(
              padding: EdgeInsets.only(left: 16, bottom: 6, top: 8),
              child: Text(
                result.kitchenname!,
                style: TextStyle(color: Colors.black, fontSize: 16),
              )),
        ),
        Padding(
            padding: EdgeInsets.only(left: 16, bottom: 6, top: 8),
            child: Text(
              result.deliveryaddress!,
              style: TextStyle(color: Colors.black, fontSize: 16),
            )),
      ],
    );
  }

  Future confirmLocation(PickResult selectedPlace) async {
    progressDialog = ProgressDialog(context);
    progressDialog.show();
    try {
      BeanVerifyOtp user = await Utils.getUser();
      FormData data = FormData.fromMap({
        "userid": user.data!.id,
        "token": "123456789",
        "location": selectedPlace.formattedAddress,
        "pincode": "302003",
        "latitude": currentPostion!.latitude,
        "longitude": currentPostion!.longitude
      });
      BeanConfirmLocation? bean = await ApiProvider().confirmlocation(data);
      print("bean>>" + data.toString());
      print(bean!.data);
      progressDialog.dismiss(context);
      if (bean.status == true) {
        Utils.showToast(bean.message!);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OrderDispatchedScreen(
                    currentPostion!.latitude,
                    currentPostion,
                    selectedPlace.formattedAddress)));
      } else {
        Utils.showToast(bean.message!);
      }
    } on HttpException catch (exception) {
      progressDialog.dismiss(context);
    } catch (exception) {
      progressDialog.dismiss(context);
    }
  }

  Future<void> _getLocation() async {
    Location location = new Location();
    LocationData _pos = await location.getLocation();

    currentPostion = LatLng(_pos.latitude!, _pos.longitude!);

    print("sndljdks" + currentPostion.toString());
  }
}
