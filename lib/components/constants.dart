import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../business_logic/shared_pref/cache_helper.dart';
import '../presentation/screens/shop_login_screen.dart';

// end points
const login='login';
const home = 'home';
const getCategory='categories';
const favorite='favorites';
const profile= 'profile';
const register='register';
const updateProfile='update-profile';
const search='products/search';

// token
String token='';


  Future<bool?> showToast({
    required String text,
    required ToastState state
  })=> Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0,
    );


  enum ToastState{success, error, warning}


  Color? chooseToastColor(ToastState state){
  // ignore: unused_local_variable
    // Color color;
    switch(state){
      case ToastState.success:
        return Colors.green;
        // break;
      case ToastState.error:
        return Colors.red;
        // break;
      case ToastState.warning:
        return Colors.amber;
    }
    // return null;
  }

  void logOut(BuildContext context){
    CacheHelper.removeData(key: 'token').then((value) {
            if(value){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>ShopLoginScreen()));
            }
          });
  }

  void printFullText(String text){
    final pattern = RegExp('.{1,800}');
    pattern.allMatches(text).forEach((match) {
      print(match.group(0));
    });
  }