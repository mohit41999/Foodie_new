import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:food_app/Menu/OrderScreen.dart';
import 'package:food_app/Menu/Profile.dart';
import 'package:food_app/model/BeanVerifyOtp.dart';
import 'package:food_app/res.dart';
import 'package:food_app/screen/DashboardScreen.dart';
import 'package:food_app/screen/FeedbackScreen.dart';
import 'package:food_app/screen/PaymentScreen.dart';
import 'package:food_app/utils/Constents.dart';
import 'package:food_app/utils/PrefManager.dart';
import 'package:food_app/utils/Utils.dart';

import 'LoginSignUpScreen.dart';

class HomeBaseScreen extends StatefulWidget {
  const HomeBaseScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomeBaseScreenState();
}

class HomeBaseScreenState extends State<HomeBaseScreen> {
  int _selectedIndex = 0;

  final List<Widget> _children = [
    DashboardScreen(0, 0, 0, "", 0, 0),
    OrderScreen(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const MyDrawers(),
        body: Center(
          child: _children.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                showUnselectedLabels: true,
                backgroundColor: Colors.black,
                showSelectedLabels: true,
                unselectedItemColor: Colors.white,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: ImageIcon(
                      AssetImage('assets/images/ic_dashboard.png'),
                    ),
                    label: 'Order',
                  ),
                  BottomNavigationBarItem(
                    icon: ImageIcon(
                      AssetImage('assets/images/ic_order_history.png'),
                    ),
                    label: 'Orders History',
                  ),
                  BottomNavigationBarItem(
                    icon: ImageIcon(
                      AssetImage('assets/images/ic_profile.png'),
                    ),
                    label: 'Profile',
                  ),
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: const Color(0xffFFA451),
                onTap: _onItemTapped,
              ),
            )
          ],
        ));
  }
}

class MyDrawers extends StatefulWidget {
  const MyDrawers({Key? key}) : super(key: key);

  @override
  MyDrawersState createState() => MyDrawersState();
}

class MyDrawersState extends State<MyDrawers> {
  late BeanVerifyOtp userBean;
  String? name = "";
  String? address = "";
  var number = "";
  String? email = "";

