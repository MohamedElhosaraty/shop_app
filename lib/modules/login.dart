import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/core/api/dio_consumer.dart';
import 'package:shop_app/cubit/login/login_cubit.dart';
import 'package:shop_app/layout/home.dart';
import 'package:shop_app/modules/register.dart';
import 'package:shop_app/shared/components/containerbutton.dart';
import 'package:shop_app/shared/components/navigatorto.dart';
import 'package:shop_app/shared/components/text_from.dart';
import 'package:shop_app/shared/components/textbest.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    return BlocProvider(
      create: (context) => LoginCubit(DioConsumer(dio: Dio())),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if(state is LoginSuccessState){
              showToast(message: state.loginModel.message,state: ToastStates.SUCCESS);
              navigateAndFinish(context, const HomeScreen());
          }
          if(state is LoginFailureState){
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
                          text: "LOGIN",
                          fontSize: 30,
                        ),
                        SizedBox(
                          height: size.height * .01,
                        ),
                        TextBest(
                          text: "login now to browse our hot offers",
                          color: Colors.grey,
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
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                            color: Colors.grey,
                            size: 30,
                          ),
                          hintStyle: const TextStyle(
                            fontSize: 20,
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
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.grey,
                            size: 30,
                          ),
                          hintStyle: const TextStyle(
                            fontSize: 20,
                          ),
                          suffixIcon: LoginCubit.get(context).suffix,
                          obscureText: LoginCubit.get(context).isPassword,
                          onTap1: (){
                            LoginCubit.get(context).changeShowPassword();
                          },
                        ),
                        SizedBox(
                          height: size.height * .04,
                        ),
                        state is LoginLoadedState ? const Center(child: CircularProgressIndicator(),) :
                        ContainerButton(
                            text: "LOGIN",
                            style: const TextStyle(fontSize: 20, color: Colors
                                .white),
                            onPressed: () {
                              if (_formState.currentState!.validate()) {
                                LoginCubit.get(context).login(
                                    email: emailController.text,
                                    password: passwordController.text
                                );
                              }
                            }),
                        SizedBox(
                          height: size.height * .04,
                        ),
                        Row(
                          children: [
                            TextBest(text: "Don't have an account ?   "),
                            InkWell(
                                onTap: () {
                                  navigateAndFinish(context, RegisterScreen());
                                },
                                child: TextBest(
                                  text: "REGISTER",
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
