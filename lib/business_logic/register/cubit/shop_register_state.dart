part of 'shop_register_cubit.dart';

@immutable
abstract class ShopRegisterState {}

class ShopRegisterInitial extends ShopRegisterState {}

class ShopRegisterLoadingState extends ShopRegisterState{}
class ShopRegisterSuccessState extends ShopRegisterState{
  final ShopLoginModel loginModel;

  ShopRegisterSuccessState(this.loginModel);
}
class ShopRegisterErrorState extends ShopRegisterState{
  final String error;

  ShopRegisterErrorState(this.error);

}

class ShopRegisterPasswordVisibilityState extends ShopRegisterState{}