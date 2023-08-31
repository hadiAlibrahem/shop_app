// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:shop_app/layout/shop_cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/chang_favorites_model.dart';
import 'package:shop_app/models/chang_favorites_model.dart';
import 'package:shop_app/models/favorites_model.dart';

import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/catogaries/catogaries_Screen.dart';
import 'package:shop_app/modules/favorites/favorites_Screen.dart';
import 'package:shop_app/modules/produtes/productes_Screen.dart';
import 'package:shop_app/modules/settings/settings_Screen.dart';
import 'package:shop_app/shared/compoment/costanse.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remot/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates>{

  ShopCubit():super(InitialState());

 static ShopCubit get(context)=>BlocProvider.of(context);

 int currentIndex=0;
 List<Widget>bottomScreens=[
   ProductsScreen(),
  CategoriesScreen(),
  FavoritesScreen(),
   SettingsScreen(),

 ];
 void chanBottom(int index)
 {
   currentIndex=index;
   emit(ChangBottomNavBarState());
 }

 HomeModel  ? homeModel;
 Map<int,bool>favorites={};

 void getHomeData()
 {
   emit(ShopLoadingHomeDataState());
   DioHelper.getData(
       url: HOME,
       token:token,
   ).then((value){
     homeModel=HomeModel.fromJson(value!.data);
    // print(homeModel?.status);
    // print(homeModel?.data?.banners[0].id);

     homeModel!.data!.products.forEach((element)
     {
       favorites.addAll({
         element.id : element.inFavorites,
       });
     });
     print(favorites.toString());
     emit(ShopSuccessHomeDataState());
   }).catchError((error){
     print(error.toString());
     emit(ShopErrorHomeDataState());
   });



 }



  CategoriesModel ? categoriesModel;
  void getCategories()
  {
    DioHelper.getData(
      url: Get_CATEGORIES,


    ).then((value){
      categoriesModel=CategoriesModel.fromJson(value!.data);


      emit(ShopSuccessCategoriesState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });



  }

  changeFavoritesModel ? changefavoritesModel;
  void changFavorites(int productId)
  {
    favorites[productId]= !favorites[productId]!;
    emit(ShopChangFavoritesState());
    DioHelper.postData(
        url: FAVORITES,
      data: {
        "product_id": productId,
      },
      token:token,
    ).then((value)  {

    changefavoritesModel=changeFavoritesModel.fromJson(value!.data);

      if(changefavoritesModel?.status==false){
  favorites[productId]= !favorites[productId]!;
  }else
    {
      getFavorites();
    }

  emit(ShopSuccessChangFavoritesState(changefavoritesModel));
    }).catchError((error)
    {
    favorites[productId]= !favorites[productId]!;

    emit(ShopErrorChangFavoritesState());

    });
  }


  FavoritesModel ? favoritesModel;
  void getFavorites()
  {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
      url:FAVORITES,
      token:token,

    ).then((value){
      favoritesModel=FavoritesModel.fromJson(value?.data);



      emit(ShopSuccessGetFavoritesState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });



  }


  ShopLoginModel ? userModel;
  void getUserData()
  {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      url:PROFILE,
      token:token,

    ).then((value){
      userModel=ShopLoginModel.formJson(value!.data);
      printFullText(userModel!.data!.name!);


      emit(ShopSuccessUserDataState(userModel));
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorUserDataState());
    });



  }

  ShopLoginModel ? updateModel;
  void updateUserData({

    required String name,
    required String email,
    required String phone,
})
  {
    emit(ShopLoadingUpdateUserState());
    DioHelper.putData(
      url:UPDATE_PROFILE,
      token:token,
      data: {
        'name':name,
        'email':email,
        'phone':phone,
      },

    ).then((value){
      updateModel=ShopLoginModel.formJson(value!.data);
     print(updateModel!.data!.name);

      emit(ShopSuccessUpdateUserState(updateModel));
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorUpdateUserState());
    });



  }


}