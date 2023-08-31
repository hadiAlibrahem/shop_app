import 'package:shop_app/models/chang_favorites_model.dart';
import 'package:shop_app/models/login_model.dart';

abstract class ShopStates{}

class InitialState extends ShopStates{}

class ChangBottomNavBarState extends ShopStates{}

class ShopLoadingHomeDataState extends ShopStates{}

class ShopSuccessHomeDataState extends ShopStates{}

class ShopErrorHomeDataState extends ShopStates{}


class ShopSuccessCategoriesState extends ShopStates{}

class ShopErrorCategoriesState extends ShopStates{}


class ShopChangFavoritesState extends ShopStates{}

class ShopSuccessChangFavoritesState extends ShopStates{
  final changeFavoritesModel ? model;

  ShopSuccessChangFavoritesState(this.model);
}

class ShopErrorChangFavoritesState extends ShopStates{}

class ShopLoadingGetFavoritesState extends ShopStates{}

class ShopSuccessGetFavoritesState extends ShopStates{}

class ShopErrorGetFavoritesState extends ShopStates{}


class ShopLoadingUserDataState extends ShopStates{}

class ShopSuccessUserDataState extends ShopStates{
  final ShopLoginModel ?loginModel;

  ShopSuccessUserDataState(this.loginModel);
}

class ShopErrorUserDataState extends ShopStates{}


class ShopLoadingUpdateUserState extends ShopStates{}

class ShopSuccessUpdateUserState extends ShopStates{
  final ShopLoginModel ?loginModel;

  ShopSuccessUpdateUserState(this.loginModel);
}

class ShopErrorUpdateUserState extends ShopStates{}