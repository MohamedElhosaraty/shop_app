import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/cache/cache_helper.dart';
import 'package:shop_app/core/api/end_Points.dart';
import 'package:shop_app/cubit/profile/profile_cubit.dart';
import 'package:shop_app/modules/login.dart';
import 'package:shop_app/shared/components/containerbutton.dart';
import 'package:shop_app/shared/components/navigatorto.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});

 final TextEditingController emailController = TextEditingController();
 final TextEditingController nameController = TextEditingController();
 final TextEditingController phoneController = TextEditingController();

  // File? image;
  // final imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ProfileScreen",
          style: TextStyle(
              fontSize: 25.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'font'
          ),
        ),
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if(state is UpDateProfileFailureState){
            showToast(message: state.errorMessage, state: ToastStates.ERROR);
          }
        },
        builder: (context, state) {

              if (state is ProfileLoadingState) {
                return const Center(child: CircularProgressIndicator(),);
              }
              if (state is ProfileSuccessState) {
                nameController.text = state.profileModel.data.name;
                emailController.text = state.profileModel.data.email;
                phoneController.text = state.profileModel.data.phone;

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 100,
                        backgroundImage: NetworkImage(state.profileModel.data.image),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15.0),
                        child: TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.person),
                              border: const OutlineInputBorder(),
                              hintText: "Name",
                              hintStyle: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'font',
                                  color: Colors.black
                              )
                          ),

                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15.0),
                        child: TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.email),
                              border: const OutlineInputBorder(),
                              hintText: "Email",
                              hintStyle: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'font',
                                  color: Colors.black
                              )
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15.0),
                        child: TextField(
                          controller: phoneController,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.phone_android),
                              border: const OutlineInputBorder(),
                              hintText: "Phone",
                              hintStyle: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'font',
                                  color: Colors.black
                              )
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15.0),
                        child: ContainerButton(style: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'font'
                        ),
                            text: "SIGNOUT", onPressed: () {
                              CacheHelper.removeData(key: ApiKey.token).then((
                                  value) {
                                if (value) {
                                  navigateAndFinish(context, LoginScreen());
                                }
                              });
                            }),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15.0),
                        child: ContainerButton(style: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'font'
                        ),
                            text: "UPDATE", onPressed: () {
                              BlocProvider.of<ProfileCubit>(context)
                                  .upDateProfile(
                                  name: nameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text
                              );
                              print(BlocProvider
                                  .of<ProfileCubit>(context)
                                  .upDateProfileModel);
                            }),
                      )
                    ],
                  ),
                );
              }
              if (state is ProfileFailureState) {
                return Center(child: Text(state.errorMessage));
              }
              return const Center(child: Text("Mohamed"));

        },
      ),
    );
  }
}
