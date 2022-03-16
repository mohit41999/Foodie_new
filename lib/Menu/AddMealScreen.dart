import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_app/Menu/MenuITemSelectedScreen.dart';
import 'package:food_app/res.dart';
import 'package:food_app/screen/HomeBaseScreen.dart';
import 'package:food_app/utils/Constents.dart';

class AddMealScreen extends StatefulWidget {
  @override
  _AddMealScreenState createState() => _AddMealScreenState();
}

class _AddMealScreenState extends State<AddMealScreen> {
  bool isChecked = false;

  var isSelected = -1;
  Map<String, bool> values = {
    'Mutter': true,
    'Roti': false,
  };
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
            children: [
              Container(
                margin: EdgeInsets.only(left: 16, top: 30),
                height: 60,
                child: Row(
                  children: [
                    SizedBox(
                      width: 16,
                    ),
                    Image.asset(
                      Res.ic_veg,
                      width: 20,
                      height: 20,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      "Veg",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: AppConstant.fontBold,
                          fontSize: 16),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    VerticalDivider(color: Colors.grey, width: 20),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        "North Indian Meals",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: AppConstant.fontBold,
                            fontSize: 14),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Image.asset(
                        Res.ic_cross,
                        width: 20,
                        height: 20,
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return getItem(choices[index]);
                },
                itemCount: choices.length,
              ),
              SizedBox(
                height: 16,
              ),
              ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return getItemTwo(choicesTwo[index]);
                },
                itemCount: choicesTwo.length,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/menuItemSelected');
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    height: 55,
                    width: 120,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Center(
                        child: Text(
                          "SET DEFAULT",
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
        ));
  }

  getItem(Choice choic) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text(choic.title.toString(),
                style: TextStyle(
                    color: Colors.black, fontFamily: AppConstant.fontBold)),
          ),
          SizedBox(
            height: 16,
          ),
          ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return getListFood(food[index], index);
            },
            itemCount: food.length,
          )
        ],
      ),
    );
  }

  getListFood(FOOD food, int index) {
    return Column(
      children: [
        Row(
          children: [
            Checkbox(
              checkColor: Colors.white, // color of tick Mark
              activeColor: AppConstant.lightGreen, // c
              onChanged: (value) {
                setState(() {
                  food.isCheckbox = value;
                  print(food.isCheckbox);
                });
              },
              value: food.isCheckbox == null ? false : food.isCheckbox,
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(food.title!),
            )),
          ],
        )
      ],
    );
  }

  getItemTwo(ChoiceTwo choic) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text(choic.title.toString(),
                style: TextStyle(
                    color: Colors.black, fontFamily: AppConstant.fontBold)),
          ),
          SizedBox(
            height: 16,
          ),
          ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return getListFoodTwo(foodTwo[index], index);
            },
            itemCount: foodTwo.length,
          )
        ],
      ),
    );
  }

  getListFoodTwo(FOODTWo food, int index) {
    return Column(
      children: [
        Row(
          children: [
            Checkbox(
              checkColor: Colors.white, // color of tick Mark
              activeColor: AppConstant.lightGreen, // c
              onChanged: (value) {
                setState(() {
                  food.isCheckbox = value;
                  print(food.isCheckbox);
                });
              },
              value: food.isCheckbox == null ? false : food.isCheckbox,
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(food.title!),
            )),
          ],
        )
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
  Choice(title: 'Vegetable'),
];

class FOOD {
  FOOD({this.title, this.isCheckbox});
  String? title;
  bool? isCheckbox;
}

List<FOOD> food = <FOOD>[
  FOOD(title: 'Mutter Paneer', isCheckbox: false),
  FOOD(title: 'Bhindi', isCheckbox: false),
  FOOD(title: 'Dal', isCheckbox: false),
  FOOD(title: 'Fulka', isCheckbox: false),
  FOOD(title: 'Roti', isCheckbox: false),
  FOOD(title: 'Stream Rice', isCheckbox: false),
  FOOD(title: 'Salad', isCheckbox: false),
  FOOD(title: 'Raita', isCheckbox: false),
];

class ChoiceTwo {
  ChoiceTwo({this.title, this.image});
  String? title;
  String? image;
}

List<ChoiceTwo> choicesTwo = <ChoiceTwo>[
  ChoiceTwo(title: 'Dal'),
];

class FOODTWo {
  FOODTWo({this.title, this.isCheckbox});
  String? title;
  bool? isCheckbox;
}

List<FOODTWo> foodTwo = <FOODTWo>[
  FOODTWo(title: 'Mutter Paneer', isCheckbox: false),
  FOODTWo(title: 'Bhindi', isCheckbox: false),
  FOODTWo(title: 'Dal', isCheckbox: false),
  FOODTWo(title: 'Fulka', isCheckbox: false),
  FOODTWo(title: 'Roti', isCheckbox: false),
  FOODTWo(title: 'Stream Rice', isCheckbox: false),
  FOODTWo(title: 'Salad', isCheckbox: false),
  FOODTWo(title: 'Raita', isCheckbox: false),
];
