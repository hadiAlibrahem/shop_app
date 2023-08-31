import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/shared/compoment/costanse.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remot/dio_helper.dart';

class ShopSearchCubit extends Cubit<ShopSearchStates>{

   ShopSearchCubit(): super(ShopSearchInitialState());


  static ShopSearchCubit get(context)=> BlocProvider.of(context);
  SearchModel ? model;

   void getSearch(String text)
   {

     emit(ShopSearchLoadingState());
     DioHelper.postData(
         url: SEARCH,
         token: token,
         data: {
           'text':text,
         },
     ).then((value){
       model=SearchModel.fromJson(value?.data);
       emit(ShopSearchSuccessState());
     }).catchError((error)
     {
       print(error.toString());
       emit(ShopSearchErrorState());
     });
   }

}