part of 'products_cubit.dart';

sealed class ProductsState {}

final class ProductsInitial extends ProductsState {}

final class BottomHomeLoadingState extends ProductsState {}

final class BottomHomeSuccessState extends ProductsState {

  final HomeModel homeModel;

  BottomHomeSuccessState({required this.homeModel});
}

final class BottomHomeFailureState extends ProductsState {

  final String errorMessage;

  BottomHomeFailureState({required this.errorMessage});
}
///////////////////////////------------ Change Favorite

// final class BottomChangeFavoriteState extends ProductsState {}
//
//
// final class BottomChangeFavoriteSuccessState extends ProductsState {
//
//   final FavoriteModel favoriteModel;
//
//   BottomChangeFavoriteSuccessState({required this.favoriteModel});
// }
//
// final class BottomFailureFavoriteState extends ProductsState {
//
//   final String errorMessage;
//
//   BottomFailureFavoriteState({required this.errorMessage});
//
// }

