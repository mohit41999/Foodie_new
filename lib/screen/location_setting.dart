import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:food_app/model/BeanConfirmLocation.dart';
import 'package:food_app/model/BeanVerifyOtp.dart';
import 'package:food_app/model/GetAddressList.dart';
import 'package:food_app/network/ApiProvider.dart';
import 'package:food_app/screen/HomeBaseScreen.dart';
import 'package:food_app/screen/OrderDispatchedScreen.dart';
import 'package:food_app/screen/set_location_map.dart';
import 'package:food_app/utils/Constents.dart';
import 'package:food_app/utils/PrefManager.dart';
import 'package:food_app/utils/Utils.dart';
import 'package:food_app/utils/progress_dialog.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:location/location.dart';

import '../utils/HttpException.dart';

class LocationSettingScreen extends StatefulWidget {
  const LocationSettingScreen({Key? key}) : super(key: key);

  @override
  State<LocationSettingScreen> createState() => _LocationSettingScreenState();
}

class _LocationSettingScreenState extends State<LocationSettingScreen> {
  List<GetAddressListData> addressList = [];
  PickResult? selectedPlace;
  LatLng? currentPostion;
  bool loading = true;
  bool error = false;
  late ProgressDialog progressDialog;
  TextEditingController _controller1 = TextEditingController(text: '');

