// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_cubit/cubite.dart';
import 'package:shop_app/layout/shop_cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/shared/compoment/components.dart';

// ignore: use_key_in_widget_constructors
class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  return BlocConsumer<ShopCubit,ShopStates>(
     listener:(context,state){},
    builder:(context,state){
    return ListView.separated(
          itemBuilder: (context,index)=>buildCategoriesItem(ShopCubit.get(context).categoriesModel!.data!.data[index]),
          separatorBuilder: (context,index)=>myDiveder(),
          itemCount: ShopCubit.get(context).categoriesModel!.data!.data.length,
      );
  },);
  }
  Widget buildCategoriesItem(DataModel model)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(
          image: NetworkImage(
            model.image!,
          ),
          fit: BoxFit.cover,
          width: 80.0,
          height: 80.0,
        ),
        SizedBox(
          width: 20.0,
        ),
        Text(
          model.name!,
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        Icon(
          Icons.arrow_forward_ios,
        ),
      ],
    ),
  );
}
