import 'dart:developer';

import 'package:astarar/models/get_users_by_filters.dart';
import 'package:astarar/models/get_users_by_gender.dart';
import 'package:astarar/modules/section%20men%20_women/cubit/states.dart';
import 'package:astarar/modules/section%20men%20_women/section_men_women.dart';
import 'package:astarar/shared/contants/contants.dart';
import 'package:astarar/shared/network/end_points.dart';
import 'package:astarar/shared/network/remote.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetUserByGenderCubit extends Cubit<GetUserByGenderStates> {
  GetUserByGenderCubit() : super(GetUserByGenderInitialState());

  //late LoginModel loginModel;
  static GetUserByGenderCubit get(context) => BlocProvider.of(context);

  late GetUsersByGengerModel getUsersByGengerModel;
  List users = [];
  bool getUsersByGenderDone = false;

  getUserByGender({required int genderValue}) {
    users = [];
    getUsersByGenderDone = false;
    emit(GetUserByGenderLoadingState());
    DioHelper.getDataWithQuery(
        url: GETUSERSBYGENDER,
        token: token.toString(),
        query: {"gender": genderValue}).then((value) {
      log(value.toString());
      getUsersByGengerModel = GetUsersByGengerModel.fromjson(value.data);
      for (int i = 0; i < getUsersByGengerModel.data.length; i++) {
        users.add(getUsersByGengerModel.data[i]);
        //log(users[i].age);
      }
      startAge=null;
      endAge=null;
      nationality=null;
      typeofmarriage=null;
      getUsersByGenderDone = true;
      emit(GetUserByGenderSuccessState());
    }).catchError((error) {
      log(error.toString());
      emit(GetUserByGenderErrorState(error.toString()));
    });
  }

  //change one section
  int? startAge;
  int? endAge;
  String? typeofmarriage;
  String? nationality;

  changeindexonesection({required int index, required String gender}) {
    print(index);
    SectionMenOrWomen.oneIndexSection = index;
    if (SectionMenOrWomen.oneIndexSection == 0) {
      typeofmarriage = null;
    }
    if (SectionMenOrWomen.oneIndexSection == 1) {
      typeofmarriage = "علني";
    }
    if (SectionMenOrWomen.oneIndexSection == 2) {
      typeofmarriage = "تعدد";
    }
    if (SectionMenOrWomen.oneIndexSection == 3) {
      typeofmarriage = "مسيار";
    }
    getUsersByFilter(gender: gender);
    emit(ChangeIndexSuccessState());
  }

  changeindextwosection({required int index, required String gender}) {
    log(index.toString());
    SectionMenOrWomen.twoIndexSection = index;
    if (SectionMenOrWomen.twoIndexSection == 0) {
      startAge = null;
      endAge = null;
    }
    if (SectionMenOrWomen.twoIndexSection == 1) {
      startAge = 18;
      endAge = 29;
    }
    if (SectionMenOrWomen.twoIndexSection == 2) {
      startAge = 30;
      endAge = 39;
    }
    if (SectionMenOrWomen.twoIndexSection == 3) {
      startAge = 40;
      endAge = 50;
    }
    getUsersByFilter(gender: gender);
    emit(ChangeIndexSuccessState());
  }

  changeindexthreesection({required int index, required String gender}) {
    log(index.toString());
    SectionMenOrWomen.threeIndexSection = index;
    if (SectionMenOrWomen.threeIndexSection == 0) {
      nationality = null;
    }
    if (SectionMenOrWomen.threeIndexSection == 1) {
      nationality = "سعودي";
    }
    if (SectionMenOrWomen.threeIndexSection == 2) {
      nationality = null;
    }
    getUsersByFilter(gender: gender);
    emit(ChangeIndexSuccessState());
  }

  //filter
  late GetUsersByFilterModel getUsersByFilterModel;

  getUsersByFilter({required String gender}) {
    users = [];
    log(startAge.toString());
 /*   print(endAge);
    print(nationality);
    print(typeofmarriage);*/
    emit(GetUsersByFilterLoadingState());
    DioHelper.postDataWithBearearToken(
            url: GETUSERSBYFILTER,
            data: {
              "gender": gender,
              "startAge": startAge,
              "EndAge": endAge,
              "typeofmarriage": typeofmarriage,
              "nationality": nationality
            },
            token: token.toString())
        .then((value) {
      log(value.toString());
      getUsersByFilterModel = GetUsersByFilterModel.fromJson(value.data);
      if (getUsersByFilterModel.data.isNotEmpty) {
        for (int i = 0; i < getUsersByFilterModel.data.length; i++) {
          users.add(getUsersByFilterModel.data[i]);

        }
      } else {
        users = [];
      }
      log(users.length.toString());
      emit(GetUsersByFilterSuccessState());
    }).catchError((error) {
      log(error.toString());
      emit(GetUsersByFilterErrorState(error.toString()));
    });
  }
}
