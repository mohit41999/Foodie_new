import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/model/BeanConfirmLocation.dart';
import 'package:food_app/model/BeanLogin.dart';
import 'package:food_app/model/BeanSignUp.dart';
import 'package:food_app/model/BeanVerifyOtp.dart';
import 'package:food_app/model/GetAddressList.dart';
import 'package:food_app/model/SocialLogin.dart';
import 'package:food_app/network/ApiProvider.dart';
import 'package:food_app/network/EndPoints.dart';
import 'package:food_app/res.dart';
import 'package:food_app/screen/HomeBaseScreen.dart';
import 'package:food_app/screen/LoginWithEmailScreen.dart';
import 'package:food_app/screen/OrderDispatchedScreen.dart';
import 'package:food_app/screen/OtpScreen.dart';
import 'package:food_app/utils/Auth.dart';
import 'package:food_app/utils/Constents.dart';
import 'package:food_app/utils/HttpException.dart';
import 'package:food_app/utils/PrefManager.dart';
import 'package:food_app/utils/Utils.dart';
import 'package:food_app/utils/progress_dialog.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:location/location.dart';
import 'package:uuid/uuid.dart';

class LoginSignUpScreen extends StatefulWidget {
  @override
  _LoginSignUpScreenState createState() => _LoginSignUpScreenState();
}

class _LoginSignUpScreenState extends State<LoginSignUpScreen> {
  final ThemeData lightTheme = ThemeData.light().copyWith(
    // Background color of the FloatingCard
    cardColor: Colors.black,
    buttonTheme: ButtonThemeData(
      // Select here's button color
      buttonColor: AppConstant.appColor,
      textTheme: ButtonTextTheme.primary,
    ),
  );

  Future? future;

  var _isLoggedIn = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoggedIn = false;
  var fb = "";
  var number = TextEditingController();
  late ProgressDialog progressDialog;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final GoogleSignIn googleSignIn = GoogleSignIn(scopes: [
    'https://www.googleapis.com/auth/plus.login',
    'https://www.googleapis.com/auth/user.birthday.read',
    'https://www.googleapis.com/auth/plus.profile.emails.read'
  ]);
  // var facebookLogin = FacebookLogin();
  PickResult? selectedPlace;
  LatLng? currentPostion;
  // final Geolocator geolocator = Geolocator();
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

    print("ddfddf" + randomNumber.toString());

