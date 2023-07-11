import 'dart:developer';

import '../../../models/server_response_model.dart';
import '../../home/layout/cubit/cubit.dart';
import 'states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';
import '../../../end_points.dart';
import '../../../models/user.dart';
import '../../../shared/network/remote.dart';
import '../section_men_women.dart';

class MenWomenCubit extends Cubit<MenWomenStates> 
{
  MenWomenCubit() : super(MenWomenInitialState());

  //late LoginModel loginModel;
  static MenWomenCubit get(context) => BlocProvider.of(context);

  
  List<User> users = [];

  //change one section
  int? startAge;
  int? endAge;
  String typeOfMarriage = "";
  List<int> countryIds = [];

  getUserByGender({required int genderValue}) 
  {
    ServerResponse res;
    users = [];
    emit(MenWomenLoadingState());
    
    DioHelper.getDataWithQuery(
        url: GETUSERSBYGENDER,
        token: TOKEN.toString(),
        query: {"gender": genderValue})
    .then((value) {

      res = ServerResponse.fromJson(value.data);

      for (var u in res.data) 
      {
        User user = User.fromJson(u);
        users.add(user);
      }
      startAge=null;
      endAge=null;
      countryIds=[];
      typeOfMarriage="";

      log(users.length.toString() + " Found !!");

      emit(MenWomenSuccessState());
    }).catchError((error) {
      log(error.toString());
      emit(MenWomenErrorState(error.toString()));
    });
  }


  changeindexonesection({required int index, required String gender}) 
  {
    if(SectionMenOrWomen.oneIndexSection == index) 
      return;

    SectionMenOrWomen.oneIndexSection = index;
    if (SectionMenOrWomen.oneIndexSection == 0) {
      typeOfMarriage = "";
    }
    if (SectionMenOrWomen.oneIndexSection == 1) {
      typeOfMarriage = "علني";
    }
    if (SectionMenOrWomen.oneIndexSection == 2) {
      typeOfMarriage = "تعدد";
    }
    if (SectionMenOrWomen.oneIndexSection == 3) {
      typeOfMarriage = "مسيار";
    }
    getUsersByQuickFilter(gender: gender);
    
  }

  changeindextwosection({required int index, required String gender}) 
  {
    // log(index.toString());
    if(SectionMenOrWomen.twoIndexSection == index)
      return;

    SectionMenOrWomen.twoIndexSection = index;
    if (SectionMenOrWomen.twoIndexSection == 0) {
      startAge = null;
      endAge = null;
    }
    if (SectionMenOrWomen.twoIndexSection == 1) {
      startAge = 18;
      endAge = 30;
    }
    if (SectionMenOrWomen.twoIndexSection == 2) {
      startAge = 30;
      endAge = 40;
    }
    if (SectionMenOrWomen.twoIndexSection == 3) {
      startAge = 40;
      endAge = 50;
    }
    getUsersByQuickFilter(gender: gender);
    
  }

  changeindexthreesection({required int index, required String gender}) 
  {
    // log(index.toString());
    if(SectionMenOrWomen.threeIndexSection == index)
      return;

    SectionMenOrWomen.threeIndexSection = index;
    if (SectionMenOrWomen.threeIndexSection == 0) {
      countryIds = [];
    }
    if (SectionMenOrWomen.threeIndexSection == 1) {
      countryIds = [3];
    }
    if (SectionMenOrWomen.threeIndexSection == 2) {
      countryIds = LayoutCubit.Countries
                        .where((c) => c.id != 3)
                        .map((e) => e.id!)
                        .toList();
    }
    getUsersByQuickFilter(gender: gender);
    
  }

  //filter
  getUsersByQuickFilter({required String gender}) 
  {
    ServerResponse res;
    users = [];
    log(startAge.toString());
    emit(QuickFilterLoading());

    DioHelper.postDataWithBearearToken(
      url: QUICKFILTER,
      data: {
        "gender": gender,
        "startAge": startAge,
        "EndAge": endAge,
        "typeofmarriage": typeOfMarriage,
        "countryIds": countryIds
      },
      token: TOKEN.toString()
    ).
    then( (value) 
    {
      // log(value.toString());
      res = ServerResponse.fromJson(value.data);
      for (var u in res.data) 
      {
        User user = User.fromJson(u);
        users.add(user);
      }
      // log(users.length.toString());
      emit(QuickFilterSuccess());

    }).catchError((error) {
      log(error.toString());
      emit(QuickFilterError(error.toString()));
    });
  }
}
