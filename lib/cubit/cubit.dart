import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/shared/network/local/cash_helper.dart';


class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(AppInitialState());
  static AppCubit get(context)=> BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screen = [
    //NewTasksScreen(),
    //DoneTasksScreen(),
   // ArchiveTasksScreen(),
  ];
  List<String> titel = [
    'new tasks',
    'done tasks',
    'archive tasks',
  ];
void changIndex(int index){
  currentIndex=index;
  emit(AppChangBottomNavBarState());
}
  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;
  void AppChangBottomShetState({
  required bool isShow,
  required IconData icno,
})
  {
    isBottomSheetShown=isShow;
    fabIcon=icno;
    emit(AppChangBottomSheetState());
  }

  bool isDark =false;
  void changAppMode({bool ?fromShared})
  {
  if(fromShared!=null) {
    isDark=fromShared;
    emit(AppChangModeState ());
  } else {
    isDark = !isDark;
    CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
      emit(AppChangModeState());
    });
  }
  }



}




