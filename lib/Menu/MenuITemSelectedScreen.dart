import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:food_app/res.dart';
import 'package:food_app/utils/Constents.dart';

class MenuITemSelectedScreen extends StatefulWidget {
  @override
  _MenuITemSelectedScreenState createState() => _MenuITemSelectedScreenState();
}

class _MenuITemSelectedScreenState extends State<MenuITemSelectedScreen> {

  int isSelected = -1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    // FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                margin: EdgeInsets.only(top: 40),
                height: 60,
                child: Row(
                  children: [
                    SizedBox(
                      width: 16,
                    ),
                    InkWell(
                      onTap:(){

                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        Res.ic_right_arrow, width: 16, height: 16,),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Text("Selected Item", style: TextStyle(
                        fontFamily: AppConstant.fontBold, fontSize: 20),)
                  ],
                ),
              ),

              Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text(
                    "Selected any of the below to make it as a default dis\n for the day.",
                    style: TextStyle(fontFamily: AppConstant.fontRegular,
                        fontSize: 13,
                        color: Colors.grey),),
              ),
              ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return getItem(choices[index], index);
                },
                itemCount: choices.length,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {

                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        left: 16, right: 16, bottom: 16),
                    height: 55,
                    width: 120,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Center(
                        child: Text(
                          "+ ADD MEAL",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: AppConstant.fontBold,
                              fontSize: 10),
                        ),
                      ),
                    ),
                  ),
                ),
              )

            ],
          ),

          physics: BouncingScrollPhysics(),
        )

    );
  }

  getItem(Choice choic, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16, top: 16),
          child: Text(choic.title.toString(),
              style: TextStyle(
                  color: Colors.black, fontFamily: AppConstant.fontBold)),
        ),
        SizedBox(
          height: 16,
        ),
        GridView.count(
          crossAxisCount: 3,
          childAspectRatio: 3 / 2,
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          children: List.generate(subitem.length, (index) {
            return getListFood(subitem[index], index);
          }),
        ),
      ],
    );
  }

  getListFood(SUBITEM subitem, int index) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              isSelected = index;
            });
          },
          child: Container(
              height: 40,
              width: 160,
              decoration: BoxDecoration(
                  color: isSelected == index ? Color(0xff7EDABF) : Color(
                      0xffF3F6FA),
                  borderRadius: BorderRadius.circular(100)),
              margin: EdgeInsets.only(left: 16, top: 16, bottom: 16, right: 16),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(subitem.title!, style: TextStyle(
                      color: isSelected == index ? Colors.white : Colors.black,
                      fontSize: 12,
                      fontFamily: AppConstant.fontRegular),),
                ),
              )),
        ),

      ],
    );
  }
}

class Choice {
  Choice({this.title, this.image});

  String? title;
  String? image;
}

List<Choice> choices = <Choice>[
  Choice(title: 'Veg'),
  Choice(title: 'Dal'),
  Choice(title: 'Bread'),
  Choice(title: 'Rice'),
  Choice(title: 'other'),
];

class SUBITEM {
  SUBITEM({this.title});

  String? title;
}

List<SUBITEM> subitem = <SUBITEM>[
  SUBITEM(title: 'Muttor Paneer'),
  SUBITEM(title: 'Bhindi'),
  SUBITEM(title: 'Mix Veg'),
  SUBITEM(title: 'Plain Dal'),
  SUBITEM(title: 'dal Fry'),
];
