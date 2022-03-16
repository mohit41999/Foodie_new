import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_app/model/BeanBanner.dart';
import 'package:food_app/model/BeanFavKitchen.dart';
import 'package:food_app/model/BeanRemoveKitchen.dart';
import 'package:food_app/model/BeanVerifyOtp.dart';
import 'package:food_app/model/GetCartCount.dart';
import 'package:food_app/model/GetHomeData.dart' as home;
import 'package:food_app/network/ApiProvider.dart';
import 'package:food_app/res.dart';
import 'package:food_app/screen/DetailsScreen.dart';
import 'package:food_app/screen/FilterScreen.dart';
import 'package:food_app/screen/HomeBaseScreen.dart';
import 'package:food_app/screen/SearchHistoryScreen.dart';
import 'package:food_app/utils/Constents.dart';
import 'package:food_app/utils/HttpException.dart';
import 'package:food_app/utils/PrefManager.dart';
import 'package:food_app/utils/Utils.dart';
import 'package:food_app/utils/progress_dialog.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

import 'LoginSignUpScreen.dart';
import 'ShippingScreen.dart';

class DashboardScreen extends StatefulWidget {
  var mealfor;
  var cuisine;
  var type;
  var min;
  var max;
  var mealPlan;

  DashboardScreen(
      this.mealfor, this.cuisine, this.mealPlan, this.type, this.min, this.max);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late BeanVerifyOtp userBean;
  String? name = "";
  String? menu = "";
  var isSelect = 1;
  var currentAddress = "";
  var isSelectFood = 1;
  Future? future;
  bool isLike = false;
  bool isDislike = true;
  List<home.Data>? list = [];
  late ProgressDialog progressDialog;
  String? itemName = "";
  String? delivery_date = "";
  String? delivery_fromtime = "";
  var cartCount = "";
  String? kitchenName = "";
  String? kitchenID = "";
  var isFav = false;
  void getUser() async {
    userBean = await Utils.getUser();
    name = userBean.data!.kitchenname;
    menu = userBean.data!.kitchenname;
    setState(() {});
  }

