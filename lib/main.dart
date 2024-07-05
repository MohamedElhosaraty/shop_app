import 'package:flutter/material.dart';
import 'package:shop_app/cache/cache_helper.dart';
import 'package:shop_app/modules/login.dart';
import 'package:shop_app/modules/onboarding.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper().init();
  bool onBoarding = CacheHelper.getData(key: "onBoarding") ?? false ;

  runApp( MyApp(onBoarding: onBoarding,));
}

class MyApp extends StatelessWidget {

  final bool onBoarding;
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
      home: onBoarding ? LoginScreen() : const OnBoardingScreen(),
    );
  }
}

