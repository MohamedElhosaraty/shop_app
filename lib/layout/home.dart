import 'package:flutter/material.dart';
import 'package:shop_app/cache/cache_helper.dart';
import 'package:shop_app/core/api/end_Points.dart';
import 'package:shop_app/modules/login.dart';
import 'package:shop_app/modules/onboarding.dart';
import 'package:shop_app/shared/components/navigatorto.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          InkWell(
              onTap: (){
                CacheHelper.removeData(key: ApiKey.token).then((value) {
                  if(value){
                    navigateAndFinish(context, LoginScreen());
                  }
                });
              },
              child:const Text("SignOut",style: TextStyle(
                fontSize: 30,color: Colors.blueAccent
              ),)),
          InkWell(
              onTap: (){
                CacheHelper.removeData(key: "onBoarding").then((value) {
                  if(value){
                    navigateAndFinish(context, OnBoardingScreen());
                  }
                });
              },
              child:const Text("SignOutBy OnBoarding",style: TextStyle(
                  fontSize: 30,color: Colors.blueAccent
              ),))
        ],
      ),
    );
  }
}
