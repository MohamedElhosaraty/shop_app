import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/core/api/api_consumer.dart';
import 'package:shop_app/core/api/end_Points.dart';
import 'package:shop_app/core/errors/exception.dart';
import 'package:shop_app/model/favorite_model.dart';
import 'package:shop_app/model/home_model.dart';
import 'package:shop_app/modules/categories.dart';
import 'package:shop_app/modules/favourite.dart';
import 'package:shop_app/modules/products.dart';
import 'package:shop_app/modules/setting.dart';
import 'package:shop_app/shared/components/navigatorto.dart';

part 'bottom_state.dart';

class BottomCubit extends Cubit<BottomState> {
  BottomCubit(this.api) : super(BottomInitial());

  final ApiConsumer api;

  static BottomCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomNav =  [
    const ProductsScreen(),
    CategoriesScreen(),
    const FavouriteScreen(),
    const SettingScreen()
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(BottomChangeNavState());
  }


}
