import 'dart:developer';

import '../../../../models/country.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants.dart';
import '../../../../models/get_specifications_model.dart';
import '../../../../end_points.dart';
import '../../../../shared/network/remote.dart';
import 'states.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  static LayoutCubit get(context) => BlocProvider.of(context);

  static Map<String, int> _specifications = {};

  static Map Specifications = {};

  LayoutCubit() : super(LayoutInitialState()) {
    _loadSpecificationId();
  }

  Future _loadSpecificationId() async {
    GetSpecificationsModel getSpecificationsModel;

    emit(GetSpecificationsLoadingState());

    await DioHelper.getDataWithBearerToken(
      url: SUBSPECIFICATIONS,
      token: TOKEN.toString(),
    ).then((value) {
      getSpecificationsModel = GetSpecificationsModel.fromJson(value.data);
      getSpecificationsModel.data.forEach((e) {
        _specifications.addAll({e.nameAr!: e.id!});
      });
      emit(GetSpecificationsSuccessState());
    }).catchError((error) {
      // log(error.toString());
      emit(GetSpecificationsErrorState(error.toString()));
    });

    await DioHelper.getData(url: "api/v2/Specifications/all").then((res) {
      // fill AppCubit.Specifications object
      LayoutCubit.Specifications = {};
      res.data['specs'].forEach((spec) {
        int key = spec['id'];
        LayoutCubit.Specifications[key] = spec;
        Map subspecs = {};

        // log(spec['subSpecifications'].toString());
        spec['subSpecifications']
            .where((subspec) => subspec["isActive"] == true)
            .forEach((subspec) {
          int key = subspec['id'];
          subspecs[key] = subspec;
        });
        spec['subSpecifications'] = subspecs;
      });

      emit(GetSpecificationsSuccessState());
    }).catchError((error) {
      log(error.toString());
      emit(GetSpecificationsErrorState(error.toString()));
    });
  }

  Map<String, int> loadSpecificationsFromBackend() {
    if (_specifications.isEmpty) {
      _loadSpecificationId();
    }
    return _specifications;
  }

  void getPhone() 
  {
    DioHelper.postData(
      url: GET_PHONE_NUMBER, 
      data: {})
    .then((value) {
      // log(value.toString());
      MOBILE_PHONE = value.data['mobilePhone'];
      log("phoneeeee : " + MOBILE_PHONE.toString());
      emit(GetPhoneSuccessState());
    }).catchError((error) {
      // log(error.toString());
      emit(GetPhoneErrorState(error.toString()));
    });
  }

  static List<Country> Countries = [];
  loadCountries() {

    DioHelper.getData(
      url: GET_COUNTRIES,
    ).then((value) {
      Countries = [];
      value.data["data"].forEach((e) {
        Country c = Country.fromJson(e);
        Countries.add(c);
        // log(c.NameAr??"XX");
      });

    }).catchError((error) {
      log(error.toString());
    });
  }
}
