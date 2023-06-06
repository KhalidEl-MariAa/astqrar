import 'dart:developer';

import '../../../models/get_search_model.dart';
import 'states.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  //late LoginModel loginModel;
  static SearchCubit get(context) => BlocProvider.of(context);
   var searchTextController = TextEditingController();

  late GetSearchModel getSearchModel;
  bool searchDone=false;
  bool getSearch=false;
  List<DataOfUserDetailsModel> searchList=[];

  search({required String text}){
    getSearch=false;
    searchList=[];
    emit(GetSearchLoadingState());
    DioHelper.getDataWithQuery(url: SEARCH,query: {"search":text})
    .then((value) {
      log(value.toString());
      getSearchModel=GetSearchModel.fromJson(value.data);
      for(int i=0;i<getSearchModel.data.length;i++){
        searchList.add(getSearchModel.data[i]);
      }
      searchDone=true;
      emit(GetSearchSuccessState());
    }).catchError((error){
      log(error.toString());
      emit(GetSearchErrorState(error.toString()));
    });
  }

  //filter search
late GetSearchModel filterSearchModel;

filterSearch({
    required String textSearch,
  required  minHeight,
  required  maxHeight,
  required  minWeight,
  required  maxWeight,
  required  minAge,
  required  maxAge,
  String? jobType,
String ?skinColor,
   String ?illnessType,
  String? lastName,
   String? qualifications,
   String ?childern,
 String ?personality,
   int ?gender,
  String ?milirity,
  String?typeOfMarriage
}){
  searchList=[];
  log(lastName.toString());
    emit(FilterSearchLoadingState());
    DioHelper.postData(url: FILTERSEARCH, data:

    {
      "maritalStatus": milirity,
      "gender": gender??"0",
      "appearance": personality,
      "children": childern,
      "qualification": qualifications,
      "wifeLineage": lastName,
      "hasDiseases": illnessType,
      "skinSolour": skinColor,
      "workNature": jobType,
      "maxHeight": maxHeight??0,
      "minHeight": minHeight??0,
      "maxAge": maxAge??0,
      "minAge": minAge??0,
      "maxWeight": maxWeight??0,
      "minWeight": minWeight??0,
      "TextSearch":textSearch,
      "Typeofmarriage":typeOfMarriage
    }).then((value) {
      log(value.toString());
      filterSearchModel=GetSearchModel.fromJson(value.data);
      for(int i=0;i<filterSearchModel.data.length;i++){
        searchList.add(filterSearchModel.data[i]);
      }
      searchDone=true;
      emit(FilterSearchSuccessState());
    })
    .catchError((error){
     log(error.toString());
      emit(FilterSearchErrorState(error.toString()));
    });
}
}