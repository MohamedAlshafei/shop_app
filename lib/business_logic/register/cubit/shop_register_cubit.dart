import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../components/constants.dart';
import '../../../model/shop_login_model.dart';
import '../../network/dio_helper.dart';

part 'shop_register_state.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterState> {
  ShopRegisterCubit() : super(ShopRegisterInitial());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  // late final
  ShopLoginModel? loginModel;

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(ShopRegisterLoadingState());

    DioHelper.postData(url: register, data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
    }).then((value) {
      try {
        loginModel = ShopLoginModel.fromJson(value.data);
        emit(ShopRegisterSuccessState(loginModel!));
      } catch (e) {
        print(e.toString());
      }
    }).catchError((error) {
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  Widget suffix = const Icon(Icons.visibility_outlined);
  bool isPassword = true;

  void changePasswordVisibilty() {
    isPassword = !isPassword;

    suffix = isPassword
        ? const Icon(Icons.visibility_outlined)
        : const Icon(Icons.visibility_off_outlined);

    emit(ShopRegisterPasswordVisibilityState());
  }
}
