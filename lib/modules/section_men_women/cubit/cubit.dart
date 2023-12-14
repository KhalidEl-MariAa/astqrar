import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';
import '../../../end_points.dart';
import '../../../models/server_response_model.dart';
import '../../../models/user.dart';
import '../../../shared/network/remote.dart';
import '../../home/layout/cubit/cubit.dart';
import '../section_men_women.dart';
import 'states.dart';

class MenWomenCubit extends Cubit<MenWomenStates> 
{
  MenWomenCubit() : super(MenWomenInitialState());

  //late LoginModel loginModel;
  static MenWomenCubit get(context) => BlocProvider.of(context);

  
  List<User> users = [];

  //change one section
  int? startAge = null;
  int? endAge = null;
  String typeOfMarriage = "";
  List<int> countryIds = [];

  // getUserByGender({required int genderValue}) 
  // {
  //   ServerResponse res;
  //   users = [];
  //   emit(MenWomenLoadingState());   
  //   DioHelper.postDataWithBearearToken(      
  //       url: QUICKFILTER,
  //       token: TOKEN.toString(),
  //       data: {
  //         "gender": genderValue,
  //         "startAge": null ,
  //         "endAge": null ,
  //         "typeOfMarriage": null ,
  //         "countryIds": null ,
  //       })
  //   .then((value) {
  //     res = ServerResponse.fromJson(value.data);
  //     for (var u in res.data) 
  //     {
  //       User user = User.fromJson(u);
  //       users.add(user);
  //     }
  //     this.startAge=null;
  //     this.endAge=null;
  //     this.typeOfMarriage="";
  //     this.countryIds=[];
  //     log(users.length.toString() + " Found !!");
  //     emit(MenWomenSuccessState());
  //   }).catchError((error) {
  //     log(error.toString());
  //     emit(MenWomenErrorState(error.toString()));
  //   });
  // }


  changeindexonesection({required int index, required String gender}) 
  {
    if(SectionMenOrWomen.oneIndexSection == index) 
      return;

    SectionMenOrWomen.oneIndexSection = index;
    if (SectionMenOrWomen.oneIndexSection == 0) {
      this.typeOfMarriage = "";
    }
    if (SectionMenOrWomen.oneIndexSection == 1) {
      this.typeOfMarriage = "علني";
    }
    if (SectionMenOrWomen.oneIndexSection == 2) {
      this.typeOfMarriage = "تعدد";
    }
    if (SectionMenOrWomen.oneIndexSection == 3) {
      this.typeOfMarriage = "مسيار";
    }

    this.users = [];
    getUsersByQuickFilter(gender: gender);
    
  }

  changeindextwosection({required int index, required String gender}) 
  {
    // log(index.toString());
    if(SectionMenOrWomen.twoIndexSection == index)
      return;

    SectionMenOrWomen.twoIndexSection = index;
    if (SectionMenOrWomen.twoIndexSection == 0) {
      this.startAge = null;
      this.endAge = null;
    }
    if (SectionMenOrWomen.twoIndexSection == 1) {
      this.startAge = 18;
      this.endAge = 30;
    }
    if (SectionMenOrWomen.twoIndexSection == 2) {
      this.startAge = 30;
      this.endAge = 40;
    }
    if (SectionMenOrWomen.twoIndexSection == 3) {
      this.startAge = 40;
      this.endAge = 50;
    }
    this.users = [];
    getUsersByQuickFilter(gender: gender);
    
  }

  changeindexthreesection({required int index, required String gender}) 
  {
    // log(index.toString());
    if(SectionMenOrWomen.threeIndexSection == index)
      return;

    SectionMenOrWomen.threeIndexSection = index;
    if (SectionMenOrWomen.threeIndexSection == 0) {
      this.countryIds = [];
    }
    if (SectionMenOrWomen.threeIndexSection == 1) {
      this.countryIds = [3];
    }
    if (SectionMenOrWomen.threeIndexSection == 2) {
      this.countryIds = LayoutCubit.Countries
                        .where((c) => c.id != 3)
                        .map((e) => e.id!)
                        .toList();
    }
    
    this.users = [];
    getUsersByQuickFilter(gender: gender);
    
  }

  //filter
  getUsersByQuickFilter({required String gender}) 
  {
    ServerResponse res;
    // users = [];
    log("age: ${startAge.toString()} - ${endAge.toString()}" );
    log("typeOfMarriage: ${typeOfMarriage}" );
    log("countryIds: ${countryIds.length}" );

    emit(QuickFilterLoading());

    if(gender=="1"){
      this.users.removeWhere((u) => u.gender == 2);
    }else if(gender=="2"){
      this.users.removeWhere((u) => u.gender == 1);
    }

    DioHelper.postDataWithBearearToken(
      url: QUICKFILTER,
      data: {
        "gender": gender,
        "startAge": this.startAge,
        "EndAge": this.endAge,
        "typeofmarriage": this.typeOfMarriage,
        "countryIds": this.countryIds,
        "skipPos": this.users.length,
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
        this.users.add(user);
      }

      log(users.length.toString() + " Users Found !!");
      emit(QuickFilterSuccess());

    }).catchError((error) {
      log(error.toString());
      emit(QuickFilterError(error.toString()));
    });
  }
}
