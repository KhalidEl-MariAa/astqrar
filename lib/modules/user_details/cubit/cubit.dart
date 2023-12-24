import 'dart:developer';

import '../../../models/get_notifications.dart';
import '../../../utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';
import '../../../end_points.dart';
import '../../../models/user_other.dart';
import '../../../models/server_response_model.dart';
import '../../../shared/network/remote.dart';
import 'states.dart';

class UserDetailsCubit extends Cubit<UserDetailsStates> {
  UserDetailsCubit() : super(UserDetailsInitialState());

  static UserDetailsCubit get(context) => BlocProvider.of(context);

  //get information users
  void getOtherUser({required String otherId}) 
  {
    emit(UserDetailsLoadingState());
    DioHelper.getDataWithQuery(
            url: GETINFORMATIONUSER,
            query: {"otherId": otherId},
            token: TOKEN.toString())
    .then((value) 
    {
      OtherUser otherUser = OtherUser.fromJson(value.data["otherUser"]);
      emit(UserDetailsSuccessState(otherUser));

      sendNotificationAsync(
          userid: otherId,
          type: NotificationTypes.ProfileIsVisited,
          body: "تمت زيارة صفحتك من قبل " + NAME!,
          title: APP_NAME,
          save: true,
      );

    }).catchError((error) {
      emit(UserDetailsErrorState(error.toString()));
    });
  }

  void getInformationUserByVisitor({required String userId}) {
    log(userId);

    emit(UserDetailsLoadingState());
    DioHelper.getDataWithQuery(
        url: GETINFORMATIONUSERBYVISITOR, //,
        query: {"otherId": userId})
    .then((value) 
    {
      OtherUser otherUser = OtherUser.fromJson(value.data["otherUser"]);
      emit(UserDetailsSuccessState(otherUser));
    }).catchError((error) {
      emit(UserDetailsErrorState(error.toString()));
    });
  }

  //add to favourite
  void addToFavourite({required String userId}) 
  {
    ServerResponse res;
    // getInformationUserModel.isFavorate = !getInformationUserModel.isFavorate!;
    emit(ToggleFavouriteLoading());

    DioHelper.postDataWithBearearToken(
      url: ADDTOFAVOURITE,
      data: {
        "CurrentUserId": ID,
        "FavUserId": userId,
      },
      token: TOKEN.toString()
    )
    .then((value) 
    {
      log(value.toString());
      res = ServerResponse.fromJson(value.data);
      if (res.key == 0) {
        emit(AddToFavouriteErrorState(res.msg!));
        return;
      }

      sendNotificationAsync(
          userid: userId, 
          type: NotificationTypes.LikedBySomeone,
          body: "قام " + NAME! + " بالإعجاب بك واضافتك الى قائمة المفضلة ",
          title: "إعجاب",
          save: true,
      );

      emit(AddToFavouriteSuccessState());
    }).catchError((error) {
      // getInformationUserModel.isFavorate = !getInformationUserModel.isFavorate!;
      log(error.toString());
      emit(AddToFavouriteErrorState(error.toString()));
    });
  }

  //delete from favourite
  void deleteFromFavourite({required String userId}) 
  {
    late ServerResponse res;
    // getInformationUserModel.isFavorate = !getInformationUserModel.isFavorate!;
    emit(ToggleFavouriteLoading());
    DioHelper.postDataWithBearearToken(
      token: TOKEN.toString(),
      url: DELETEFROMFAVOURITE,
      data: {
        "CurrentUserId": ID, 
        "FavUserId": userId, 
        "IsDeleted": true
      })
    .then((value) 
    {
      // log(value.toString());

      res = ServerResponse.fromJson(value.data);

      if (res.key == 0) {
        emit(AddToFavouriteErrorState(res.msg!));
        return;
      }

      emit(RemoveFromFavouriteSuccessState());
    }).catchError((error) {
      // getInformationUserModel.isFavorate = !getInformationUserModel.isFavorate!;
      log(error.toString());
      emit(RemoveFromFavouriteErrorState(error.toString()));
    });
  }

  //add request
  late ServerResponse res;

  // void addChattRequest({required String userId})
  // {
  //   emit(AddChattRequestLoadingState());
  //   DioHelper.postDataWithBearearToken(
  //     url: ADDREQUEST,
  //     data: { "userId":userId },
  //     token: token.toString())
  //   .then((value) {
  //     res = ServerResponse.fromJson(value.data);
  //     if( res.key == 0){
  //       emit(AddChattRequestErrorState( res.msg.toString() ));
  //       return;
  //     }
  //     emit(AddChattRequestSuccessState(value.statusCode!));
  //     sendNotification(userid: userId, type: 0, body: "تم ارسال طلب محادثة من قبل $name", title: "طلب محادثة");
  //   }).catchError((error) {
  //     emit(AddChattRequestErrorState(error.toString()));
  //   });
  // }

  void addHimToMyContacts({required String hisUserId}) 
  {
    emit(AddHimToMyContactsLoading());

    DioHelper.postDataWithBearearToken(
            url: ADD_HIM_TO_MY_CONTACTS,
            data: {"userId": hisUserId},
            token: TOKEN.toString())
    .then((value) 
    {
      res = ServerResponse.fromJson(value.data);
      if (res.key == 0) {
        emit(AddHimToMyContactsError(res.msg!));
        return;
      }

      if (res.data['he_is_added_to_my_list']) {
        emit(AddHimToMyContactsAdded(res.msg!));
      }

      //تم اضافة المستخدم الحالي الى قائمة الطرف الاخر
      if (res.data['i_am_added_to_his_list']) 
      {
        sendNotificationAsync(
            userid: hisUserId,
            type: NotificationTypes.AddedToHisList,
            body: "قام " + NAME! +
                " بإضافتك الى قائمته وبإمكانك بدء المحادثه معه ",
            title: "طلب محادثة",
            save: false,
        );
      }
      emit(AddHimToMyContactsSuccess());

    }).catchError((error) {
      emit(AddHimToMyContactsError(error.toString()));
    });
  }

  void blockHim({required String userId}) {
    emit(BlockHimLoading());

    DioHelper.postDataWithBearearToken(
      token: TOKEN.toString(),
      url: BLOCK_HIM, 
      data: {"userId": userId } 
    )
    .then((value) 
    {
      res = ServerResponse.fromJson(value.data);
      if (res.key == 0) {
        emit(BlockHimError(res.msg!));
        return;
      }

      announceHimWithBlock(userId);
      emit(BlockHimSuccess(res.msg!, true));
    }).catchError((error) {
      emit(BlockHimError(error.toString()));
    });
  }

  void unblockHim({required String userId}) 
  {
    emit(BlockHimLoading());

    DioHelper.postDataWithBearearToken(
            url: UNBLOCK_HIM, data: {"userId": userId}, token: TOKEN.toString())
        .then((value) {
      res = ServerResponse.fromJson(value.data);

      if (res.key == 0) {
        emit(BlockHimError(res.msg!));
        return;
      }

      emit(BlockHimSuccess(res.msg!, false));
    }).catchError((error) {
      emit(BlockHimError(error.toString()));
    });
  } //unblockHim

  
  void announceHimWithBlock(userId) 
  {
    DioHelper.postDataWithBearearToken(
            url: "api/v1/announce-block",
            data: {
              "BlockerId": ID,
              "BlockedId": userId,
            },
            token: TOKEN.toString())
    .then((value) 
    {
      log(value.toString());
    }).catchError((error) {
      log(error.toString());
    });
  }
} //end class
