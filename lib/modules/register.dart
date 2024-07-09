import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/core/api/dio_consumer.dart';
import 'package:shop_app/cubit/login/login_cubit.dart';
import 'package:shop_app/cubit/register/register_cubit.dart';
import 'package:shop_app/modules/login.dart';
import 'package:shop_app/shared/components/containerbutton.dart';
import 'package:shop_app/shared/components/navigatorto.dart';
import 'package:shop_app/shared/components/text_from.dart';
import 'package:shop_app/shared/components/textbest.dart';

class RegisterScreen extends StatelessWidget {
   RegisterScreen({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    return BlocProvider(
      create: (context) => RegisterCubit(DioConsumer(dio: Dio())),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if(state is RegisterSuccessState){
            showToast(message: state.registerModel.message,state: ToastStates.SUCCESS);
            navigateAndFinish(context, LoginScreen());
          }
          if(state is RegisterFailureState){
            showToast(message: state.errorMessage,state: ToastStates.ERROR);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formState,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextBest(
                          text: "SIGNUP",
                          fontSize: 30.sp,
                        ),
                        SizedBox(
                          height: size.height * .01,
                        ),
                        TextBest(
                          text: "signup now to browse our hot offers",
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: size.height * .03,
                        ),
                        TextForm(
                          controller: nameController,
                          keyBoard: TextInputType.name,
                          hintText: 'Name',
                          prefixIcon:  Icon(
                            Icons.person,
                            color: Colors.grey,
                            size: 30.sp,
                          ),
                          hintStyle: TextStyle(
                            fontSize: 20.sp
                          ),
                        ),
                        SizedBox(
                          height: size.height * .03,
                        ),
                        TextForm(
                          controller: emailController,
                          keyBoard: TextInputType.emailAddress,
                          validate: (value) {
                            if (value == null ||
                                value.contains("@gmail.com") == false) {
                              return "Enter valid Email";
                            }
                            return null;
                          },
                          hintText: 'Email Address',
                          prefixIcon:  Icon(
                            Icons.email_outlined,
                            color: Colors.grey,
                            size: 30.sp,
                          ),
                          hintStyle:  TextStyle(
                            fontSize: 20.sp,
                          ),
                        ),
                        SizedBox(
                          height: size.height * .03,
                        ),
                        TextForm(
                          controller: passwordController,
                          keyBoard: TextInputType.visiblePassword,
                          validate: (value) {
                            if (value == null || value.length < 5) {
                              return "Enter valid Password";
                            }
                            return null;
                          },
                          hintText: 'Password',
                          prefixIcon:  Icon(
                            Icons.lock,
                            color: Colors.grey,
                            size: 30.sp,
                          ),
                          hintStyle: const TextStyle(
                            fontSize: 20,
                          ),
                          suffixIcon: RegisterCubit.get(context).suffix,
                          obscureText: RegisterCubit.get(context).isPassword,
                          onTap1: (){
                            RegisterCubit.get(context).changeShowPassword();
                          },
                        ),
                        SizedBox(
                          height: size.height * .04,
                        ),
                        TextForm(
                          controller: phoneController,
                          keyBoard: TextInputType.name,
                          hintText: 'Phone',
                          prefixIcon:  Icon(
                            Icons.phone_android,
                            color: Colors.grey,
                            size: 30.sp,
                          ),
                          hintStyle: TextStyle(
                              fontSize: 20.sp
                          ),
                        ),
                        SizedBox(
                          height: size.height * .03,
                        ),
                        state is RegisterLoadingState ? const Center(child: CircularProgressIndicator(),) :
                        ContainerButton(
                            text: "SIGNUP",
                            style: TextStyle(fontSize: 20.sp, color: Colors
                                .white),
                            onPressed: () {
                              if (_formState.currentState!.validate()) {
                               RegisterCubit.get(context).register(
                                   email: emailController.text,
                                   name: nameController.text,
                                   password: passwordController.text,
                                   phone: phoneController.text
                               );
                              }
                            }),
                        SizedBox(
                          height: size.height * .04,
                        ),
                        Row(
                          children: [
                            TextBest(text: "Don you have an account ?   "),
                            InkWell(
                                onTap: () {
                                  navigateAndFinish(context, LoginScreen());
                                },
                                child: TextBest(
                                  text: "LOGIN",
                                  color: Colors.blueAccent,
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
