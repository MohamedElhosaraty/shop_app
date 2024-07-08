part of 'categories_cubit.dart';

sealed class CategoriesState {}

final class CategoriesInitial extends CategoriesState {}

final class CategoriesLoadingState extends CategoriesState {}

final class CategoriesSuccessState extends CategoriesState {

  final CategoriesModel categoriesModel;

  CategoriesSuccessState({required this.categoriesModel});
}

final class CategoriesFailureState extends CategoriesState {

  final String errorMessage;

  CategoriesFailureState({required this.errorMessage});
}
