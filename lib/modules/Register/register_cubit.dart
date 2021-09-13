import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honda_app/models/UserModel/userModel.dart';
import 'package:honda_app/modules/Register/register_cubit_states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {

      userCreate(
        email: email,
        phone: phone,
        name: name,
        uId: value.user!.uid,
      );

    }).catchError((error) {
      print("This is register error : " + error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) {
    UserModel userModel = UserModel(
      name: name,
      email: email,
      phone: phone,
      bio: 'write your bio ...',
      coverImage: 'https://image.freepik.com/free-photo/image-frightened-puzzled-guy-covers-mouth-stares-with-scared-expression-cannot-believe-his-eyes_273609-27649.jpg',
      personalImage: 'https://image.freepik.com/free-photo/bearded-young-self-confident-male-with-pleasant-appearance-dressed-blue-shirt-looks-directly-isolated-white-wall-handsome-man-freelancer-thinks-about-work-indoor_273609-16089.jpg',
      uId: uId,
      isEmailVerified: false,
    );

    FirebaseFirestore.instance.collection('users').doc(uId).set(userModel.toMap()).then((value){
      emit(RegisterCreateUserSuccessState());
    }).catchError((error){
      emit(RegisterCreateUserErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(RegisterChangePasswordVisibilityState());
  }
}
