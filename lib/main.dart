// ignore_for_file: unnecessary_null_comparison

import 'package:bloc/bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/business_logic/shared_pref/cache_helper.dart';
import 'package:shop_app/presentation/screens/onboarding_screen.dart';
import 'package:shop_app/presentation/screens/shop_login_screen.dart';
import 'package:shop_app/presentation/styles/theme.dart';

import 'business_logic/bloc_observer.dart';
import 'business_logic/layout/cubit/shop_layout_cubit.dart';
import 'business_logic/network/dio_helper.dart';
import 'components/constants.dart';
import 'presentation/layOut/home_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  Widget widget;
  
  bool onBoarding = await CacheHelper.getData(key: 'onBoarding');
  token = await CacheHelper.getData(key: 'token')??'';
  print(token);

  
  if(onBoarding != null){
    if(token != null){
      widget = const HomeLayout();
    }else{
      widget = ShopLoginScreen();
    }
  }else{
    widget = OnBoardingScreen();
  }
  print(onBoarding);
  runApp( MyApp(startWidget: widget,));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.startWidget});
  final Widget? startWidget;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context)=> ShopLayoutCubit()..getHomeData()..getCategoryData()..getUserData(),
          )
      ],
      child: BlocBuilder<ShopLayoutCubit,ShopLayoutState>(
        builder: (context, state) {
          return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: lightTheme,
        darkTheme: darkTheme,
        home: startWidget,
      );
        },
      ),
    );
  }
}
