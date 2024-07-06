import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cache/cache_helper.dart';
import 'package:shop_app/core/api/api_consumer.dart';
import 'package:shop_app/core/api/end_Points.dart';
import 'package:shop_app/core/errors/exception.dart';
import 'package:shop_app/model/login_model.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.api) : super(LoginInitial());

  final ApiConsumer api;

  static LoginCubit get(context) => BlocProvider.of(context);

  Widget suffix = const  Icon(Icons.visibility_outlined);
  bool isPassword = true ;

  LoginModel? loginModel;

  void changeShowPassword () {
    isPassword = !isPassword;
    suffix = isPassword ? const Icon(Icons.visibility_outlined) : const Icon(Icons.visibility_off_outlined);

    emit(LoginChangePasswordState());

  }

  void login({required String email, required String password}) async {

    try {
      emit(LoginLoadedState());
      final response = await api.post(EndPoints.login, data: {
        ApiKey.email : email,
        ApiKey.password : password,
      });
      loginModel = LoginModel.fromJson(response);

      if(loginModel?.status == true){
        emit(LoginSuccessState(loginModel: loginModel!));
        CacheHelper.saveData(key: ApiKey.token, value: loginModel?.data?.token);
      }else{
        emit(LoginFailureState(errorMessage: loginModel!.message));
      }

    } on ServerException catch (e) {
      emit(LoginFailureState(errorMessage: e.errorModel.message));
    }
  }
}
