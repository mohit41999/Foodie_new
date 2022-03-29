import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_app/model/BaseBean.dart';
import 'package:food_app/model/BeanCustomizedPackage.dart' as custom;
import 'package:food_app/model/BeanPackageDetail.dart';
import 'package:food_app/model/BeanVerifyOtp.dart';
import 'package:food_app/network/ApiProvider.dart';
import 'package:food_app/res.dart';
import 'package:food_app/screen/AddPackageScreen.dart';
import 'package:food_app/screen/SelectDateTime.dart';
import 'package:food_app/utils/Constents.dart';
import 'package:food_app/utils/Utils.dart';
import 'package:food_app/utils/progress_dialog.dart';

class PackageDetailScreen extends StatefulWidget {
  var itemId;
  var itemName;
  var bookType;

  PackageDetailScreen(this.itemId, this.itemName, this.bookType);

  @override
  State<StatefulWidget> createState() => PackageDetailScreenState();
}

class PackageDetailScreenState extends State<PackageDetailScreen> {
  late ProgressDialog progressDialog;

  List<PackageDetail>? packageDetail;

  String? mealFor = "";
  String? packageId = "";
  String? kitchenId = "";
  String? cusineType = "";
  String? mealType = "";

  @override
  void initState() {
    super.initState();
    packageId = widget.itemId;
    Future.delayed(Duration.zero, () {
      packageDetailApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context);
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
                    widget.itemName,
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
                    mealFor!.isEmpty ? "" : mealFor!,
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
                    mealType!.isEmpty ? "" : mealType!,
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text(
                    cusineType!.isEmpty ? "" : cusineType!,
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
            packageDetail == null
                ? Center(
                    child: Text("No Package Available"),
                  )
                : Expanded(
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
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SelectDateTime(
                            packageId, kitchenId, widget.bookType)));
              },
              child: Container(
                height: 50,
                margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(13)),
                child: Center(
                  child: Text(
                    "Select Date & Time",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: AppConstant.fontRegular),
                  ),
                ),
              ),
            )
          ],
        )));
  }

  Future<BeanPackageDetail?> packageDetailApi() async {
    try {
      progressDialog.show();
      print(widget.bookType.toString() + 'klsdklsak');
      BeanVerifyOtp user = await Utils.getUser();

      print(user.data!.id.toString() + 'klsdklsak');
      print(packageId.toString() + 'asdsds');
      FormData from = FormData.fromMap({
        "token": "123456789",
        "user_id": user.data!.id,
        "book_type": widget.bookType,
        "package_id": packageId,
      });
      BeanPackageDetail? bean = await ApiProvider().packageDetail(from);
      print(bean!.data);
      progressDialog.dismiss(context);
      if (bean.status == true) {
        mealFor = bean.data!.mealfor;
        kitchenId = bean.data!.kitchenId;
        packageId = bean.data!.packageId;
        cusineType = bean.data!.cuisinetype;
        mealType = bean.data!.mealtype;
        // if(bean.data.packageDetail!=null){
        packageDetail = bean.data!.packageDetail;
        // }

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

  void addCustomizePackageItemApi(
      String menuItems, String? weeklyPackageId) async {
    try {
      progressDialog = ProgressDialog(context);
      progressDialog.show();
      BeanVerifyOtp user = await Utils.getUser();
      FormData from = FormData.fromMap({
        "token": "123456789",
        "user_id": user.data!.id,
        "package_id": packageId,
        "weekly_package_id": weeklyPackageId,
        /*"menu_id":"124",
        "qty":"5",Ca
        "itemprice":"30"*/
        "menu_items": menuItems
      });
      BaseBean? bean = await ApiProvider().addCustomizePackageItem(from);
      print(bean!.message);
      progressDialog.dismiss(context);

      Utils.showToast(bean.message!);
      if (bean.status!) {
        Navigator.pop(context);
      }
    } on HttpException catch (exception) {
      progressDialog.dismiss(context);
      print(exception);
    } catch (exception) {
      progressDialog.dismiss(context);
      print(exception);
    }
  }

  Widget getPackage(PackageDetail packageDetail) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16, top: 8),
              child: Text(
                packageDetail.daysName != null ? packageDetail.daysName! : "",
                style: TextStyle(color: AppConstant.appColor, fontSize: 14),
              ),
            ),
            InkWell(
              onTap: () {
                menuitembottommodel(context, packageDetail.menuItem,
                        packageDetail.weeklyPackageId)
                    .then((value) {
                  setState(() {});
                });
                // customizedApi(packageDetail.weeklyPackageId);
              },
              child: Padding(
                padding: EdgeInsets.only(right: 16, top: 8),
                child: Text(
                  "Customizable",
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
              ),
            ),
          ],
        ),
        Container(
          height: 30,
          padding: EdgeInsets.only(left: 10),
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              List<String> data = [];
              packageDetail.menuItem[index].menuitems.forEach((element) {
                data.add(
                    element.itemQty.toString() + ' ' + element.itemName + '  ');
              });

              return Container(
                height: 30,
                child: ListView.builder(
                  itemBuilder: (BuildContext, index) {
                    return Text(data[index]);
                  },
                  shrinkWrap: true,
                  itemCount: data.length,
                  scrollDirection: Axis.horizontal,
                ),
              );
            },
            itemCount: packageDetail.menuItem.length,
          ),
        )
        // Padding(
        //   padding: EdgeInsets.only(left: 16, top: 8),
        //   child: Text(
        //     packageDetail.itemName != null ? packageDetail.itemName! : "",
        //     style: TextStyle(color: Colors.black, fontSize: 14),
        //   ),
        // ),
      ],
    );
  }

  // void addCoustumizeSheet(
  //     BuildContext context, List<custom.Data>? data, String weeklyPackageId) {
  //   showModalBottomSheet(
  //       shape: RoundedRectangleBorder(
  //         // <-- for border radius
  //         borderRadius: BorderRadius.only(
  //           topLeft: Radius.circular(15.0),
  //           topRight: Radius.circular(15.0),
  //         ),
  //       ),
  //       context: context,
  //       builder: (context) {
  //         return StatefulBuilder(builder: (context, setModelState) {
  //           return Container(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Padding(
  //                       padding: EdgeInsets.all(10),
  //                       child: Text(
  //                         "Select From Below Option",
  //                         style: TextStyle(
  //                             color: Colors.black,
  //                             fontFamily: AppConstant.fontBold,
  //                             fontSize: 18),
  //                       ),
  //                     ),
  //                     InkWell(
  //                       onTap: () {
  //                         Navigator.pop(context);
  //                       },
  //                       child: Padding(
  //                           padding: EdgeInsets.only(right: 16),
  //                           child: Image.asset(
  //                             Res.ic_cross,
  //                             width: 16,
  //                             height: 16,
  //                           )),
  //                     )
  //                   ],
  //                 ),
  //                 SizedBox(
  //                   height: 10,
  //                 ),
  //                 data!.isEmpty
  //                     ? Center(
  //                         child: Text("No  Detail"),
  //                       )
  //                     : Expanded(
  //                         child: ListView.builder(
  //                           shrinkWrap: true,
  //                           scrollDirection: Axis.vertical,
  //                           physics: BouncingScrollPhysics(),
  //                           itemBuilder: (context, index) {
  //                             return getCategory(data[index], setModelState);
  //                           },
  //                           itemCount: data.length,
  //                         ),
  //                       ),
  //                 GestureDetector(
  //                   onTap: () {
  //                     var encodedString = encodeMenuItemsToJsonString(data);
  //                     if (encodedString.isNotEmpty) {
  //                       print(encodedString);
  //                       addCustomizePackageItemApi(
  //                           encodedString, weeklyPackageId);
  //                     } else
  //                       Utils.showToast("Select menu to customize");
  //                   },
  //                   child: Container(
  //                     height: 50,
  //                     margin: EdgeInsets.only(
  //                         bottom: 6, right: 16, left: 16, top: 26),
  //                     decoration: BoxDecoration(
  //                         color: Colors.black,
  //                         borderRadius: BorderRadius.circular(10)),
  //                     child: Center(
  //                       child: Text(
  //                         "Done",
  //                         style: TextStyle(color: Colors.white, fontSize: 16),
  //                       ),
  //                     ),
  //                   ),
  //                 )
  //               ],
  //             ),
  //           );
  //         });
  //       });
  // }

  Future menuitembottommodel(BuildContext context, List<MenuItem> data,
      String? WeeklyPackageId) async {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          // <-- for border radius
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
        ),
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setModelState) {
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Select From Below Option",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: AppConstant.fontBold,
                              fontSize: 18),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: Image.asset(
                              Res.ic_cross,
                              width: 16,
                              height: 16,
                            )),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  data.isEmpty
                      ? Center(
                          child: Text("No  Detail"),
                        )
                      : Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return getCategory(data[index], setModelState);
                            },
                            itemCount: data.length,
                          ),
                        ),
                  GestureDetector(
                    onTap: () {
                      var encodedString = encodeMenuItemsToJsonString(data);
                      if (encodedString.isNotEmpty) {
                        print(encodedString);
                        addCustomizePackageItemApi(
                            encodedString, WeeklyPackageId);
                      } else
                        Utils.showToast("Select menu to customize");
                    },
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.only(
                          bottom: 6, right: 16, left: 16, top: 26),
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          "Done",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          });
        }).then((value) {
      setState(() {});
    });
  }

  // customizedApi(String? weeklyPackageId) async {
  //   try {
  //     progressDialog = ProgressDialog(context);
  //     progressDialog.show();
  //     BeanVerifyOtp user = await Utils.getUser();
  //     FormData from = FormData.fromMap({
  //       "token": "123456789",
  //       "user_id": user.data!.id,
  //       // "user_id": "15",
  //       "weekly_package_id": weeklyPackageId,
  //       "package_id": packageId,
  //     });
  //     custom.BeanCustomizedPackage? bean =
  //         await ApiProvider().customPackage(from);
  //     print(bean!.data);
  //     progressDialog.dismiss(context);
  //     if (bean.status == true) {
  //       addCoustumizeSheet(context, bean.data, weeklyPackageId!);
  //       setState(() {});
  //       return bean;
  //     } else {
  //       Utils.showToast(bean.message!);
  //     }
  //
  //     return null;
  //   } on HttpException catch (exception) {
  //     progressDialog.dismiss(context);
  //     print(exception);
  //   } catch (exception) {
  //     progressDialog.dismiss(context);
  //     print(exception);
  //   }
  // }

  String encodeMenuItemsToJsonString(List<MenuItem> data) {
    List<Map<String, String?>> listOfMenuItems = [];
    data.forEach((element) {
      element.menuitems.forEach((menu) {
        if (menu.isChecked!) {
          var map = {
            "menu_id": menu.itemId,
            "itemname": menu.itemName,
            "itemprice": menu.itemPrice,
            "quantity": menu.qtytoincrease.toString(),
          };
          listOfMenuItems.add(map);
        }
      });
    });
    return listOfMenuItems.isNotEmpty ? json.encode(listOfMenuItems) : "";
  }
}

