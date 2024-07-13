part of 'profile_cubit.dart';

sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class UploadImageStates extends ProfileState {}

final class ProfileLoadingState extends ProfileState {}

final class ProfileSuccessState extends ProfileState {
  final ProfileModel profileModel;

  ProfileSuccessState({required this.profileModel});
}

final class ProfileFailureState extends ProfileState {
  final String errorMessage;

  ProfileFailureState({required this.errorMessage});
}

final class UpDateProfileLoadingState extends ProfileState {}

final class UpDateProfileSuccessState extends ProfileState {
  final UpDateProfileModel upDateProfileModel;

  UpDateProfileSuccessState({required this.upDateProfileModel});
}

final class UpDateProfileFailureState extends ProfileState {
  final String errorMessage;

  UpDateProfileFailureState({required this.errorMessage});
}
