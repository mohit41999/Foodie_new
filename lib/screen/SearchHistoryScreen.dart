import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_app/model/BeanClearRecentsearch.dart';
import 'package:food_app/model/BeanSearchData.dart';
import 'package:food_app/model/BeanVerifyOtp.dart';
import 'package:food_app/network/ApiProvider.dart';
import 'package:food_app/res.dart';
import 'package:food_app/screen/KitchenDetails/DetailsScreen.dart';
import 'package:food_app/utils/Constents.dart';
import 'package:food_app/utils/HttpException.dart';
import 'package:food_app/utils/Utils.dart';
import 'package:food_app/utils/progress_dialog.dart';
import 'package:food_app/model/GetHomeData.dart' as home;

class SearchHistoryScreen extends StatefulWidget {
  var currenAddress;
  SearchHistoryScreen(this.currenAddress);

  @override
  SearchHistoryScreenState createState() => SearchHistoryScreenState();
}

class SearchHistoryScreenState extends State<SearchHistoryScreen> {
  late ProgressDialog progressDialog;
  bool searchlistVisible = true;
  Future<BeanSearchData?>? future;
  TextEditingController searchcontroller = new TextEditingController();
  String search = "";

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      future = getSearchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog((context));
    // FlutterStatusbarcolor.setStatusBarColor(Colors.transpare/
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                  margin: EdgeInsets.only(left: 10, right: 16, top: 26),
                  decoration: BoxDecoration(
                      color: Color(0xffF6F6F6),
                      borderRadius: BorderRadius.circular(13)),
                  child: Row(
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
                      SizedBox(
                        width: 16,
                      ),
                      Container(
                        width: 250,
                        child: TextField(
                            controller: searchcontroller,
                            decoration: InputDecoration.collapsed(
                                hintText: 'Search for your location or kitchen',
                                hintStyle: TextStyle(
                                    color: Color(0xffA7A8BC), fontSize: 12)),
                            onChanged: (String text) {
                              search = text;
                              if (search.length > 0) {
                                setState(() {
                                  future = getSearchData();
                                });
                              } else if (search.length == 0) {
                                setState(() {
                                  future = getSearchData();
                                });
                              }
                            }),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 16, top: 16),
                        child: Text(
                          "Recently Searched",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        clearSearch();
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 16, top: 16, right: 16),
                        child: Text(
                          "Clear",
                          style: TextStyle(
                              color: AppConstant.appColor, fontSize: 16),
                        ),
                      ),
                    )
                  ],
                ),
                Visibility(
                  visible: searchlistVisible,
                  child: Container(
                      height: 70,
                      child: FutureBuilder<BeanSearchData?>(
                          future:
                              future?.then((value) => value as BeanSearchData?),
                          builder: (context, projectSnap) {
                            print(projectSnap);
                            if (projectSnap.connectionState ==
                                ConnectionState.done) {
                              var result;
                              if (projectSnap.data != null) {
                                result =
                                    projectSnap.data!.data![0].recentSearch;
                                if (result != null) {
                                  print(result.length);
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    physics: BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return getSearchItem(result[index]);
                                    },
                                    itemCount: result.length,
                                  );
                                }
                              }
                            }
                            return Container(
                                child:
                                    Center(child: CircularProgressIndicator()));
                          })),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 16),
                  child: Text(
                    "Trending Near you",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: AppConstant.fontBold),
                  ),
                ),
                Container(
                    height: 70,
                    child: FutureBuilder<BeanSearchData?>(
                        future: future,
                        builder: (context, projectSnap) {
                          print(projectSnap);
                          if (projectSnap.connectionState ==
                              ConnectionState.done) {
                            var result;
                            if (projectSnap.data != null) {
                              result = projectSnap.data!.data![0].trending;
                              if (result != null) {
                                print(result.length);
                                return ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return getTrending(result[index]);
                                  },
                                  itemCount: result.length,
                                );
                              }
                            }
                          }
                          return Container(child: Center(child: Container()));
                        })),
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 16),
                  child: Text(
                    "Kitchen recommendations for you",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: AppConstant.fontBold),
                  ),
                ),
                Container(
                    height: 250,
                    child: FutureBuilder<BeanSearchData?>(
                        future: future?.then((value) => value),
                        builder: (context, projectSnap) {
                          print(projectSnap);
                          if (projectSnap.connectionState ==
                              ConnectionState.done) {
                            var result;
                            if (projectSnap.data != null) {
                              result = projectSnap
                                  .data!.data![0].kitchenRecommandation;
                              if (result != null) {
                                print(result.length);
                                return ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return getRecommended(result[index]);
                                  },
                                  itemCount: result.length,
                                );
                              }
                            }
                          }
                          return Container(child: Center(child: Container()));
                        })),
              ],
            ),
          ),
        ));
  }

  Widget getRecommended(KitchenRecommandation result) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => DetailsScreen(home.Data(
                    kitchenId: result.kitchenId,
                    kitchenname: result.kitchenname,
                    address: result.address,
                    mealtype: result.mealtype,
                    cuisinetype: result.cuisinetype,
                    discount: result.discount,
                    image: result.image,
                    averageRating: result.averageRating,
                    totalReview: result.totalReview,
                    time: result.time,
                    isFavourite: result.isFavourite))));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                height: 16,
              ),
              Container(
                height: 150,
                margin: EdgeInsets.only(top: 16, left: 16, bottom: 16),
                child: Image.network(result.image!, fit: BoxFit.cover),
              ),
              Container(
                margin: EdgeInsets.only(left: 26, top: 26),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50)),
                width: 100,
                height: 30,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        result.averageRating.toString(),
                        style: TextStyle(
                            fontSize: 12, fontFamily: AppConstant.fontBold),
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
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, top: 1),
            child: Text(
              result.kitchenname!,
              style: TextStyle(fontFamily: AppConstant.fontBold, fontSize: 16),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 6,
                  ),
                  Image.asset(
                    Res.ic_time,
                    width: 16,
                    height: 16,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    result.time != null ? result.time! : "",
                    style: TextStyle(
                        fontFamily: AppConstant.fontRegular, fontSize: 12),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Future<BeanSearchData?> getSearchData() async {
    try {
      BeanVerifyOtp user = await Utils.getUser();
      FormData from = FormData.fromMap({
        "userid": user.data!.id,
        "token": "123456789",
        "search_location_or_kitchen": search.toString(),
        "customer_address": widget.currenAddress
      });

      print(
        search.toString(),
      );

      BeanSearchData? bean = await ApiProvider().searchData(from);
      print(bean!.data);

      if (bean.status == true) {
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

  Widget getSearchItem(RecentSearch result) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Color(0xffF3F6FA),
              borderRadius: BorderRadius.circular(13)),
          height: 40,
          width: 100,
          margin: EdgeInsets.only(left: 16, top: 16),
          child: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Image.asset(
                Res.ic_time,
                width: 15,
                height: 15,
                color: Color(0xffA7A8BC),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  result.keyword!,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: AppConstant.fontRegular),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget getTrending(Trending result) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(left: 16, top: 16),
          decoration: BoxDecoration(
              color: Color(0xffF3F6FA),
              borderRadius: BorderRadius.circular(13)),
          height: 40,
          width: 140,
          child: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Image.asset(
                Res.ic_up_arrow,
                width: 15,
                height: 15,
                color: Color(0xffA7A8BC),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  result.kitchenname!,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: AppConstant.fontRegular),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  void clearSearch() async {
    progressDialog = ProgressDialog(context);
    progressDialog.show();
    try {
      BeanVerifyOtp user = await Utils.getUser();
      FormData from =
          FormData.fromMap({"userid": user.data!.id, "token": "123456789"});
      BeanClearRecentSearch? bean = await ApiProvider().clearRecentSearch(from);
      print(bean!.data);
      progressDialog.dismiss(context);
      if (bean.status == true) {
        setState(() {
          future = getSearchData();
        });
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
