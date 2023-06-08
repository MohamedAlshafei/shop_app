part of 'shop_login_cubit.dart';

@immutable
abstract class ShopLoginStates {}

class ShopLoginInitial extends ShopLoginStates {}

class ShopLoginLoadingState extends ShopLoginStates{}
class ShopLoginSuccessState extends ShopLoginStates{
  final ShopLoginModel loginModel;

  ShopLoginSuccessState(this.loginModel);
}
class ShopLoginErrorState extends ShopLoginStates{
  final String error;

  ShopLoginErrorState(this.error);

}

class ShopLoginPasswordVisibilityState extends ShopLoginStates{}
