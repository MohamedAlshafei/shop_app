import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/model/shop_login_model.dart';

import '../../../components/constants.dart';
import '../../network/dio_helper.dart';

part 'shop_login_state.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitial());

  static ShopLoginCubit get(context) => BlocProvider.of(context);
  // late final
  ShopLoginModel? loginModel;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingState());

    DioHelper.postData(url: login, data: {
      'email': email,
      'password': password,
    }).then((value) {
      try {
        loginModel = ShopLoginModel.fromJson(value.data);
        emit(ShopLoginSuccessState(loginModel!));
      } catch (e) {
        print(e.toString());
      }
    }).catchError((error) {
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  Widget suffix = const Icon(Icons.visibility_outlined);
  bool isPassword = true;

  void changePasswordVisibilty() {
    isPassword = !isPassword;

    suffix = isPassword
        ? const Icon(Icons.visibility_outlined)
        : const Icon(Icons.visibility_off_outlined);

    emit(ShopLoginPasswordVisibilityState());
  }
}
