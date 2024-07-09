import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cache/cache_helper.dart';
import 'package:shop_app/core/api/api_consumer.dart';
import 'package:shop_app/core/api/end_Points.dart';
import 'package:shop_app/core/errors/exception.dart';
import 'package:shop_app/model/register_model.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this.api) : super(RegisterInitial());

  final ApiConsumer api;

  static RegisterCubit get(context) => BlocProvider.of(context);

  Widget suffix = const  Icon(Icons.visibility_outlined);
  bool isPassword = true ;

  void changeShowPassword () {
    isPassword = !isPassword;
    suffix = isPassword ? const Icon(Icons.visibility_outlined) : const Icon(Icons.visibility_off_outlined);

    emit(RegisterChangePassword());

  }

  RegisterModel? registerModel;

  void register(
      {required String email, required String name, required String password, required String phone}) async {
    try {

      emit(RegisterLoadingState());
      final response = await api.post(EndPoints.register,
      data: {
        ApiKey.name : name ,
        ApiKey.email : email ,
        ApiKey.password : password ,
        ApiKey.phone : phone ,

      });

      registerModel =RegisterModel.fromJson(response);

      if(registerModel?.status == true){
        emit(RegisterSuccessState(registerModel: registerModel!));
        CacheHelper.saveData(key: ApiKey.token, value: registerModel?.data?.token);

      }else{
        emit(RegisterFailureState(errorMessage: registerModel!.message));

      }

    } on ServerException catch (e) {
      emit(RegisterFailureState(errorMessage: e.errorModel.message));
    }

  }
}
