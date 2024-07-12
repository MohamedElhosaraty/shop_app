part of 'favorite_cubit.dart';

sealed class FavoriteState {}

final class FavoriteInitial extends FavoriteState {}

final class BottomChangeFavoriteState extends FavoriteState {}

final class BottomChangeFavoriteSuccessState extends FavoriteState {
  final FavoriteModel favoriteModel;

  BottomChangeFavoriteSuccessState({required this.favoriteModel});
}

final class BottomFailureFavoriteState extends FavoriteState {
  final String errorMessage;

  BottomFailureFavoriteState({required this.errorMessage});
}

//------------------- getData Favorite ----------

final class BottomLoadingFavoriteState extends FavoriteState {}

final class BottomSuccessFavoriteState extends FavoriteState {

  final  GetFavouriteModel getFavouriteModel;

  BottomSuccessFavoriteState({required this.getFavouriteModel});
}

final class BottomFailureGetFavoriteState extends FavoriteState {

  final String errorMessage;

  BottomFailureGetFavoriteState({required this.errorMessage});
}
