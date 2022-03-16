import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app/Menu/AddMealScreen.dart';
import 'package:food_app/Menu/MenuITemSelectedScreen.dart';

import 'package:food_app/screen/AddPackageScreen.dart';
import 'package:food_app/screen/CustomerFeedbackScreen.dart';
import 'package:food_app/screen/DashboardScreen.dart';
import 'package:food_app/screen/Demo.dart';
import 'package:food_app/screen/DetailsScreen.dart';
import 'package:food_app/screen/FeedbackScreen.dart';
import 'package:food_app/screen/FilterScreen.dart';
import 'package:food_app/screen/ForgotPasswordScreen.dart';

import 'package:food_app/screen/HomeBaseScreen.dart';
import 'package:food_app/screen/LoginSignUpScreen.dart';
import 'package:food_app/screen/MakePaymentScreen.dart';
import 'package:food_app/screen/OrderDispatchedScreen.dart';
import 'package:food_app/screen/PaymentScreen.dart';
import 'package:food_app/screen/SearchHistoryScreen.dart';
import 'package:food_app/screen/SearchLocationScreen.dart';
import 'package:food_app/screen/ShippingScreen.dart';
import 'package:food_app/screen/SplashScreen.dart';
import 'package:food_app/screen/UPI.dart';
import 'package:food_app/utils/Log.dart';
import 'package:logging/logging.dart';


void main() {
  _initLog();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) async {
    await Firebase.initializeApp();
    runApp(App());
  });
}
void _initLog() {
  Log.init();
  Log.setLevel(Level.ALL);
}
class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Food App",
        initialRoute: '/',
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(
            builder: (BuildContext context) => makeRoute(
                context: context,
                routeName: settings.name,
                arguments: settings.arguments),
            maintainState: true,
            fullscreenDialog: false,
          );
        });
  }


  Widget makeRoute({required BuildContext context,
    required String? routeName,
    Object? arguments}) {
    final Widget child = _buildRoute(context: context, routeName: routeName, arguments: arguments);
    return child;
  }

  Widget _buildRoute({required BuildContext context, required String? routeName, Object? arguments,}) {
    switch (routeName) {
      case '/':
        return SplashScreen();
      case '/loginSignUp':
        return LoginSignUpScreen();
      case '/homebase':
        return HomeBaseScreen();
      case '/addMeals':
        return AddMealScreen();
      case '/menuItemSelected':
        return MenuITemSelectedScreen();
      case '/search':
        return SearchLocationScreen();
      case '/searchhistory':
        return SearchHistoryScreen("");
        case '/filter':
        return FilterScreen();
      case '/addpackage':
        return AddPackageScreen();
      case '/payment':
        return PaymentScreen("","","","","","","","","");
      case '/forgotpassword':
        return ForgotPasswordScreen();
      case '/makepayment':
        return MakePaymentScreen("");
      case '/customerfeedback':
        return CustomerFeedbackScreen();
      case '/feedback':
        return FeedbackScreen();
      default:
        throw 'Route $routeName is not defined';
    }
  }
}
