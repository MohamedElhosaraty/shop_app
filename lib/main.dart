import 'package:flutter/material.dart';
import 'package:shop_app/cache/cache_helper.dart';
import 'package:shop_app/core/api/end_Points.dart';
import 'package:shop_app/layout/home.dart';
import 'package:shop_app/modules/login.dart';
import 'package:shop_app/modules/onboarding.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper().init();

  Widget widget;
  bool onBoarding = CacheHelper.getData(key: "onBoarding") ?? false ;
  String token = CacheHelper.getData(key: ApiKey.token) ?? false  ;
  if(onBoarding){
    if(token.isNotEmpty ) {
      widget = const HomeScreen();
    } else{
      widget =  LoginScreen();
    }
  }else{
    widget = const OnBoardingScreen();
  }


  runApp( MyApp(onBoarding: widget,));
}

class MyApp extends StatelessWidget {

  final Widget onBoarding;
   const MyApp({super.key, required this.onBoarding});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: onBoarding ,
    );
  }
}

