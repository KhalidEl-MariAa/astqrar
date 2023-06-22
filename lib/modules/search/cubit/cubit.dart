import 'dart:developer';

import '../../../models/user_item.dart';
import 'states.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);
  
  List<UserItem> searchResult = [];

  void searchByText({required String text}) 
  {
    searchResult = [];
    emit(GetSearchLoadingState());

    DioHelper.getDataWithQuery(
      url: SEARCH, 
      query: {"search": text}
    
    ).then((value) {

      log("${searchResult.length} are found");

      searchResult.clear();
      value.data['data'].forEach((e) {
        searchResult.add( UserItem.fromJson(e) );
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
        searchResult.add( UserItem.fromJson(e) );
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
