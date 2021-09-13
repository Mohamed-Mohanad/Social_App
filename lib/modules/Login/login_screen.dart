import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honda_app/modules/Home/home_screen.dart';
import 'package:honda_app/modules/Login/login_cubit.dart';
import 'package:honda_app/modules/Register/register_screen.dart';
import 'package:honda_app/shared/bloc/cubit.dart';
import 'package:honda_app/shared/components/compnents.dart';
import 'package:honda_app/shared/components/conestants.dart';
import 'package:honda_app/shared/network/local/cache_helper.dart';

import 'login_cubit_states.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            showToast(
              text: state.error,
              state: ToastStates.ERROR,
            );
          }
          if (state is LoginSuccessState) {
            CacheHelper.saveData(
              key: 'uId',
              value: state.uId,
            ).then((value) {
              uId = state.uId;
              AppCubit.get(context).getUserData();
              navigateAndFinish(
                context,
                HomeScreen(),
              );
              showToast(
                text: "Login Successfully",
                state: ToastStates.SUCCESS,
              );
            });
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);

          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "LOGIN",
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    fontFamily: "Jannah",
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Text(
                          "Login now to communicate with friends",
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontFamily: "Jannah",
                                    color: Colors.grey,
                                  ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter your email address';
                            }
                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                            isPassword: cubit.isPassword,
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'password is too short';
                              }
                            },
                            onSubmit: (value) {
                              if (formKey.currentState!.validate()) {
                                cubit.userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            label: 'Password',
                            prefix: Icons.lock_outlined,
                            suffix: cubit.suffix,
                            suffixPressed: () {
                              cubit.changePasswordVisibility();
                            }),
                        SizedBox(
                          height: 30.0,
                        ),
                        state is! LoginLoadingState
                            ? defaultButton(
                                isUpperCase: true,
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.userLogin(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                },
                                text: 'login',
                              )
                            : Center(
                                child: CircularProgressIndicator(),
                              ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\`t have an account?',
                            ),
                            defaultTextButton(
                              function: () {
                                navigateTo(
                                  context,
                                  RegisterScreen(),
                                );
                              },
                              text: 'register',
                            ),
                          ],
                        )
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
