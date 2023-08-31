// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout_screen.dart';


import 'package:shop_app/modules/shop_register/Register_Screen.dart';
import 'package:shop_app/shared/compoment/components.dart';
import 'package:shop_app/shared/compoment/costanse.dart';
import 'package:shop_app/shared/network/local/cash_helper.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ShopLoginScreen extends StatelessWidget {
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context)=>ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (context,state){
          if(state is ShopLoginSuccessState){
            if(state.loginModel.status==true)
              {
                print(state.loginModel.message);
                print(state.loginModel.data!.token);
                showToast(text: '${state.loginModel.message}',
                state:ToastState.SUCCES,
                );
                CacheHelper.saveData(key: 'token', value: state.loginModel.data!.token).then((value)
                {
                  token=state.loginModel.data!.token!;
                  print(token);
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
        builder: (context,state)
        {
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
                          'login',
                          style: Theme.of(context).textTheme.headline2?.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          ' Login now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Colors.grey,
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
                            if(formKey.currentState!.validate())
                            {
                            ShopLoginCubit.get(context).userLogin(
                            email: emailController.text,
                            password: passwordController.text,
                            );
                            }
                          },
                          obscureText:ShopLoginCubit.get(context).isPassword,
                          decoration: InputDecoration(
                            label: Text('Passworsd'),
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(
                              Icons.lock_clock_outlined,
                            ),
                            suffixIcon:Icon(
                              ShopLoginCubit.get(context).suffix,
                              //suffixPrsse(){},

                            ),

                          ),

                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        ConditionalBuilder(
                          condition:state is! ShopLoginLoadingState,
                          builder: (context)=>defulatButton(
                            function: ()
                            {
                              if(formKey.currentState!.validate())
                                {
                                  ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                            },
                            text: 'login',
                            isUpperCase: true,
                          ),
                          fallback:(context)=> Center(child: CircularProgressIndicator()),

                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            TextButton(
                              onPressed: ()
                              {
                                navigateTo(
                                  context,
                                  ShopRegisterScreen(),
                                );
                              },
                              child:Text(
                                'Regester now',
                                style:TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
//
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
