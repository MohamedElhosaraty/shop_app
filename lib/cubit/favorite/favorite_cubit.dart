import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/api/api_consumer.dart';
import 'package:shop_app/core/api/end_Points.dart';
import 'package:shop_app/core/errors/exception.dart';
import 'package:shop_app/model/favorite_model.dart';
import 'package:shop_app/model/get_Favorite_Model.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit(this.api) : super(FavoriteInitial());

  final ApiConsumer api;

  static FavoriteCubit get(context) => BlocProvider.of(context);

  FavoriteModel? favoriteModel;

  GetFavouriteModel? getFavouriteModel;

  // void changeFavorites (int productId) async
  // {
  //   try {
  //
  //
  //     favorite[productId] != favorite[productId];
  //     emit(BottomChangeFavoriteState());
  //
  //     final response = await api.post(
  //         isFormData:  true,
  //         ApiKey.favorites,
  //         data: {
  //           "product_id" : productId ,
  //         }
  //     );
  //
  //     favoriteModel = FavoriteModel.fromJson(response);
  //
  //     if(favoriteModel!.status == false){
  //       favorite[productId] != favorite[productId];
  //     }
  //
  //
  //     emit(BottomChangeFavoriteSuccessState(favoriteModel: favoriteModel!));
  //   } on ServerException catch (e) {
  //
  //     favorite[productId] != favorite[productId];
  //     emit(BottomFailureFavoriteState(errorMessage: e.errorModel.message));
  //   }
  // }

  void getFavoriteData () async {
    try {
      emit(BottomLoading2FavoriteState());
      final response = await api.get(ApiKey.favorites);

      getFavouriteModel = GetFavouriteModel.fromJson(response);

      emit(BottomSuccessFavoriteState(getFavouriteModel: getFavouriteModel!));

    } on ServerException catch (e) {
      emit(BottomFailureGetFavoriteState(errorMessage: e.errorModel.message));
    }

  }
}