getPackageitems(Menuitem data, setModelState) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Checkbox(
            activeColor: Color(0xff7EDABF),
            onChanged: (value) {
              setModelState(() {
                data.isChecked = value;
                if (value!) {
                  data.qtytoincrease = 1;
                  data.itemQty++;
                } else {
                  data.itemQty = data.itemQty - data.qtytoincrease;
                  data.qtytoincrease = 0;
                }
              });
            },
            value: data.isChecked),
        Padding(
          padding: EdgeInsets.only(left: 16),
          child: Text(data.itemName),
        ),
        Expanded(
          child: SizedBox(
            width: 1,
          ),
        ),
        data.qtytoincrease > 0
            ? Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Container(
                  height: 35,
                  width: 80,
                  decoration: BoxDecoration(
                    color: AppConstant.appColor,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          setModelState(() {
                            if (data.qtytoincrease > 1) {
                              data.qtytoincrease -= 1;
                              data.itemQty--;
                            } else {
                              setModelState(() {
                                data.isChecked = false;
                                data.itemQty =
                                    data.itemQty - data.qtytoincrease;
                                data.qtytoincrease = 0;

                                print(data.isChecked.toString());
                              });
                            }
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 35,
                          width: 20,
                          child: Text(
                            "-",
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(data.qtytoincrease.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          setModelState(() {
                            data.qtytoincrease += 1;
                            data.itemQty++;
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 35,
                          width: 20,
                          child: Text("+",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20)),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : SizedBox(),
        Padding(
          padding: EdgeInsets.only(right: 16),
          child: Text(AppConstant.rupee),
        ),
      ],
    ),
  );

  //   Row(
  //   children: [
  //     Checkbox(
  //       activeColor: Color(0xff7EDABF),
  //       onChanged: (value) {
  //         setModelState(() {
  //           menuitem.isChecked = value;
  //           if (!value!) {
  //             menuitem.itemQty = 0;
  //           } else {
  //             menuitem.itemQty = 1;
  //           }
  //         });
  //       },
  //       value: menuitem.isChecked == null ? false : menuitem.isChecked,
  //     ),
  //     Padding(
  //       padding: EdgeInsets.only(left: 16),
  //       child: Text(menuitem.itemName),
  //     ),
  //     Expanded(
  //       child: SizedBox(
  //         width: 1,
  //       ),
  //     ),
  //     menuitem.itemQty > 0
  //         ? Padding(
  //             padding: EdgeInsets.only(left: 16, right: 16),
  //             child: Container(
  //               height: 35,
  //               width: 80,
  //               decoration: BoxDecoration(
  //                 color: AppConstant.appColor,
  //                 borderRadius: BorderRadius.all(Radius.circular(30)),
  //               ),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   InkWell(
  //                     onTap: () {
  //                       setModelState(() {
  //                         if (menuitem.itemQty > 1) {
  //                           menuitem.itemQty -= 1;
  //                         }
  //                       });
  //                     },
  //                     child: Container(
  //                       alignment: Alignment.center,
  //                       height: 35,
  //                       width: 20,
  //                       child: Text(
  //                         "-",
  //                         style: TextStyle(color: Colors.white, fontSize: 25),
  //                       ),
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     width: 10,
  //                   ),
  //                   Text(menuitem.itemQty.toString(),
  //                       style: TextStyle(color: Colors.white, fontSize: 20)),
  //                   SizedBox(
  //                     width: 10,
  //                   ),
  //                   InkWell(
  //                     onTap: () {
  //                       setModelState(() {
  //                         menuitem.itemQty += 1;
  //                       });
  //                     },
  //                     child: Container(
  //                       alignment: Alignment.center,
  //                       height: 35,
  //                       width: 20,
  //                       child: Text("+",
  //                           style:
  //                               TextStyle(color: Colors.white, fontSize: 20)),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           )
  //         : SizedBox(),
  //     Padding(
  //       padding: EdgeInsets.only(right: 16),
  //       child: Text(AppConstant.rupee + menuitem.itemprice!),
  //     ),
  //   ],
  // );
}

getCategory(MenuItem data, setModelState) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.only(left: 16),
        child: Text(
          data.category,
          style: TextStyle(fontSize: 15, fontFamily: AppConstant.fontBold),
        ),
      ),
      ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return getPackageitems(data.menuitems[index], setModelState);
        },
        itemCount: data.menuitems.length,
      )
    ],
  );
}
