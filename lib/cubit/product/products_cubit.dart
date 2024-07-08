import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/api/api_consumer.dart';
import 'package:shop_app/core/api/end_Points.dart';
import 'package:shop_app/core/errors/exception.dart';
import 'package:shop_app/model/favorite_model.dart';
import 'package:shop_app/model/home_model.dart';
import 'package:shop_app/shared/components/navigatorto.dart';


part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(this.api) : super(ProductsInitial());

  final ApiConsumer api;

  static ProductsCubit get(context) => BlocProvider.of(context);

  HomeModel? homeModel;

  FavoriteModel? favoriteModel;

  void getHomeData() async {
    try {
      emit(BottomHomeLoadingState());
      final response = await api.get(
        ApiKey.home,
      );

      homeModel = HomeModel.fromJson(response);

      homeModel?.data.products.forEach((element) {
        favorite.addAll({
          element.id : element.inFavorites ,
        });
      });

      emit(BottomHomeSuccessState(homeModel: homeModel!));
    } on ServerException catch (e) {
      emit(BottomHomeFailureState(errorMessage: e.errorModel.message));
    }
  }


}