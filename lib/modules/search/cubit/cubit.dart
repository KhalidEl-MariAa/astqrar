import 'dart:developer';

import '../../../models/user_item.dart';
import 'states.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  //late LoginModel loginModel;
  static SearchCubit get(context) => BlocProvider.of(context);
  

  // late GetSearchModel getSearchModel;
  bool searchDone = false;
  bool getSearch = false;
  List<UserItem> searchResult = [];

  searchByText({required String text}) 
  {
    
    getSearch = false;
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

      searchDone = true;
      emit(GetSearchSuccessState(searchResult));

    }).catchError((error) {
      log(error.toString());
      emit(GetSearchErrorState(error.toString()));
    });
  }

    searchByFilter(Map query) 
    {
    
      log(query.toString());

      emit(FilterSearchLoadingState());

      DioHelper.postData(
        url: FILTERSEARCH, 
        data: query,
      ).then((value) {
        // log(value.toString());
        searchResult.clear();
        value.data['data'].forEach((e) {
          searchResult.add( UserItem.fromJson(e) );
        });

        log("${searchResult.length} are found !!");
        searchDone = true;

        emit(FilterSearchSuccessState(searchResult));
        emit(GetSearchSuccessState(searchResult));


      }).catchError((error) {
        log(error.toString());
        emit(FilterSearchErrorState(error.toString()));
      });
  }
}