  @override
  void initState() {
    progressDialog = ProgressDialog(context);
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      _getLocation();
      getAddress();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (addressList.length == 0) {
          Utils.showToast('Add Address');
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 50.0),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return PlacePicker(
                      apiKey: 'AIzaSyCBZ1E4AGu6xP_VV4GWr_qjnOte9sFmh0A',
                      hintText: "Find a place ...",
                      searchingText: "Please wait ...",
                      selectText: "Select place",
                      outsideOfPickAreaText: "Place not in area",
                      initialPosition: LatLng(
                          currentPostion!.latitude, currentPostion!.longitude),
                      useCurrentLocation: true,
                      selectInitialPosition: true,
                      usePinPointingSearch: true,
                      usePlaceDetailSearch: true,
                      zoomGesturesEnabled: true,
                      zoomControlsEnabled: true,
                      onPlacePicked: (PickResult result) {
                        setState(() {
                          selectedPlace = result;
                          print(selectedPlace!.geometry!.location.lat);
                          Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SetLocationScreen(
                                          pickResult: selectedPlace!)))
                              .then((value) {
                            getAddress();
                          });
                        });
                      },
                      onMapTypeChanged: (MapType mapType) {
                        print("Map type changed to ${mapType.toString()}");
                      },
                    );
                  },
                ),
              );
            },
            child: Icon(Icons.add),
            backgroundColor: AppConstant.appColor,
          ),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Manage Address'),
          backgroundColor: AppConstant.appColor,
        ),
        body: (loading)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : (error)
                ? Center(
                    child: Text('Error ... Try Again Later'),
                  )
                : (addressList.length == 0)
                    ? Center(
                        child: Text(
                            'No Address Added Yet... Please add an address to continue'),
                      )
                    : Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                                itemCount: addressList.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      ListTile(
                                          contentPadding: EdgeInsets.all(4),
                                          trailing: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) {
                                                          return PlacePicker(
                                                            apiKey:
                                                                'AIzaSyCBZ1E4AGu6xP_VV4GWr_qjnOte9sFmh0A',
                                                            hintText:
                                                                "Find a place ...",
                                                            searchingText:
                                                                "Please wait ...",
                                                            selectText:
                                                                "Select place",
                                                            outsideOfPickAreaText:
                                                                "Place not in area",
                                                            initialPosition: LatLng(
                                                                double.parse(
                                                                    addressList[
                                                                            index]
                                                                        .latitude!),
                                                                double.parse(
                                                                    addressList[
                                                                            index]
                                                                        .longitude!)),
                                                            selectInitialPosition:
                                                                true,
                                                            usePinPointingSearch:
                                                                true,
                                                            usePlaceDetailSearch:
                                                                true,
                                                            zoomGesturesEnabled:
                                                                true,
                                                            zoomControlsEnabled:
                                                                true,
                                                            onPlacePicked:
                                                                (PickResult
                                                                    result) {
                                                              setState(() {
                                                                selectedPlace =
                                                                    result;
                                                                print(selectedPlace!
                                                                    .geometry!
                                                                    .location
                                                                    .lat);
                                                                Navigator
                                                                    .pushReplacement(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                SetLocationScreen(
                                                                                  pickResult: selectedPlace!,
                                                                                  isEdit: true,
                                                                                  address_id: addressList[index].id!,
                                                                                ))).then(
                                                                    (value) {
                                                                  getAddress();
                                                                });
                                                              });
                                                            },
                                                            onMapTypeChanged:
                                                                (MapType
                                                                    mapType) {
                                                              print(
                                                                  "Map type changed to ${mapType.toString()}");
                                                            },
                                                          );
                                                        },
                                                      ),
                                                    );
                                                  },
                                                  child: Icon(Icons.edit)),
                                              IconButton(
                                                  onPressed: () {
                                                    showDialog(
                                                        context: context,
                                                        builder:
                                                            (context) =>
                                                                AlertDialog(
                                                                  title: Text(
                                                                      'Are you sure you want to Delete this address?'),
                                                                  actions: [
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          TextButton(
                                                                              onPressed: () {
                                                                                Navigator.pop(context);
                                                                              },
                                                                              child: Text('No')),
                                                                          TextButton(
                                                                              onPressed: () {
                                                                                Navigator.pop(context);
                                                                                deleteAddress(addressList[index].id!);
                                                                              },
                                                                              child: Text('Yes')),
                                                                        ],
                                                                      ),
                                                                    )
                                                                  ],
                                                                ));
                                                  },
                                                  icon: Icon(Icons.delete))
                                            ],
                                          ),
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (context) => AlertDialog(
                                                          title: Text(
                                                              'Are you sure you want to set this address as Default?'),
                                                          actions: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child: Text(
                                                                          'No')),
                                                                  TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                        setDefault(
                                                                            addressList[index].id!);
                                                                      },
                                                                      child: Text(
                                                                          'Yes')),
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ));
                                            // setDefault(addressList[index].id!);
                                          },
                                          leading: CircleAvatar(
                                            backgroundColor:
                                                (addressList[index].isDefault ==
                                                        'y')
                                                    ? Colors.red
                                                    : Colors.transparent,
                                            radius: 15,
                                          ),
                                          style: ListTileStyle.drawer,
                                          enabled: true,
                                          title: Text(
                                              addressList[index].address!)),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Divider(
                                          height: 0,
                                          color: Colors.black,
                                        ),
                                      ),
                                      (index + 1 == addressList.length)
                                          ? SizedBox(
                                              height: 150,
                                            )
                                          : Container()
                                    ],
                                  );
                                }),
                          ),
                          Container(
                            width: double.infinity,
                            color: AppConstant.appColor,
                            child: TextButton(
                                style: ButtonStyle(),
                                onPressed: () {
                                  if (addressList.length == 0) {
                                    Utils.showToast('Please add an address');
                                  } else {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HomeBaseScreen()),
                                        (route) => false);
                                  }
                                },
                                child: Text(
                                  'Next',
                                  style: TextStyle(color: Colors.white),
                                )),
                          )
                        ],
                      ),
      ),
    );
  }

  Future _getLocation() async {
    Location location = new Location();
    LocationData _pos = await location.getLocation();

    currentPostion = LatLng(_pos.latitude!, _pos.longitude!);

    print("sndljdks" + currentPostion.toString());
  }

  Future<GetAddressList?> getAddress() async {
    var userBean = await Utils.getUser();

    FormData from =
        FormData.fromMap({"user_id": userBean.data!.id, "token": "123456789"});

    GetAddressList? bean = await ApiProvider().getAddress(from);
    print(bean!.data);

    setState(() {
      error = false;
      loading = false;
    });

    if (bean.status == true) {
      setState(() {
        addressList = bean.data!;
      });
      return bean;
    } else {
      addressList = [];
      Utils.showToast(bean.message!);
    }

    return null;
  }

  Future setDefault(String address_id) async {
    progressDialog = ProgressDialog(context);
    progressDialog = ProgressDialog(context);
    progressDialog.show();
    try {
      var userBean = await Utils.getUser();

      FormData from = FormData.fromMap({
        "user_id": userBean.data!.id,
        "token": "123456789",
        'address_id': address_id
      });

      var bean = await ApiProvider().setDefaultAddress(from);
      progressDialog.dismiss(context);
      if (bean['status'] == true) {
        getAddress();
      } else {
        Utils.showToast('Try again Later');
      }

      return null;
    } on HttpException catch (exception) {
      progressDialog.dismiss(context);
      error = true;
      loading = false;

      setState(() {});
      print(exception);
    } catch (exception) {
      progressDialog.dismiss(context);
      error = true;
      loading = false;
      setState(() {});
      print(exception);
    }
  }

  Future deleteAddress(String address_id) async {
    progressDialog = ProgressDialog(context);
    progressDialog = ProgressDialog(context);
    progressDialog.show();
    try {
      var userBean = await Utils.getUser();

      FormData from = FormData.fromMap({
        "userid": userBean.data!.id,
        "token": "123456789",
        'address_id': address_id
      });

      var bean = await ApiProvider().DeleteAddress(from);
      progressDialog.dismiss(context);
      if (bean['status'] == true) {
        getAddress();
      } else {
        Utils.showToast('Try again Later');
      }

      return null;
    } on HttpException catch (exception) {
      progressDialog.dismiss(context);

      setState(() {});
      print(exception);
    } catch (exception) {
      progressDialog.dismiss(context);

      setState(() {});
      print(exception);
    }
  }
}
