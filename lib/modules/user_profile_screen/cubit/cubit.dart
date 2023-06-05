import 'dart:developer';

import 'package:astarar/layout/cubit/cubit.dart';
import 'package:astarar/models/user.dart';
import 'package:astarar/models/login.dart';
import 'package:astarar/modules/user_profile_screen/cubit/states.dart';
import 'package:astarar/modules/user_profile_screen/user_profile_screen.dart';
import 'package:astarar/shared/contants/contants.dart';
import 'package:astarar/shared/network/end_points.dart';
import 'package:astarar/shared/network/local.dart';
import 'package:astarar/shared/network/remote.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfileCubit extends Cubit<UserProfileStates> {
  UserProfileCubit() : super(UserProfileInitialState());

  //late LoginModel loginModel;
  static UserProfileCubit get(context) => BlocProvider.of(context);

  List<String> specifications = [];
  List<Map> specificationsMap = [];
  List<String> specificationsNames = [
    "الاسم يبنتهي ب ",
    "لون الشعر",
    "نوع الشعر",
    "لون البشرة",
    "من عرق",
    "المؤهل العلمي",
    'الوظيفة',
    'الحالة الصحية',
    'الحالة الاجتماعية',
    'هل لديك اطفال',
    'نبذة عن مظهرك',
    'الوضع المالي'
  ];

  //text fields
  List<String> hairColor = ['اسود', 'اشقر', 'بني', 'ابيض'];
  List<String> hairtype = ['ناعم', 'خشن', 'متجعد'];
  List<String> skinColor = ['بيضاء', 'سمراء', 'سوداء', 'قمحي'];
  List<String> parentSkinColor = ['ابيض', 'اسمر', 'اسود'];
  List<String> experience = [
    'دكتوراة',
    'جامعي',
    'ابتدائي',
    'ثانوي',
    'متوسط',
    'غير متعلم',
    'دبلوم'
  ];
  List<String> jobType = [
    'موظف قطاعي حكومي',
    'موظف عسكري',
    'عاطل عن العمل',
    'موظف قطاع خاص',
    'أعمال حرة'
  ];
  List<String> jobTypeFemale = [
    'موظفة قطاعي حكومي',
    'موظفة عسكري',
    'عاطلة عن العمل',
    'موظفة قطاع خاص',
    'أعمال حرة'
  ];
  List<String> illnesstype = [
    'سليم من الأمراض',
    'من ذوي الاحتياجات الخاصة',
    'معي مرض مزمن'
  ];
  List<String> illnesstypeFemale = [
    'سليمة من الأمراض',
    'من ذوي الاحتياجات الخاصة',
    'معي مرض مزمن'
  ];
  List<String> MilirtyStatus = ['مطلقة بكر', 'مطلقة', 'أرملة', 'عزباء بكر'];
  List<String> MilirtyMaleStatus = ['أعزب', 'أرمل', 'مطلق','متزوج'];
  List<String> numberOfKids = [
    'بدون أطفال',
    'مع والدتهم',
    'معي أطفال',
    'معي أطفال وبعد الزواج مع والدتهم'
  ];
  List<String> numberOfKidsFemale = [
    'بدون أطفال',
    'مع والدهم',
    'معي أطفال',
    'معي أطفال وبعد الزواج مع والدهم'
  ];
  List<String> personality = ['وسيم', 'غير وسيم', 'مقبول الشكل'];
  List<String> personalityFemale = ['نوعا ما جميلة', 'متوسطة الجمال', 'جميلة'];

  List<String> money = [
    'ثري رجل أعمال',
    'ميسور الحال',
    'متوسط الثراء',
    'ضعف في القدرة المالية'
  ];

  List<String> moneyFemale = [
    'ثرية',
    'ميسورة الحال',
    'متوسطة الثراء',
    'ضعف في القدرة المالية'
  ];
  Map<String, int> hairColorMap = {};
  Map<String, int> hairTypeMap = {};
  Map<String, int> skinColorMap = {};
  Map<String, int> parentSkinColorMap = {};
  Map<String, int> experienceMap = {};
  Map<String, int> jopTypeMap = {};
  Map<String, int> jopTypeFemaleMap = {};
  Map<String, int> illnessTypeMap = {};
  Map<String, int> illnessTypeFemaleMap = {};
  Map<String, int> MilirtyMaleStatusMap = {};
  Map<String, int> MilirtyStatusMap = {};
  Map<String, int> numberOfKidsMap = {};
  Map<String, int> numberOfKidsFemaleMap = {};
  Map<String, int> personalityMap = {};
  Map<String, int> personalityFemaleMap = {};
  Map<String, int> moneyMap = {};
  Map<String, int> moneyFemaleMap = {};
  String? hairColorName;
  String? hairTypeName;
  String? skinColorName;
  String? parentSkinColorName;
  String? experienceName;
  String? jopTypeName;
  String? jopTypeFemaleName;
  String? illnessTypeName;
  String? illnessTypeFemaleName;
  String? MilirtyMaleStatusName;
  String? MilirtyStatusName;
  String? numberOfKidsName;
  String? numberOfKidsFemaleName;
  String? personalityName;
  String? personalityFemaleName;
  String? moneyName;
  String? moneyFemaleName;
  int? hairColorint;
  int? hairTypeint;
  int? skinColorint;
  int? parentSkinColorint;
  int? experienceint;
  int? jopTypeint;
  int? jopTypeFemaleint;
  int? illnessTypeint;
  int? illnessTypeFemaleint;
  int? MilirtyMaleStatusint;
  int? MilirtyStatusint;
  int? numberOfKidsint;
  int? numberOfKidsFemaleint;
  int? personalityint;
  int? personalityFemaleint;
  int? moneyint;
  int? moneyFemaleint;
  int? genderUser;

  listlist() {
    for (int i = 0; i < hairColor.length; i++) {
      hairColor.forEach((element) {
        hairColorMap.addAll({hairColor[i]: i});
      });
    }
    for (int i = 0; i < hairtype.length; i++) {
      hairtype.forEach((element) {
        hairTypeMap.addAll({hairtype[i]: i});
      });
    }
    for (int i = 0; i < skinColor.length; i++) {
      skinColor.forEach((element) {
        skinColorMap.addAll({skinColor[i]: i});
      });
    }
    for (int i = 0; i < parentSkinColor.length; i++) {
      parentSkinColor.forEach((element) {
        parentSkinColorMap.addAll({parentSkinColor[i]: i});
      });
    }
    for (int i = 0; i < experience.length; i++) {
      experience.forEach((element) {
        experienceMap.addAll({experience[i]: i});
      });
    }
    for (int i = 0; i < jobType.length; i++) {
      jobType.forEach((element) {
        jopTypeMap.addAll({jobType[i]: i});
      });
    }
    for (int i = 0; i < jobTypeFemale.length; i++) {
      jobTypeFemale.forEach((element) {
        jopTypeFemaleMap.addAll({jobTypeFemale[i]: i});
      });
    }
    for (int i = 0; i < illnesstype.length; i++) {
      illnesstype.forEach((element) {
        illnessTypeMap.addAll({illnesstype[i]: i});
      });
    }
    for (int i = 0; i < illnesstypeFemale.length; i++) {
      illnesstypeFemale.forEach((element) {
        illnessTypeFemaleMap.addAll({illnesstypeFemale[i]: i});
      });
    }
    for (int i = 0; i < MilirtyStatus.length; i++) {
      MilirtyStatus.forEach((element) {
        MilirtyStatusMap.addAll({MilirtyStatus[i]: i});
      });
    }
    for (int i = 0; i < MilirtyMaleStatus.length; i++) {
      MilirtyMaleStatus.forEach((element) {
        MilirtyMaleStatusMap.addAll({MilirtyMaleStatus[i]: i});
      });
    }
    for (int i = 0; i < numberOfKids.length; i++) {
      numberOfKids.forEach((element) {
        numberOfKidsMap.addAll({numberOfKids[i]: i});
      });
    }
    for (int i = 0; i < numberOfKidsFemale.length; i++) {
      numberOfKidsFemale.forEach((element) {
        numberOfKidsFemaleMap.addAll({numberOfKidsFemale[i]: i});
      });
    }
    for (int i = 0; i < personality.length; i++) {
      personality.forEach((element) {
        personalityMap.addAll({personality[i]: i});
      });
    }
    for (int i = 0; i < personalityFemale.length; i++) {
      personalityFemale.forEach((element) {
        personalityFemaleMap.addAll({personalityFemale[i]: i});
      });
    }
    for (int i = 0; i < money.length; i++) {
      money.forEach((element) {
        moneyMap.addAll({money[i]: i});
      });
    }
    for (int i = 0; i < moneyFemale.length; i++) {
      moneyFemale.forEach((element) {
        moneyFemaleMap.addAll({moneyFemale[i]: i});
      });
    }
    hairColorint = hairColorMap[hairColorName];
    hairTypeint = hairTypeMap[hairTypeName];
    skinColorint = skinColorMap[skinColorName];
    parentSkinColorint = parentSkinColorMap[parentSkinColorName];
    experienceint = experienceMap[experienceName];

    if (genderUser == 1) {
      MilirtyMaleStatusint = MilirtyMaleStatusMap[MilirtyMaleStatusName];
      personalityint = personalityMap[personalityName];
      jopTypeint = jopTypeMap[jopTypeName];
      illnessTypeint = illnessTypeMap[illnessTypeName];
      numberOfKidsint = numberOfKidsMap[numberOfKidsName];
      moneyint = moneyMap[moneyName];
    } else {
      MilirtyStatusint = MilirtyStatusMap[MilirtyStatusName];
      personalityFemaleint = personalityFemaleMap[personalityFemaleName];
      jopTypeFemaleint = jopTypeFemaleMap[jopTypeFemaleName];
      illnessTypeFemaleint = illnessTypeFemaleMap[illnessTypeFemaleName];
      numberOfKidsFemaleint = numberOfKidsFemaleMap[numberOfKidsFemaleName];
      moneyFemaleint = moneyFemaleMap[moneyFemaleName];
    }
  }

  //get user data
  late User user;
  bool getUserDataDone = false;

  getUserData() 
  {
    getUserDataDone = false;
    emit(GetUserDataLoadingState());

    DioHelper.postDataWithBearearToken(
            url: GETPROFILEDATA, 
            data: {}, 
            token: token.toString()
    ).then((value) {

      // log(value.toString());

      user = User.fromJson(value.data["data"]);
      UserProfileScreenState.emailController.text = user.email!;
      UserProfileScreenState.nameController.text = user.userName!;
      UserProfileScreenState.personalCardController.text = user.nationalID!;
      UserProfileScreenState.cityController.text = user.city!;
      UserProfileScreenState.nationalityController.text = user.nationality ?? "";
      UserProfileScreenState.ageController.text = user.age.toString();
      //  UserProfileScreenState.phoneController.text=user.phone??" ";
      UserProfileScreenState.heightController.text = user.height.toString();
      UserProfileScreenState.weightController.text = user.weight.toString();
      UserProfileScreenState.conditionsController.text = user.terms.toString();
      UserProfileScreenState.monyOfPony.text = user.dowry.toString();

      genderUser = user.gender!;
      hairColorName = user.subSpecifications[1].value;
      hairTypeName = user.subSpecifications[2].value;
      skinColorName = user.subSpecifications[3].value;
      parentSkinColorName = user.subSpecifications[4].value;
      experienceName = user.subSpecifications[5].value;

      if (genderUser == 1) {
        MilirtyMaleStatusName = user.subSpecifications[8].value;
        personalityName = user.subSpecifications[10].value;
        jopTypeName = user.subSpecifications[6].value;
        illnessTypeName = user.subSpecifications[7].value;
        numberOfKidsName = user.subSpecifications[9].value;
        moneyName = user.subSpecifications[11].value;
      }
      if (genderUser == 2) {
        MilirtyStatusName = user.subSpecifications[8].value;
        personalityFemaleName = user.subSpecifications[10].value;
        jopTypeFemaleName = user.subSpecifications[6].value;
        illnessTypeFemaleName = user.subSpecifications[7].value;
        numberOfKidsFemaleName = user.subSpecifications[9].value;
        moneyFemaleName =user.subSpecifications[11].value;
      }


      listlist();
      getUserDataDone = true;
      emit(GetUserDataSucccessState());
      
    }).catchError((error) {
      log(error.toString());
      emit(GetUserDataErrorState(error.toString()));
    });
  }

  convert() {
    specificationsMap.clear();
    Map<String, int> specificationIDs = new AppCubit().getSpecifications();
    for (int i = 0; i < specifications.length; i++) {
      specificationsMap.add({
        "SpecificationId": specificationIDs[specifications[i]],
        "SpecificationName": specificationsNames[i]
      });
    }
    // log(specifications.toString());
    // log(specificationsMap.toString());
  }

  //update user data
  late LoginModel updateUserDataModel;

  void updateUserData() {
    emit(UpdateUserDataLoadingState());
    FormData formData = FormData.fromMap({
      "userName": UserProfileScreenState.nameController.text,
      "email": UserProfileScreenState.emailController.text,
      "Age": UserProfileScreenState.ageController.text,
      "Nationality": UserProfileScreenState.nationalityController.text,
      "City": UserProfileScreenState.cityController.text,
      "phone": user.phone,
      "Height": UserProfileScreenState.heightController.text,
      "Weight": UserProfileScreenState.weightController.text,
      "Dowry": UserProfileScreenState.monyOfPony.text,
      "Terms": UserProfileScreenState.conditionsController.text,
      "UserSpecifications": specificationsMap,
      //"type":"image/png"
    });

    DioHelper.postDataWithImage(
            url: UPDATEUSERDATA,
            data: formData,
            token: token.toString(),
            length: 0)
    .then((value) {
      // log(value.toString());

      updateUserDataModel = LoginModel.fromJson(value.data);
      
      name = CacheHelper.getData(key: "name");
      age = CacheHelper.getData(key: "age");
      email = CacheHelper.getData(key: "email");

      CacheHelper.saveData(key: "name", value: updateUserDataModel.data!.userName);
      CacheHelper.saveData(key: "age", value: updateUserDataModel.data!.age.toString());
      CacheHelper.saveData(key: "email", value: updateUserDataModel.data!.email);

      emit(UpdateUserDataSucccessState(updateUserDataModel));
    }).catchError((error) {
      log(error.toString());
      emit(UpdateUserDataErrorState(error.toString()));
    });
  }
}
