import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/business_logic/network/dio_helper.dart';
import 'package:shop_app/components/constants.dart';

import '../../../model/categories_model.dart';
import '../../../model/change_favorites_model.dart';
import '../../../model/home_model.dart';
import '../../../model/shop_login_model.dart';
import '../../../presentation/screens/categories_screen.dart';
import '../../../presentation/screens/favorites_screen.dart';
import '../../../presentation/screens/products_screen.dart';
import '../../../presentation/screens/search_screen.dart';
import '../../../presentation/screens/settings_screen.dart';

part 'shop_layout_state.dart';

class ShopLayoutCubit extends Cubit<ShopLayoutState> {
  ShopLayoutCubit() : super(ShopLayoutInitial());

  static ShopLayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreen =  [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottonNavBarState());
  }

  HomeModel? homeModel;
  Map<int, bool> favorites={};
  ChangeFavoritesModel? changeFavoritesModel;

  void getHomeData() async {
    emit(ShopLoadingHomeDataState());

    await DioHelper.getData(url: home, token: token).then(
      (value) {
        try {
          homeModel = HomeModel.fromJson(value.data);

          homeModel!.data!.products!.forEach((element) {
            favorites.addAll({
              element.id as int : element.inFavorites as bool,
            });
          });
          print(favorites.toString());
          emit(ShopSuccessHomeDataState());
        } catch (e) {
          // print('--------------------------------');
          print(e.toString());
          // print('--------------------------------');
        }
      },
    ).catchError(
      (error) {
        // print('--------------------------------');
        // print('--------------------------------');
        print(error.toString());
        emit(ShopErrorHomeDataState());
        // print('--------------------------------');
        // print('--------------------------------');
      },
    );
  }

  CategoriesModel? categoriesModel;
  void getCategoryData()async{
    await DioHelper.getData(url: getCategory,token: token).then((value) {
      try {
        categoriesModel= CategoriesModel.fromJson(value.data);
        print(categoriesModel!.data);
        emit(ShopSuccessCategoriesState());
      }catch(e){
        print('--------------------------------');
        print(e.toString());
        print('--------------------------------');
      }
    }).catchError((error){
      // print('--------------------------------');
      // print('--------------------------------');
      print(error.toString());
      // print('--------------------------------');
      // print('--------------------------------');
      emit(ShopErrorCategoriesState());
    });
  }

  void changeFavorites(dynamic productId){

    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeFavoritesState());

    DioHelper.postData(
      url: favorite, 
      data: {
        'product_id': productId
      },
      token: token,
      ).then((value) {
        print(token.toString());
        changeFavoritesModel= ChangeFavoritesModel.fromJson(value.data);

        if(!changeFavoritesModel!.status!){
          favorites[productId] = !favorites[productId]!;
        }
        emit(ShopSuccessChangeFavoritesState(changeFavoritesModel));
      }).catchError((error){
        favorites[productId] = !favorites[productId]!;
        emit(ShopErrorChangeFavoritesState());
      });
  }

  ShopLoginModel? userModel;

  void getUserData() async {
    emit(ShopLoadingUserDataState());

    await DioHelper.getData(url: profile, token: token).then(
      (value) {
        try {
          userModel = ShopLoginModel.fromJson(value.data);
          printFullText(userModel!.data!.name!);
          print('__________________________________________');
          emit(ShopSuccessUserDataState(userModel!));
        } catch (e) {
          print('--------------------------------');
          print(e.toString());
          print('--------------------------------');
        }
      },
    ).catchError(
      (error) {
        // print('--------------------------------');
        // print('--------------------------------');
        print(error.toString());
        emit(ShopErrorUserDataState());
        // print('--------------------------------');
        // print('--------------------------------');
      },
    );
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) async {
    emit(ShopLoadingUpdateUserDataState());

    await DioHelper.putData(
      url: updateProfile, 
      token: token,
      data: {
        'name':name,
        'email':email,
        'phone': phone,
      }
      ).then(
      (value) {
        try {
          userModel = ShopLoginModel.fromJson(value.data);
          printFullText(userModel!.data!.name!);
          print('__________________________________________');
          emit(ShopSuccessUpdateUserDataState(userModel!));
        } catch (e) {
          print('--------------------------------');
          print(e.toString());
          print('--------------------------------');
        }
      },
    ).catchError(
      (error) {
        // print('--------------------------------');
        // print('--------------------------------');
        print(error.toString());
        emit(ShopErrorUpdateUserDataState());
        // print('--------------------------------');
        // print('--------------------------------');
      },
    );
  }
}
