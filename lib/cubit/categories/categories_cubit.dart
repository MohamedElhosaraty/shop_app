import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/api/api_consumer.dart';
import 'package:shop_app/core/api/end_Points.dart';
import 'package:shop_app/core/errors/exception.dart';
import 'package:shop_app/model/categories_model.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit(this.api) : super(CategoriesInitial());
  
  final ApiConsumer api;
  
  CategoriesModel? categoriesModel;

  void getDataCategories () async {
    try {
      emit(CategoriesLoadingState());
      final response = await api.get(ApiKey.categories);
      categoriesModel = CategoriesModel.fromJson(response);
      emit(CategoriesSuccessState(categoriesModel: categoriesModel!));

      categoriesModel = CategoriesModel.fromJson(response);
    } on ServerException catch (e) {
      emit(CategoriesFailureState(errorMessage: e.errorModel.message));
    }



  }


}
