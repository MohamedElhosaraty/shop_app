part of 'login_cubit.dart';

sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoadedState extends LoginState {}

final class LoginSuccessState extends LoginState {

  final LoginModel loginModel;

  LoginSuccessState({required this.loginModel});
}

final class LoginFailureState extends LoginState {
  final String errorMessage ;

  LoginFailureState({required this.errorMessage});
}

final class LoginChangePasswordState extends LoginState {}
