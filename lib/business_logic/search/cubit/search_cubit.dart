import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/business_logic/network/dio_helper.dart';

import '../../../components/constants.dart';
import '../../../model/search_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  static SearchCubit get(context)=>BlocProvider.of(context);

  SearchModel? model;

  void searchProduct({required String text}){

    emit(SearchLoadingState());

    DioHelper.postData(
      url: search, 
      token: token,
      data: {
        'text':text,
      }
      ).then((value) => {
        
          model= SearchModel.fromJson(value.data),
          emit(SearchSuccesState()),
        
        
      }).catchError((error){
        print(error.toString());
        emit(SearchErrorState());
      });

  }
}
