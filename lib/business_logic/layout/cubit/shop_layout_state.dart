part of 'shop_layout_cubit.dart';

@immutable
abstract class ShopLayoutState {}

class ShopLayoutInitial extends ShopLayoutState {}

class ShopChangeBottonNavBarState extends ShopLayoutState{}

class ShopLoadingHomeDataState extends ShopLayoutState{}

class ShopSuccessHomeDataState extends ShopLayoutState{}

class ShopErrorHomeDataState extends ShopLayoutState{}

class ShopSuccessCategoriesState extends ShopLayoutState{}
class ShopErrorCategoriesState extends ShopLayoutState{}

class ShopSuccessChangeFavoritesState extends ShopLayoutState{
  ChangeFavoritesModel? model;
  ShopSuccessChangeFavoritesState(this.model);

}
class ShopChangeFavoritesState extends ShopLayoutState{}
class ShopErrorChangeFavoritesState extends ShopLayoutState{}


class ShopLoadingUserDataState extends ShopLayoutState{}
class ShopSuccessUserDataState extends ShopLayoutState{
  final ShopLoginModel loginModel;
  ShopSuccessUserDataState(this.loginModel);
}
class ShopErrorUserDataState extends ShopLayoutState{}

class ShopLoadingUpdateUserDataState extends ShopLayoutState{}
class ShopSuccessUpdateUserDataState extends ShopLayoutState{
  final ShopLoginModel loginModel;
  ShopSuccessUpdateUserDataState(this.loginModel);
}
class ShopErrorUpdateUserDataState extends ShopLayoutState{}

