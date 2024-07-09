part of 'register_cubit.dart';

sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class RegisterChangePassword extends RegisterState {}

final class RegisterLoadingState extends RegisterState {}

final class RegisterSuccessState extends RegisterState {

  final RegisterModel registerModel;

  RegisterSuccessState({required this.registerModel});
}

final class RegisterFailureState extends RegisterState {

  final String errorMessage ;

  RegisterFailureState({required this.errorMessage});
}
