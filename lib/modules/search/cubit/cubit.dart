import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/user.dart';
import '../../../end_points.dart';
import '../../../shared/network/remote.dart';
import 'states.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);
  
  List<User> searchResult = [];

  void searchByText({required String text}) 
  {
    searchResult = [];
    emit(GetSearchLoadingState());

    DioHelper.getDataWithQuery(
      url: SEARCHBYTEXT, 
      query: {"mytext": text}
    
    ).then((value) {

      log("${searchResult.length} are found");

      searchResult.clear();
      value.data['data'].forEach((e) {
        searchResult.add( User.fromJson(e) );
      });

      emit(GetSearchSuccessState(searchResult));

    }).catchError((error) {
      log(error.toString());
      emit(GetSearchErrorState(error.toString()));
    });
  }

  void searchByFilter(Map query) 
  {
  
    log(query.toString());

    emit(FilterSearchLoadingState());

    DioHelper.postData(
      url: FILTERSEARCH, 
      data: query,
    ).then((value) {
      searchResult.clear();
      value.data['data'].forEach((e) {
        searchResult.add( User.fromJson(e) );
      });

      log("${searchResult.length} are found !!");

      emit(FilterSearchSuccessState(searchResult));
      emit(GetSearchSuccessState(searchResult));


    }).catchError((error) {
      log(error.toString());
      emit(FilterSearchErrorState(error.toString()));
    });
}
}
