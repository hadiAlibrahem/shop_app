// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/compoment/costanse.dart';
import 'package:shop_app/shared/style/themes.dart';

import 'cubit/cubit.dart';

import 'package:shop_app/modules/onBoarding/onBoarding_screen.dart';
import 'layout/shop_cubit/cubite.dart';
import 'layout/shop_cubit/states.dart';
import 'layout/shop_layout_screen.dart';
import 'modules/shop_login/shop_login_screen.dart';
import 'shared/network/local/cash_helper.dart';
import 'shared/network/remot/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  Widget  widget;
  bool ?isDark = CacheHelper.getData(key: 'isDark');
  bool ? onBoarding =CacheHelper.getData(key: 'OnBoarding');
  token =CacheHelper.getData(key: 'token')??"";
  print(token);
if(onBoarding!=null)
{
  if(token!=null) widget =ShopLayout();
  else widget =ShopLoginScreen();
}else{
  widget =OnBoardingScreen();
}
  var shared = await SharedPreferences.getInstance();

  runApp(MyApp(
      isDark:isDark,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool ?isDark;
  final Widget? startWidget;
  MyApp({
    this.isDark,
 this.startWidget,
});
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(

      providers: [
        BlocProvider(
         create: (BuildContext context)=>ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData(),
        ),
        BlocProvider(
         create: (BuildContext context)=>AppCubit(),
        ),
      ],
      child:
      BlocConsumer<ShopCubit, ShopStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );


  }
}
