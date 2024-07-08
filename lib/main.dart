import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/cache/cache_helper.dart';
import 'package:shop_app/core/api/dio_consumer.dart';
import 'package:shop_app/core/api/end_Points.dart';
import 'package:shop_app/cubit/bottomNav/bottom_cubit.dart';
import 'package:shop_app/cubit/categories/categories_cubit.dart';
import 'package:shop_app/cubit/favorite/favorite_cubit.dart';
import 'package:shop_app/cubit/product/products_cubit.dart';
import 'package:shop_app/layout/home.dart';
import 'package:shop_app/modules/login.dart';
import 'package:shop_app/modules/onboarding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper().init();

  Widget widget;
  bool onBoarding = CacheHelper.getData(key: "onBoarding") ?? false;
  String token = CacheHelper.getData(key: ApiKey.token) ?? '';
  if (onBoarding) {
    if (token != '') {
      widget = const HomeScreen();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = const OnBoardingScreen();
  }


  runApp(MyApp(onBoarding: widget,));
}

class MyApp extends StatelessWidget {

  final Widget onBoarding;

  const MyApp({super.key, required this.onBoarding});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext context, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                BottomCubit(DioConsumer(dio: Dio())),
              ),
              BlocProvider(
                create: (context) =>
                    ProductsCubit(DioConsumer(dio: Dio()))..getHomeData(),
              ),
              BlocProvider(
                create: (context) =>
                FavoriteCubit(DioConsumer(dio: Dio())),
              ),
              BlocProvider(
                create: (context) => CategoriesCubit(DioConsumer(dio: Dio()))
                  ..getDataCategories(),
              ),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Shop App',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
                useMaterial3: true,
              ),
              home: onBoarding,
            ),
          );
        }
    );
  }
}