    super.initState();
    Future.delayed(Duration.zero, () {
      future = getAddress(context, randomNumber).then((value) {
        // showDetailsVerifyDialog();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context);
    // FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    // FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
      body: Column(
        children: [
          new Stack(
            children: [
              Container(
                height: 190,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/ic_bg_login.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                    padding: EdgeInsets.only(top: 46, right: 26),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeBaseScreen(
                                      skip: true,
                                    )),
                            (route) => false);
                      },
                      child: Text(
                        "Skip",
                        textAlign: TextAlign.end,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    )),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Stack(
              children: [
                SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Padding(
                            padding:
                                EdgeInsets.only(left: 16, top: 20, right: 16),
                            child: TextFormField(
                              controller: number,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: "Enter Mobile Number ",
                                fillColor: Colors.grey,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 2.0),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                              ),
                            )),
                        InkWell(
                          onTap: () async {
                            if (number.text.isEmpty) {
                              Utils.showToast("Please Enter Number");
                            } else {
                              loginUser();
                              // bool result =
                              //     await apiProvider.login(number.text);

                              // if (result) {
                              //   Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //           builder: (context) =>
                              //               OtpScreen(number.text)));
                              // }
                            }
                          },
                          child: Container(
                            margin:
                                EdgeInsets.only(left: 16, right: 16, top: 56),
                            decoration: BoxDecoration(
                                color: Color(0xffFCC647),
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Text(
                                "SEND OTP",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ),
                            height: 50,
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Center(
                          child: Text(
                            "OR",
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        LoginWithEmailScreen()));
                          },
                          child: Container(
                            margin:
                                EdgeInsets.only(left: 16, right: 16, top: 16),
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    Res.ic_email,
                                    width: 15,
                                    height: 15,
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Text(
                                    "CONTINUE WITH EMAIL",
                                    style: TextStyle(color: Color(0xffFCC647)),
                                  )
                                ],
                              ),
                            ),
                            height: 50,
                          ),
                        ),
                        SizedBox(
                          height: 26,
                        ),
                        Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                child: Image.asset(
                                  Res.ic_google,
                                  width: 40,
                                  height: 40,
                                ),
                                onTap: () {
                                  authUser();
                                },
                              ),
                              SizedBox(
                                width: 26,
                              ),
                              InkWell(
                                onTap: () {
                                  loginWithFB();
                                },
                                child: Image.asset(
                                  Res.ic_facebook,
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Center(
                            child: Padding(
                                padding: EdgeInsets.only(
                                    left: 16, right: 16, top: 16),
                                child: Text(
                                  "By continuing, you are agree to our\nTerms of Service & Privacy Policy",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 13),
                                )))
                      ],
                    )),
              ],
            ),
          ),
        ],
      ),
    );
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
                              bottomsheetLocation();
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

  Future loginUser() async {
    progressDialog = ProgressDialog(context);
    progressDialog.show();
    try {
      FormData data = FormData.fromMap({
        "mobilenumber": number.text.toString(),
        "token": "123456789",
      });
      print(data);
      BeanLogin? bean = await ApiProvider().loginUser(data);
      print(bean!.data);
      progressDialog.dismiss(context);
      if (bean.status == true) {
        PrefManager.putBool(AppConstant.session, true);

        PrefManager.putString(AppConstant.user, jsonEncode(bean));
        Utils.showToast(bean.message!);

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    OtpScreen(number.text, bean.data!.isExistingUser!)));
      } else {
        Utils.showToast(bean.message!);
      }
    } on HttpException catch (exception) {
      progressDialog.dismiss(context);
    } catch (exception) {
      progressDialog.dismiss(context);
    }
  }

  void bottomsheetLocation() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
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
                            future?.then((value) => value as GetAddressList?),
                        builder: (context, projectSnap) {
                          print(projectSnap.data.toString() + 'abcdefgh');
                          if (projectSnap.connectionState ==
                              ConnectionState.done) {
                            var result;
                            if (projectSnap.data != null) {
                              result = projectSnap.data!.data![0].nearbyKitchen;
                              if (result != null) {
                                print(result.length);
                                return ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    // return Container();
                                    return getAddressList(result[index]);
                                  },
                                  itemCount: result.length,
                                );
                              }
                            }
                          }
                          return Container(
                              child:
                                  Center(child: CircularProgressIndicator()));
                        }),
                    // selectedPlace == null
                    //     ? Container()
                    //     : Padding(
                    //         child: Text(selectedPlace!.formattedAddress ?? ""),
                    //         padding: EdgeInsets.only(left: 16),
                    //       ),
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
                            future?.then((value) => value as GetAddressList?),
                        builder: (context, projectSnap) {
                          print(projectSnap);
                          if (projectSnap.connectionState ==
                              ConnectionState.done) {
                            var result;
                            if (projectSnap.data != null) {
                              result = projectSnap.data!.data![0].recent;
                              if (result != null) {
                                print(result.length);
                                return ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Container();
                                    // return getRecent(result[index]);
                                  },
                                  itemCount: result.length,
                                );
                              }
                            }
                          }
                          return Container(
                              child:
                                  Center(child: CircularProgressIndicator()));
                        }),
                    // selectedPlace == null
                    //     ? Container()
                    //     : Padding(
                    //         child: Text(selectedPlace!.formattedAddress ?? ""),
                    //         padding: EdgeInsets.only(left: 16),
                    //       ),
                  ],
                )
              ],
            );
          });
        });
  }

  void authUser() async {
    // progressDialog = ProgressDialog(context, isDismissible: false);
    // progressDialog = ProgressDialog(context);
    // progressDialog.show();
    try {
      await Auth().handleSignIn(context);
      // await Auth().signInWithGoogle().then((user) {
      //   if (user != null) {
      //     socailLogin(user);
      //     /*   _getUserData(user);*/
      //   } else
      //     progressDialog.dismiss(context);
      // });
    } catch (e) {
      progressDialog.dismiss(context);
    }
  }

  void socailLogin(String email, String name) async {
    progressDialog = ProgressDialog(context);
    progressDialog.show();
    try {
      FormData data = FormData.fromMap({
        "token": "123456789",
        "email": email,
        "name": name,
      });
      BeanVerifyOtp? bean = await ApiProvider().socailLogin(data);
      print(bean!.data);
      progressDialog.dismiss(context);
      if (bean.status == true) {
        PrefManager.putBool(AppConstant.session, true);
        PrefManager.putString(AppConstant.user, jsonEncode(bean));
        Utils.showToast(bean.message!);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeBaseScreen()),
            (route) => false);
      } else {
        Utils.showToast(bean.message!);
      }
    } on HttpException catch (exception) {
      progressDialog.dismiss(context);
    } catch (exception) {
      progressDialog.dismiss(context);
    }
  }

  loginWithFB() async {
    _logout();
    // facebookLogin.loginBehavior = FacebookLoginBehavior.webOnly;
    // final result = await facebookLogin.logIn(['email']);
    // switch (result.status) {
    //   case FacebookLoginStatus.loggedIn:
    //     final token = result.accessToken.token;
    //     final graphResponse = await http.get('https://graph.facebook.com/v2.12/me?fields=first_name,last_name,name,email,picture.height(200)&access_token=$token');
    //     final profile = JSON.jsonDecode(graphResponse.body);

    //     socailLoginWithFb(profile);

    //     break;
    //   case FacebookLoginStatus.cancelledByUser:
    //     setState(() => _isLoggedIn = false );
    //     break;
    //   case FacebookLoginStatus.error:
    //     setState(() => _isLoggedIn = false );
    //     break;
    // }
  }

  void _logout() {
    // facebookLogin.logOut();
    setState(() {
      _isLoggedIn = false;
    });
  }

  void socailLoginWithFb(profile) async {
    progressDialog = ProgressDialog(context);
    progressDialog.show();
    try {
      FormData data = FormData.fromMap({
        "token": "123456789",
        "email": profile['email'].toString(),
        "name": profile['name'].toString()
      });
      BeanVerifyOtp? bean = await ApiProvider().socailLogin(data);
      print(bean!.data);
      progressDialog.dismiss(context);
      if (bean.status == true) {
        PrefManager.putBool(AppConstant.session, true);
        PrefManager.putString(AppConstant.user, jsonEncode(bean));
        Utils.showToast(bean.message!);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeBaseScreen()),
            (route) => false);
      } else {
        Utils.showToast(bean.message!);
      }
    } on HttpException catch (exception) {
      progressDialog.dismiss(context);
    } catch (exception) {
      progressDialog.dismiss(context);
    }
  }

  Future _getLocation() async {
    Location location = new Location();
    LocationData _pos = await location.getLocation();

    currentPostion = LatLng(_pos.latitude!, _pos.longitude!);

    print("sndljdks" + currentPostion.toString());
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
        "pincode": currentPostion,
        "latitude": currentPostion!.latitude,
        "longitude": currentPostion!.longitude
      });
      print("data>>" + data.toString());
      BeanConfirmLocation bean = await (ApiProvider().confirmlocation(data)
          as FutureOr<BeanConfirmLocation>);
      print("bean>>" + data.toString());
      print(bean.data);
      progressDialog.dismiss(context);
      if (bean.status == true) {
        PrefManager.putBool(AppConstant.session, true);
        PrefManager.putString(AppConstant.user, jsonEncode(bean));
        Utils.showToast(bean.message!);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OrderDispatchedScreen(
                    // currentPostion!.latitude,
                    // currentPostion!.longitude,
                    // selectedPlace.formattedAddress
                    )));
      } else {
        Utils.showToast(bean.message!);
      }
    } on HttpException catch (exception) {
      progressDialog.dismiss(context);
    } catch (exception) {
      progressDialog.dismiss(context);
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
                    usePlaceDetailSearch: true,
                    onPlacePicked: (result) {
                      selectedPlace = result;

                      confirmLocation(selectedPlace!);

                      setState(() {});
                    },
                    forceSearchOnZoomChanged: true,
                    automaticallyImplyAppBarLeading: false,
                    autocompleteLanguage: "ko",
                    region: 'au',
                    selectedPlaceWidgetBuilder:
                        (_, selectedPlace, state, isSearchBarFocused) {
                      print(
                          "state: $state, isSearchBarFocused: $isSearchBarFocused");
                      return isSearchBarFocused
                          ? Container()
                          : FloatingCard(
                              bottomPosition:
                                  0.0, // MediaQuery.of(context) will cause rebuild. See MediaQuery document for the information.
                              leftPosition: 0.0,
                              rightPosition: 0.0,
                              width: 500,
                              borderRadius: BorderRadius.circular(12.0),
                              child: state == SearchingState.Searching
                                  ? Center(child: CircularProgressIndicator())
                                  : RaisedButton(
                                      child: Text("Pick Here"),
                                      onPressed: () {
                                        // IMPORTANT: You MUST manage selectedPlace data yourself as using this build will not invoke onPlacePicker as
                                        //            this will override default 'Select here' Button.
                                        print(
                                            "do something with [selectedPlace] data");
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

  Future<GetAddressList?> getAddress(
      BuildContext context, int randomNumber) async {
    progressDialog = ProgressDialog(context);
    progressDialog.show();

    try {
      var userBean = await Utils.getUser();

      FormData from =
          FormData.fromMap({"userid": userBean.data!.id, "token": "123456789"});

      GetAddressList? bean = await ApiProvider().getAddress(from);
      print(bean!.data);
      progressDialog.dismiss(context);
      if (bean.status == true) {
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

  // getRecent(Recent result) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       InkWell(
  //         onTap: () {
  //           Navigator.pop(context);
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) {
  //                 return PlacePicker(
  //                   apiKey: "AIzaSyBn9ZKmXc-MN12Fap0nUQotO6RKtYJEh8o",
  //                   initialPosition: currentPostion!,
  //                   useCurrentLocation: true,
  //                   selectInitialPosition: true,

  //                   //usePlaceDetailSearch: true,
  //                   onPlacePicked: (result) {
  //                     selectedPlace = result;

  //                     confirmLocation(selectedPlace!);

  //                     setState(() {});
  //                   },
  //                   //forceSearchOnZoomChanged: true,
  //                   //automaticallyImplyAppBarLeading: false,
  //                   //autocompleteLanguage: "ko",
  //                   //region: 'au',
  //                   //selectInitialPosition: true,
  //                   // selectedPlaceWidgetBuilder: (_, selectedPlace, state, isSearchBarFocused) {
  //                   //   print("state: $state, isSearchBarFocused: $isSearchBarFocused");
  //                   //   return isSearchBarFocused
  //                   //       ? Container()
  //                   //       : FloatingCard(
  //                   //           bottomPosition: 0.0, // MediaQuery.of(context) will cause rebuild. See MediaQuery document for the information.
  //                   //           leftPosition: 0.0,
  //                   //           rightPosition: 0.0,
  //                   //           width: 500,
  //                   //           borderRadius: BorderRadius.circular(12.0),
  //                   //           child: state == SearchingState.Searching
  //                   //               ? Center(child: CircularProgressIndicator())
  //                   //               : RaisedButton(
  //                   //                   child: Text("Pick Here"),
  //                   //                   onPressed: () {
  //                   //                     // IMPORTANT: You MUST manage selectedPlace data yourself as using this build will not invoke onPlacePicker as
  //                   //                     //            this will override default 'Select here' Button.
  //                   //                     print("do something with [selectedPlace] data");
  //                   //                     Navigator.of(context).pop();
  //                   //                   },
  //                   //                 ),
  //                   //         );
  //                   // },
  //                   // pinBuilder: (context, state) {
  //                   //   if (state == PinState.Idle) {
  //                   //     return Icon(Icons.favorite_border);
  //                   //   } else {
  //                   //     return Icon(Icons.favorite);
  //                   //   }
  //                   // },
  //                 );
  //               },
  //             ),
  //           );
  //         },
  //         child: Padding(
  //             padding: EdgeInsets.only(left: 16, bottom: 6, top: 8),
  //             child: Text(
  //               result.kitchenname!,
  //               style: TextStyle(color: Colors.black, fontSize: 16),
  //             )),
  //       ),
  //       Padding(
  //           padding: EdgeInsets.only(left: 16, bottom: 6, top: 8),
  //           child: Text(
  //             result.deliveryaddress!,
  //             style: TextStyle(color: Colors.black, fontSize: 16),
  //           )),
  //     ],
  //   );
  // }
}
