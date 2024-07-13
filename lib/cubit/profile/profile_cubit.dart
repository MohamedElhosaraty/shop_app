import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_app/core/api/api_consumer.dart';
import 'package:shop_app/core/api/end_Points.dart';
import 'package:shop_app/core/errors/exception.dart';
import 'package:shop_app/model/profile.dart';
import 'package:shop_app/model/update_profile_model.dart';
import 'package:shop_app/shared/components/navigatorto.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.api) : super(ProfileInitial());

  final ApiConsumer api ;

  static ProfileCubit get(context) => BlocProvider.of(context);

  ProfileModel? profileModel ;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  void getUserData () async {

    emit(ProfileLoadingState());

    try {

      final response = await api.get(ApiKey.profile);

      if(response['status'] == true){
        profileModel = ProfileModel.fromJson(response);

        nameController.text = profileModel?.data.name ?? '';
        emailController.text = profileModel?.data.email ?? '';
        phoneController.text = profileModel?.data.phone ?? '';

        emit(ProfileSuccessState(profileModel: profileModel!));

      }else{
        emit(ProfileFailureState(errorMessage: response['message'].toString()));
        showToast(message: response['message'].toString(), state: ToastStates.ERROR);

      }

    } on ServerException catch (e) {
      emit(ProfileFailureState(errorMessage: e.errorModel.message));
    }
  }

  UpDateProfileModel? upDateProfileModel ;

  void upDateProfile ({required String name , required String email , required String phone}) async {
    try {
      emit(UpDateProfileLoadingState());
      final response = await api.put(ApiKey.update,
      data: {
        ApiKey.name : name ,
        ApiKey.email : email ,
        ApiKey.phone : phone ,
      });

      upDateProfileModel = UpDateProfileModel.fromJson(response);

      if(upDateProfileModel?.status == true){
        emit(UpDateProfileSuccessState(upDateProfileModel: upDateProfileModel!));
        getUserData();

      }else{
        emit(UpDateProfileFailureState(errorMessage: upDateProfileModel!.message));
      }

    } on ServerException catch (e) {
      emit(UpDateProfileFailureState(errorMessage: e.errorModel.message));
    }
  }
}
