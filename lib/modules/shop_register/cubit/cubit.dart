// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/shop_login/cubit/states.dart';
import 'package:shop_app/modules/shop_register/cubit/states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remot/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>{

  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context)=>BlocProvider.of(context);
  ShopLoginModel ?loginModel;

  void userRegister({
  required String name,
  required String email,
  required String password,
  required String phone,
})
  {
    emit(ShopRegisterLoadingState());
  DioHelper.postData(
      url: REGISTER,
      data: {
        'name':name,
        'email':email,
        'password':password,
        'phone':phone,
      },
  ).then((value)
  {
    loginModel=ShopLoginModel.formJson(value?.data);
//   print(loginModel?.status);
//   print(loginModel?.message);
//   print(loginModel?.data?.token);
    emit(ShopRegisterSuccessState(loginModel!));
  }).catchError((error)
  {
    print(error.toString());
    emit(ShopRegisterErrorState(error.toString()));
  });
  }

  IconData suffix=Icons.visibility_outlined;
  bool isPassword=true;
  void changPasswordVisibility()
  {
    isPassword=!isPassword;
    suffix =isPassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(ShopRegisterChangPasswordVisibilityState());
  }
}