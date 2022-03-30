import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/model/BeanVerifyOtp.dart';
import 'package:food_app/network/ApiProvider.dart';
import 'package:food_app/screen/HomeBaseScreen.dart';
import 'package:food_app/utils/Constents.dart';
import 'package:food_app/utils/HttpException.dart';
import 'package:food_app/utils/PrefManager.dart';
import 'package:food_app/utils/Utils.dart';
import 'package:food_app/utils/progress_dialog.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );
  Future<void> handleSignIn(BuildContext context) async {
    try {
      // await _googleSignIn.signIn();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      prefs.setString('email', googleSignInAccount.email);
      prefs.setString('displayName', googleSignInAccount.displayName!);
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      var authResult = await _auth.signInWithCredential(credential);
      var _user = authResult.user;
      print(_user!.phoneNumber.toString() + 'pppppppp');
      print(_user.uid.toString() + 'pppppppp');
      socailLogin(googleSignInAccount.email,
          googleSignInAccount.displayName ?? '', context);
    } catch (error) {
      print(error);
    }
  }

  void socailLogin(String email, String name, BuildContext context) async {
    ProgressDialog progressDialog = ProgressDialog(context);
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

  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final GoogleSignIn googleSignIn = GoogleSignIn();
  // String? name;
  // String? email;
  // String? imageUrl;

  // Future<User> signInWithGoogle() async {
  //   try {

  //     final GoogleSignInAccount googleSignInAccount = await (googleSignIn.signIn() as FutureOr<GoogleSignInAccount>);

  //     final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleSignInAuthentication.accessToken,
  //       idToken: googleSignInAuthentication.idToken,
  //     );
  //     final UserCredential authResult = await _auth.signInWithCredential(credential);
  //     final User user = authResult.user!;
  //     assert(user.email != null);
  //     assert(user.displayName != null);
  //     assert(user.photoURL != null);
  //     name = user.displayName;
  //     email = user.email;
  //     imageUrl = user.photoURL;
  //     if (name!.contains(" ")) {
  //       name = name!.substring(0, name!.indexOf(" "));
  //     }
  //     final User currentUser = await _auth.currentUser!;
  //     currentUser.getIdToken();
  //     assert(!user.isAnonymous);
  //     assert(await user.getIdToken() != null);
  //     assert(user.uid == currentUser.uid);
  //     return user;
  //   }catch(e){
  //     print(e.toString());

  //   }
  // }

  void signOutGoogle() async {
    await _googleSignIn.signOut();
  }
}