  @override
  void initState() {
    progressDialog = ProgressDialog(context);
    getUser();
    getUserAddress();
    super.initState();
    Future.delayed(Duration.zero, () {
      getHomeData();
      getBannerData();
      getCartCount(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    // FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    // FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    double h =  MediaQuery.of(context).size.height;
    double w =  MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        drawer: const MyDrawers(),
        key: _scaffoldKey,
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              _scaffoldKey.currentState!.openDrawer();
                            });
                          },
                          child: Container(
                              margin: const EdgeInsets.only(left: 10),
                              height: 50,
                              width: 50,
                              child: Image.asset(Res.ic_boy)),
                        ),
                        Expanded(
                          child: Center(
                            child: Image.asset(
                              Res.ic_logo,
                              width: 100,
                              height: 100,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            var data = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ShippingScreen(
                                        address, kitchenID)));
                            if (data != null) {
                              getCartCount(context);
                            }
                          },
                          child: Container(
                            height: 30,
                            margin: const EdgeInsets.only(left: 10),
                            decoration: const BoxDecoration(
                                color: AppConstant.appColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  bottomLeft: Radius.circular(40),
                                )),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 16),
                                  child: Image.asset(
                                    Res.ic_bascket,
                                    width: 16,
                                    height: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 16, right: 6),
                                  child: Text(
                                    cartCount,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Row(
                        children: [
                          Image.asset(
                            Res.ic_location,
                            width: 16,
                            height: 16,
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Flexible(child: Text(address??'',))
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SearchHistoryScreen(address)));
                          },
                          child: Container(
                            height: 50,
                            margin:
                              const  EdgeInsets.only(left: 16, right: 16, top: 16),
                            decoration: BoxDecoration(
                                color: const Color(0xffF6F6F6),
                                borderRadius: BorderRadius.circular(13)),
                            child: Row(
                              children: [
                            const    SizedBox(
                                  width: 16,
                                ),
                                Image.asset(
                                  Res.ic_search,
                                  width: 16,
                                  height: 16,
                                ),
                              const  SizedBox(
                                  width: 16,
                                ),
                                 const SizedBox(
                                  width: 250,
                                  child: Text(
                                    "search for your location",
                                    style: TextStyle(
                                        color: Color(0xffA7A8BC), fontSize: 12),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          child: GestureDetector(
                            onTap: () {
                              getFilter();
                            },
                            child: Center(
                              child: Padding(
                              padding: const EdgeInsets.only(right: 5, top: 16),
                              child: Image.asset(
                                Res.ic_filter,
                                width: 50,
                                height: 50,
                              )),
                            ),
                          ),
                        )
                      ],
                    ),
                   const SizedBox(
                      height: 16,
                    ),
                    Stack(
                      children: [
                        Image.asset(
                          Res.ic_banner_home,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                         const   SizedBox(
                              height: 65,
                            ),
                            Padding(
                                padding: const EdgeInsets.only(left: 16, top: 16),
                                child: Text(
                                  itemName!.isNotEmpty ? itemName! : "",
                                  style: const TextStyle(
                                      color: Colors.red, fontSize: 16),
                                )),
                            Padding(
                                padding: const EdgeInsets.only(left: 16, top: 6),
                                child: Text(
                                  kitchenName!.isNotEmpty
                                      ? "Kitchen Name: " + kitchenName!
                                      : "",
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 14),
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 16, top: 6),
                                  child: RichText(
                                    text: TextSpan(
                                      text: delivery_fromtime!.isNotEmpty
                                          ? 'Arriving at: '
                                          : "",
                                      style: DefaultTextStyle.of(context).style,
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: delivery_fromtime,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red)),
                                      ],
                                    ),
                                  ),
                                ),
                              const  SizedBox(
                                  width: 16,
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(right: 16),
                                    child: Text(
                                      delivery_date!.isNotEmpty
                                          ? "Date: " + delivery_date!
                                          : "",
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 14),
                                    ))
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  const  Padding(
                      padding: EdgeInsets.only(left: 16, top: 16),
                      child: Text(
                        "What would you like\nto order",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: AppConstant.fontBold),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 16),
                      child: Row(
                        children: [
                         const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  isSelect = 1;
                                  getHomeData();
                                });
                              },
                              child: Card(
                                color: isSelect == 1
                                    ? AppConstant.appColor
                                    : Colors.white,
                                margin: const EdgeInsets.only(
                                    left: 20, right: 20, top: 16),
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100)),
                                child: SizedBox(
                                  height: 110,
                                  width: 70,
                                  child: Column(
                                    children: [
                                     const SizedBox(
                                        height: 6,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                        height: 60,
                                        width: 60,
                                        child: Center(
                                          child: Image.asset(
                                            "assets/images/dennier.png",
                                            width: 40,
                                            height: 40,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "Breakfast",
                                        style: TextStyle(
                                            color: isSelect == 1
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 12,
                                            fontFamily:
                                                AppConstant.fontRegular),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  isSelect = 2;
                                  getHomeData();
                                });
                              },
                              child: Card(
                                color: isSelect == 2
                                    ? AppConstant.appColor
                                    : Colors.white,
                                margin: const EdgeInsets.only(
                                    left: 20, right: 20, top: 16),
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100)),
                                child: SizedBox(
                                  height: 110,
                                  width: 70,
                                  child: Column(
                                    children: [
                                    const  SizedBox(
                                        height: 6,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                        height: 60,
                                        width: 60,
                                        child: Center(
                                          child: Image.asset(
                                           "assets/images/lunch.png",
                                            width: 40,
                                            height: 40,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "Lunch",
                                        style: TextStyle(
                                            color: isSelect == 2
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 12,
                                            fontFamily:
                                                AppConstant.fontRegular),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  isSelect = 3;
                                  getHomeData();
                                });
                              },
                              child: Card(
                                color: isSelect == 3
                                    ? AppConstant.appColor
                                    : Colors.white,
                                margin: const EdgeInsets.only(
                                    left: 20, right: 20, top: 16),
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child:   SizedBox(
                                  height: 110,
                                  width: 70,
                                  child: Column(
                                    children: [
                                    const  SizedBox(
                                        height: 16,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                        height: 60,
                                        width: 60,
                                        child: Center(
                                          child: Image.asset(
                                            "assets/images/breackfast.png",
                                            width: 40,
                                            height: 40,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "Dinner",
                                        style: TextStyle(
                                            color: isSelect == 3
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 12,
                                            fontFamily:
                                                AppConstant.fontRegular),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 10, top: 16),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  isSelectFood = 1;
                                  getHomeData();
                                });
                              },
                              child: Card(
                                color: isSelectFood == 1
                                    ? const Color(0xff7EDABF)
                                    : Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Container(
                                    margin: EdgeInsets.only(left: 10),
                                    height: 50,
                                    width: 100,
                                    child: Row(
                                      children: [
                                       const SizedBox(
                                          width: 16,
                                        ),
                                        Image.asset(
                                          Res.ic_veg,
                                          width: 16,
                                          height: 16,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 16),
                                          child: Text(
                                            "Veg",
                                            style: TextStyle(
                                                color: isSelectFood == 1
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontSize: 11),
                                          ),
                                        )
                                      ],
                                    )),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  isSelectFood = 2;
                                  getHomeData();
                                });
                              },
                              child: Card(
                                color: isSelectFood == 2
                                    ? Color(0xff7EDABF)
                                    : Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Container(
                                    margin: EdgeInsets.only(left: 10),
                                    height: 50,
                                    width: 150,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 6,
                                        ),
                                        Image.asset(
                                          Res.ic_chiken,
                                          width: 16,
                                          height: 16,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 6),
                                          child: Text(
                                            "Non-veg",
                                            style: TextStyle(
                                                color: isSelectFood == 2
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontSize: 11),
                                          ),
                                        )
                                      ],
                                    )),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  isSelectFood = 3;
                                  getHomeData();
                                });
                              },
                              child: Card(
                                color: isSelectFood == 3
                                    ? Color(0xff7EDABF)
                                    : Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Container(
                                    margin: EdgeInsets.only(left: 10),
                                    height: 50,
                                    width: 100,
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          Res.ic_vegnonveg,
                                          width: 16,
                                          height: 16,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 6),
                                          child: Text(
                                            "Veg/Non-veg",
                                            style: TextStyle(
                                                color: isSelectFood == 3
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontSize: 11),
                                          ),
                                        )
                                      ],
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    list!.isEmpty
                        ? Container(
                            child: Center(
                              child: Padding(
                                  padding: EdgeInsets.only(top: 16),
                                  child: Text("No Item Available")),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return getFoods(list![index], index);
                            },
                            itemCount: list!.length,
                          )
                    /*FutureBuilder<home.BeanHomeData>(
                        future: future,
                        builder: (context, projectSnap) {
                          print(projectSnap);
                          if (projectSnap.connectionState == ConnectionState.done) {
                            var result;
                            if (projectSnap.data != null) {
                              result = projectSnap.data.data;
                              if (result != null) {
                                print(result.length);
                                return
                              }
                            }
                          }
                          return Container(
                              child: Center(
                                child: Text(
                                  "No Food Available",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontFamily:
                                      AppConstant.fontBold),
                                ),
                              )
                          );
                        }),*/
                    /*    InkWell(
                      onTap: (){
                     */ /*   Navigator.pushNamed(context, '/detail');*/ /*
                        },
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return getFoods();
                        },
                        itemCount: 3,
                      ),
                    )*/
                  ],
                ),
                physics: BouncingScrollPhysics(),
              ),
            ],
          ),
        ));
  }

  Widget getFoods(home.Data result, int index) {
    double h  =  MediaQuery.of(context).size.height;
    double w  =  MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () async {
          bool isLogined = await PrefManager.getBool(AppConstant.session);
          if (isLogined) {
            var data = await Navigator.push(context,
                MaterialPageRoute(builder: (_) => DetailsScreen(result)));
            if (data != null) {
              getCartCount(context);
              getHomeData();
            }
          } else {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginSignUpScreen()),
                ModalRoute.withName("/loginSignUp"));
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [

                Container(
                  margin: EdgeInsets.only(top: 15),
                  height: h*0.5,
                  width:w,
                  child: Image.network(result.image!, fit: BoxFit.cover),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 16, top: 36),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50)),
                        width: 100,
                        height: 40,
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                result.averageRating!,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: AppConstant.fontBold),
                              ),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            RatingBarIndicator(
                              rating: 1,
                              itemCount: 1,
                              itemSize: 15.0,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 6),
                              child: Text(
                                result.totalReview!,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: AppConstant.fontBold,
                                    color: Color(0xffA7A8BC)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    result.isFavourite == "0"
                        ? InkWell(
                            onTap: () async {
                              addFavKitchen(result.kitchenId!);
                            },
                            child: Padding(
                                padding: EdgeInsets.only(top: 16, right: 6),
                                child: Container(
                                  alignment: Alignment.bottomRight,
                                  height: 60,
                                  width: 60,
                                  child: Image.asset(Res.ic_like,
                                      fit: BoxFit.cover),
                                )))
                        : InkWell(
                            onTap: () async {
                              removeFav(result.kitchenId!);
                            },
                            child: Padding(
                                padding: EdgeInsets.only(top: 16, right: 16),
                                child: Container(
                                  alignment: Alignment.bottomRight,
                                  height: 20,
                                  width: 20,
                                  child: Image.asset(Res.ic_hearfille,
                                      fit: BoxFit.cover),
                                ))),
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, top: 8),
              child: Text(
                result.kitchenname!,
                style:
                    TextStyle(fontFamily: AppConstant.fontBold, fontSize: 18),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Container(
                //   height: 30,
                //   margin: EdgeInsets.only(left: 16, top: 6),
                //   decoration: BoxDecoration(
                //       color: Color(0xffEEEEEE),
                //       borderRadius: BorderRadius.circular(50)),
                //   child: Center(
                //     child: Padding(
                //       padding: EdgeInsets.all(8),
                //       child: Text(
                //         result.kitchenname,
                //         style: TextStyle(fontSize: 12, color: Color(0xffA7A8BC)),
                //       ),
                //     ),
                //   ),
                // ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 16,
                    ),
                    Image.asset(
                      Res.ic_time,
                      width: 16,
                      height: 16,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: Text(
                        result.time!,
                        style: TextStyle(
                            fontFamily: AppConstant.fontRegular, fontSize: 12),
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<home.BeanHomeData?> getHomeData() async {
    progressDialog = ProgressDialog(context);
    progressDialog.show();
    try {
      BeanVerifyOtp user = await Utils.getUser();
      FormData from = FormData.fromMap({
        "token": "123456789",
        "customer_id": "193",
        "search_location_or_kitchen": "",
        "mealfor": widget.mealfor == 1
            ? "0"
            : widget.mealfor == 2
                ? "1"
                : widget.mealfor == 3
                    ? "2"
                    : "",
        "cuisinetype": widget.cuisine == 1
            ? "0"
            : widget.cuisine == 2
                ? "1"
                : widget.cuisine == 3
                    ? "2"
                    : "",
        "mealtype": "1",
        "mealplan": widget.mealPlan == 1
            ? "0"
            : widget.mealPlan == 2
                ? "1"
                : widget.mealPlan == 3
                    ? "2"
                    : "",
        "min_price": "",
        "max_price": "",
        "rating": "0",
        "customer_address": address
      });
      print("param" + from.toString());
      print("id>>" + user.data!.id!);
      home.BeanHomeData? bean = await ApiProvider().getHomeData(from)
          ;
      print(bean!.data);
      progressDialog.dismiss(context);
      if (bean.status == true) {
        kitchenID = bean.data![0].kitchenId;

        setState(() {
          if (list != null) {
            list = bean.data;
          } else {}
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
      progressDialog.dismiss( context);
      print(exception);
    }
  }

  addFavKitchen(String kitchenId) async {
    progressDialog = ProgressDialog(context);
    progressDialog.show();
    try {
      BeanVerifyOtp user = await Utils.getUser();
      FormData from = FormData.fromMap({
        "userid": user.data!.id,
        "token": "123456789",
        "kitchenid": kitchenId
      });
      BeanFavKitchen? bean = await ApiProvider().favKitchen(from);
      print("kitchenId" + kitchenId);
      print("userid" + user.data!.id!);
      if (bean!.status == true) {
        progressDialog.dismiss(context);
        setState(() {
          Utils.showToast(bean.message!);
        });
        getHomeData();
      } else {
        Utils.showToast(bean.message!);
      }
    } on HttpException catch (exception) {
      print(exception);
    } catch (exception) {
      progressDialog.dismiss(context);
      print(exception);
    }
  }

  removeFav(String kitchenId) async {
    progressDialog = ProgressDialog(context);
    progressDialog.show();
    try {
      BeanVerifyOtp user = await Utils.getUser();
      FormData from = FormData.fromMap({
        "userid": user.data!.id,
        "token": "123456789",
        "kitchenid": kitchenId
      });
      BeanRemoveKitchen? bean = await ApiProvider().removeKitchen(from);
      print(bean!.data);
      print("kid" + kitchenId);
      progressDialog.dismiss(context);
      if (bean.status == true) {
        setState(() {
          Utils.showToast(bean.message!);
        });
        getHomeData();
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

  getFilter() async {
    var data = await Navigator.push(
        context, MaterialPageRoute(builder: (_) => FilterScreen()));
    if (data != null) {
      getFilterData();
    }
  }

  getFilterData() async {
    progressDialog = ProgressDialog(context);
    progressDialog.show();
    try {
      BeanVerifyOtp user = await Utils.getUser();
      FormData from = FormData.fromMap({
        "token": "123456789",
        "customer_id": user.data!.id,
        "search_location_or_kitchen": "",
        "mealfor": widget.mealfor == 1
            ? "0"
            : widget.mealfor == 2
                ? "1"
                : widget.mealfor == 3
                    ? "2"
                    : "1",
        "cuisinetype": widget.cuisine == 1
            ? "0"
            : widget.cuisine == 2
                ? "1"
                : widget.cuisine == 3
                    ? "2"
                    : "1",
        "mealtype": "1",
        "mealplan": widget.mealPlan == 1
            ? "0"
            : widget.mealPlan == 2
                ? "1"
                : widget.mealPlan == 3
                    ? "2"
                    : "1",
        "min_price": 0.0,
        "max_price": 100.0,
        "rating": "0",
        "customer_address": address
      });
      print("param" + from.toString());
      print("c" + address!);
      home.BeanHomeData? bean = await ApiProvider().getHomeData(from);
      print(bean!.data);
      progressDialog.dismiss(context);
      if (bean.status == true) {
        setState(() {
          if (list != null) {
            list = bean.data;
          } else {}
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

String? address;
  Future<void> GetAddressFromLatLong(Position position) async {
    address="";
    List<Placemark> placemarks =
    await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    address =
    '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

  }

getCurrentLocation()async{
  LocationPermission permission;
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {

      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.

    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }
  Position position = await Geolocator.getCurrentPosition();
  GetAddressFromLatLong(position);

}
  getUserAddress() async {
    print("get USer address api call");
    //call this async method from whereever you need

    LocationData? myLocation;
    String error;

    try {
      await getCurrentLocation();
      setState(() {
      });
      //myLocation = await location.getLocation();
    } on PlatformException catch (e) {
      print(e);
      if (e.code == 'PERMISSION_DENIED') {
        error = 'please grant permission';
        print(error);
      }
      if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error = 'permission denied- please enable it from app settings';
        print(error);
      }
      //myLocation = null;
    }
    var currentLocation = myLocation;
    // final coordinates =
    //     new Coordinates(myLocation?.latitude, myLocation?.longitude);


  }

  Future<BeanBanner?> getBannerData() async {
    try {
      BeanVerifyOtp user = await Utils.getUser();
      FormData from = FormData.fromMap({
        "user_id": user.data!.id,
        "token": "123456789",
      });
      print("param" + user.data!.id.toString());
      BeanBanner? bean = await ApiProvider().bannerData(from);
      print(bean!.data);
      if (bean.status == true) {
        setState(() {
          itemName = bean.data!.meal!.itemName;
          delivery_date = bean.data!.meal!.deliveryDate;
          delivery_fromtime = bean.data!.meal!.deliveryFromtime;
          kitchenName = bean.data!.kitchenName;
        });
        return bean;
      } else {
        Utils.showToast(bean.message!);
      }


    } on HttpException catch (exception) {
      print(exception);
    } catch (exception) {
      print(exception);
    }
  }

  getCartCount(BuildContext context) async {
    progressDialog = ProgressDialog(context);
    progressDialog.show();
    try {
      BeanVerifyOtp user = await Utils.getUser();
      FormData from = FormData.fromMap({
        "user_id": user.data!.id,
        "token": "123456789",
      });
      print(from);
      GetCartCount? bean = await ApiProvider().getCartCount(from);
      print(bean!.data);
      progressDialog.dismiss(context);
      if (bean.status == true) {
        cartCount = bean.data!.cartCount.toString();
        setState(() {});
        return bean;
      } else {
        setState(() {
          cartCount = "";
        });
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
