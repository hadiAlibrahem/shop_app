// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/shop_login/cubit/states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remot/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>{

  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context)=>BlocProvider.of(context);

  ShopLoginModel ?loginModel;

  void userLogin({
  required String email,
  required String password,
})
  {
    emit(ShopLoginLoadingState());
  DioHelper.postData(
      url: LOGIN,
      data: {
        'email':email,
        'password':password,
      },
  ).then((value)
  {

    loginModel=ShopLoginModel.formJson(value?.data);
//   print(loginModel?.status);
//   print(loginModel?.message);
//   print(loginModel?.data?.token);
    emit(ShopLoginSuccessState(loginModel!));
  }).catchError((error)
  {
    print(error.toString());
    emit(ShopLoginErrorState(error.toString()));
  });
  }

  IconData suffix=Icons.visibility_outlined;
  bool isPassword=true;
  void changPasswordVisibility()
  {
    isPassword=!isPassword;
    suffix =isPassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(ShopChangPasswordVisibilityState());
  }
}