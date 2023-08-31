// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout_screen.dart';
import 'package:shop_app/modules/shop_login/cubit/cubit.dart';
import 'package:shop_app/modules/shop_register/cubit/cubit.dart';
import 'package:shop_app/modules/shop_register/cubit/states.dart';
import 'package:shop_app/shared/compoment/components.dart';
import 'package:shop_app/shared/compoment/costanse.dart';
import 'package:shop_app/shared/network/local/cash_helper.dart';

class ShopRegisterScreen extends StatelessWidget {
  var formKey=GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
        listener: (context,state){

          if(state is ShopRegisterSuccessState){
            if(state.loginModel.status==true)
            {
              print(state.loginModel.message);
              print(state.loginModel.data?.token);
              showToast(text: '${state.loginModel.message}',
                state:ToastState.SUCCES,
              );
              CacheHelper.saveData(key: 'token', value: state.loginModel.data?.token).then((value)
              {
                token=state.loginModel.data!.token!;
              navigateAndFinish(context, ShopLayout(),);
              }
              );
            }else
            {
              print(state.loginModel.message);
              showToast(text: '${state.loginModel.message}',
                state:ToastState.ERROR,
              );
            }
          }
        },
        builder: (context,state){
          return  Scaffold(

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
                          'register',
                          style: Theme.of(context).textTheme.headline2?.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          ' Register now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        TextFormField(

                          controller: nameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ('pleas emter your name');
                            }
                          },
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(

                            label: Text('name'),
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(
                              Icons.person,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        TextFormField(

                          controller: emailController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ('pleas emter your email address');
                            }
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(

                            label: Text('Email Address'),
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(
                              Icons.email_outlined,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                          //suffixPressed:(){},
                          controller: passwordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ('password is too short');
                            }
                          },
                          keyboardType: TextInputType.visiblePassword,

                          onFieldSubmitted: (value)
                          {
//                            if(formKey.currentState!.validate())
//                            {
//                            ShopLoginCubit.get(context).userLogin(
//                            email: emailController.text,
//                            password: passwordController.text,
//                            );
//                            }
                          },
                          obscureText:ShopRegisterCubit.get(context).isPassword,
                          decoration: InputDecoration(
                            label: Text('Passworsd'),
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(
                              Icons.lock_clock_outlined,
                            ),
                            suffixIcon:Icon(
                              ShopRegisterCubit.get(context).suffix,
                              //suffixPrsse(){},

                            ),

                          ),

                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                          //suffixPressed:(){},
                          controller: phoneController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ('phone is too short');
                            }
                          },
                          keyboardType: TextInputType.phone,

                          onFieldSubmitted: (value)
                          {

                          },
                          //  obscureText:ShopLoginCubit.get(context).isPassword,
                          decoration: InputDecoration(
                            label: Text('phone number'),
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(
                              Icons.phone,
                            ),
                            // suffixIcon:Icon(
                            //ShopLoginCubit.get(context).suffix,
                            //suffixPrsse(){},

                          ),

                        ),
                        SizedBox(
                          height: 15.0,
                        ),


                        ConditionalBuilder(
                          condition:state is! ShopRegisterLoadingState,
                          builder: (context)=>defulatButton(
                            function: ()
                            {
                              if(formKey.currentState!.validate())
                              {
                              ShopRegisterCubit.get(context).userRegister(
                              name:  nameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              phone:phoneController.text,
                              );
                              }
                            },
                            text: 'register',
                            isUpperCase: true,
                          ),
                          fallback:(context)=> Center(child: CircularProgressIndicator()),

                        ),

//
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