  void getUser() async {
    userBean = await Utils.getUser();
    name = userBean.data!.kitchenname;
    address = userBean.data!.address;
    email = userBean.data!.email;
    if (kDebugMode) {
      print("email>>" + email!);
    }
    setState(() {});
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30), bottomRight: Radius.circular(30)),
        child: SizedBox(
          width: 300,
          child: Drawer(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 16,
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50, left: 20),
                    child: Image.asset(
                      Res.ic_boy,
                      width: 90,
                      height: 90,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 20, top: 16),
                      child: Text(
                        name.toString(),
                        style: const TextStyle(
                            color: Colors.black,
                            fontFamily: AppConstant.fontBold,
                            fontSize: 18),
                      )),
                  Padding(
                      padding: const EdgeInsets.only(left: 20, top: 5),
                      child: Text(
                        address!,
                        style: const TextStyle(
                            fontFamily: AppConstant.fontRegular,
                            fontSize: 14,
                            color: Colors.grey),
                      )),
                  Padding(
                      padding: const EdgeInsets.only(left: 20, top: 5),
                      child: Text(
                        email!,
                        style: const TextStyle(
                            fontFamily: AppConstant.fontRegular,
                            fontSize: 14,
                            color: Colors.grey),
                      )),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 16, top: 30),
                      child: Row(
                        children: [
                          Image.asset(
                            Res.ic_dashboard,
                            color: Colors.grey,
                            width: 25,
                            height: 25,
                          ),
                          const Padding(
                              padding: EdgeInsets.only(left: 10, top: 5),
                              child: Text(
                                'DASHBOARD',
                                style: TextStyle(
                                    fontFamily: AppConstant.fontBold,
                                    fontSize: 12,
                                    color: Colors.black),
                              )),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      bool isLogined =
                          await PrefManager.getBool(AppConstant.session);
                      if (isLogined) {
                        Navigator.pop(context);
                        Navigator.push<void>(
                          context,
                          MaterialPageRoute(builder: (_) => FeedbackScreen()),
                        );
                      } else {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginSignUpScreen()),
                            ModalRoute.withName("/loginSignUp"));
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 16, top: 30),
                      child: Row(
                        children: [
                          Image.asset(
                            Res.ic_feedback,
                            color: Colors.grey,
                            width: 25,
                            height: 25,
                          ),
                          const Padding(
                              padding: EdgeInsets.only(left: 16, top: 5),
                              child: Text(
                                'FEEDBACK/REVIEW',
                                style: TextStyle(
                                    fontFamily: AppConstant.fontBold,
                                    fontSize: 12,
                                    color: Colors.black),
                              )),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      bool isLogined =
                          await PrefManager.getBool(AppConstant.session);
                      if (isLogined) {
                        Navigator.pop(context);
                        Navigator.push<void>(
                          context,
                          MaterialPageRoute(builder: (_) => OrderScreen()),
                        );
                      } else {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginSignUpScreen()),
                            ModalRoute.withName("/loginSignUp"));
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 16, top: 30),
                      child: Row(
                        children: [
                          Image.asset(
                            Res.ic_order,
                            color: Colors.grey,
                            width: 25,
                            height: 25,
                          ),
                          const Padding(
                              padding: EdgeInsets.only(left: 16, top: 5),
                              child: Text(
                                'ORDERS HISTORY',
                                style: TextStyle(
                                    fontFamily: AppConstant.fontBold,
                                    fontSize: 12,
                                    color: Colors.black),
                              )),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      bool isLogined =
                          await PrefManager.getBool(AppConstant.session);
                      if (isLogined) {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PaymentScreen("", "", "",
                                  "", "", "", "", "", "navigation")),
                        );
                      } else {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginSignUpScreen()),
                            ModalRoute.withName("/loginSignUp"));
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 16, top: 30),
                      child: Row(
                        children: [
                          Image.asset(
                            Res.ic_payment,
                            color: Colors.grey,
                            width: 25,
                            height: 25,
                          ),
                          const Padding(
                              padding: EdgeInsets.only(left: 16, top: 5),
                              child: Text(
                                'PAYMENT',
                                style: TextStyle(
                                    fontFamily: AppConstant.fontBold,
                                    fontSize: 12,
                                    color: Colors.black),
                              )),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      bool isLogined =
                          await PrefManager.getBool(AppConstant.session);
                      if (isLogined) {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Profile()),
                        );
                      } else {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginSignUpScreen()),
                            ModalRoute.withName("/loginSignUp"));
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 16, top: 30),
                      child: Row(
                        children: [
                          Image.asset(
                            Res.ic_account,
                            color: Colors.grey,
                            width: 25,
                            height: 25,
                          ),
                          const Padding(
                              padding: EdgeInsets.only(left: 16, top: 5),
                              child: Text(
                                'ACCOUNT',
                                style: TextStyle(
                                    fontFamily: AppConstant.fontBold,
                                    fontSize: 12,
                                    color: Colors.black),
                              )),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _ackAlert(context);
                    },
                    child: Container(
                      height: 50,
                      width: 130,
                      decoration: BoxDecoration(
                          color: const Color(0xffFFA451),
                          borderRadius: BorderRadius.circular(60)),
                      margin: const EdgeInsets.only(left: 16, top: 30),
                      child: Row(
                        children: [
                          Padding(
                            child: Image.asset(
                              Res.ic_logout,
                              color: Colors.white,
                              width: 25,
                              height: 25,
                            ),
                            padding: const EdgeInsets.only(left: 10),
                          ),
                          const Padding(
                              padding: EdgeInsets.only(left: 16),
                              child: Text(
                                'LOGOUT',
                                style: TextStyle(
                                    fontFamily: AppConstant.fontBold,
                                    fontSize: 12,
                                    color: Colors.white),
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              physics: const BouncingScrollPhysics(),
            ),
          ),
        ));
  }
}

Future<void> _ackAlert(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Logout!'),
        content: const Text('Are you sure want to logout'),
        actions: <Widget>[
          FlatButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: const Text('Ok'),
            onPressed: () {
              PrefManager.clear();
              Navigator.pushNamedAndRemoveUntil(
                  context, '/loginSignUp', (Route<dynamic> route) => false);
            },
          )
        ],
      );
    },
  );
}
