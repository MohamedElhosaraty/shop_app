part of 'products_cubit.dart';

sealed class ProductsState {}

final class ProductsInitial extends ProductsState {}

final class ProductsLoadingState extends ProductsState {}

final class ProductsSuccessState extends ProductsState {

  final HomeModel homeModel;

  ProductsSuccessState({required this.homeModel});
}

final class ProductsFailureState extends ProductsState {

  final String errorMessage;

  ProductsFailureState({required this.errorMessage});
}
