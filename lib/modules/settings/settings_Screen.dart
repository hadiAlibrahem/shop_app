// ignore_for_file: file_names, prefer_const_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_cubit/cubite.dart';
import 'package:shop_app/layout/shop_cubit/states.dart';
import 'package:shop_app/shared/compoment/components.dart';
import 'package:shop_app/shared/compoment/costanse.dart';

// ignore: use_key_in_widget_constructors
class SettingsScreen extends StatelessWidget {
  @override
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var model = ShopCubit.get(context).userModel!;
          nameController.text = model.data!.name!;
          emailController.text = model.data!.email!;
          phoneController.text = model.data!.phone!;

          return ConditionalBuilder(
            condition: ShopCubit.get(context).userModel != null,
            builder: (context) => Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if(state is ShopLoadingUpdateUserState)
                    LinearProgressIndicator(),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      //suffixPressed:(){},
                      controller: nameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ('name  must not be empty');
                        }
                        return null;
                      },
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        label: Text('Name'),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.person,
                        ),

                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                        //suffixPressed:(){},
                        controller: emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ('Email Address  must not be empty');
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,

//        onFieldSubmitted: (value)
//        {
//          if(formKey.currentState!.validate())
//          {
//          ShopLoginCubit.get(context).userLogin(
//          email: emailController.text,
//          //password: passwordController.text,
//          );
//          }

                        //obscureText:ShopLoginCubit.get(context).isPassword,
                        decoration: InputDecoration(
                          label: Text('Email Address'),
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(
                            Icons.email,
                          ),
//                    suffixIcon:Icon(
//                      Icons.remove_red_eye,
//                  ),
                        )),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      //suffixPressed:(){},
                      controller: phoneController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ('phone  must not be empty');
                        }
                        return null;
                      },
                      keyboardType: TextInputType.phone,

//        onFieldSubmitted: (value)
//        {
//          if(formKey.currentState!.validate())
//          {
//          ShopLoginCubit.get(context).userLogin(
//          email: emailController.text,
//          //password: passwordController.text,
//          );
//          }

                      //obscureText:ShopLoginCubit.get(context).isPassword,
                      decoration: InputDecoration(
                        label: Text('phone'),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.phone,
                        ),
//          suffixIcon:Icon(
//            ShopLoginCubit.get(context).suffix,
//            //suffixPrsse(){},
//
//          ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    defulatButton(
                        text: 'update',
                        isUpperCase: true,
                        function: () {
                          if (formKey.currentState!.validate()) {
                            ShopCubit.get(context).updateUserData(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                            );
                          }
                        }),
                    SizedBox(
                      height: 20.0,
                    ),
                    defulatButton(
                        text: 'logout',
                        isUpperCase: true,
                        function: () {
                          signOut(context);
                        }),
                  ],
                ),
              ),
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );
        });
  }
}
