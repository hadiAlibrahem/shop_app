
// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_cubit/cubite.dart';
import 'package:shop_app/layout/shop_cubit/states.dart';
import 'package:shop_app/modules/search/search_Screen.dart';
import 'package:shop_app/modules/shop_login/shop_login_screen.dart';
import 'package:shop_app/shared/compoment/components.dart';
import 'package:shop_app/shared/network/local/cash_helper.dart';

class ShopLayout extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Salla',
            ),
            actions: [
              IconButton(
                onPressed: ()
                {
                  navigateTo(context, SearchScreen(),);
                },
                icon:Icon(Icons.search),
              ),
            ],
          ),
          body:cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index)
            {
              cubit.chanBottom(index);
            },
            currentIndex: cubit.currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',

              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.apps),
                label: 'Catogaries',

              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorites',

              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',

              ),
            ],
          ),
        );
      },

    );
  }
}
