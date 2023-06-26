import 'dart:developer';
import 'dart:io';

import '../../../models/server_response_model.dart';

import '../../../models/get_information_user.dart';
import 'states.dart';
import '../../../constants.dart';
import '../../../end_points.dart';
import '../../../shared/network/remote.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserDetailsCubit extends Cubit<UserDetailsStates> 
{
  UserDetailsCubit() : super(GetInformationInitialState());

  static UserDetailsCubit get(context) => BlocProvider.of(context);

  //get information users
  late GetInformationUserModel getInformationUserModel;

  userOrVisitorToGetInformation({required String userId})
  {
    if(IS_LOGIN){
      getInformationUser(otherId: userId);
    }else{
      getInformationUserByVisitor(userId: userId);
    }
  }

  void getInformationUser({required String otherId}) 
  {
      // log(token.toString());
      emit(GetInformationLoadingState());
      DioHelper.getDataWithQuery(
              url: GETINFORMATIONUSER,
              query: {"otherId": otherId},
              token: TOKEN.toString())
    .then((value) 
    {
      getInformationUserModel = GetInformationUserModel.fromJson(value.data);
      emit(GetInformationSuccessState());
      sendNotification(userid: otherId, type: 3, body:"تمت زيارة صفحتك من قبل $NAME", title: "");
    }).catchError((error) 
    {
      emit(GetInformationErrorState(error.toString()));
    });
  }

  void getInformationUserByVisitor({required String userId}) 
  {
    log(userId);

    emit(GetInformationLoadingState());
    DioHelper.getDataWithQuery(
        url: GETINFORMATIONUSERBYVISITOR,
        query: {"userid": userId})
        .then((value) {
      getInformationUserModel = GetInformationUserModel.fromJson(value.data);
      emit(GetInformationSuccessState());

    }).catchError((error) {
      emit(GetInformationErrorState(error.toString()));
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
    ).then((value) 
    {
      log(value.toString());
      res = ServerResponse.fromJson(value.data);
      if(res.key == 0){
        emit(AddToFavouriteErrorState(res.msg!));
      }


      //TODO: اضافة تنبيه للطرف الاخر بان احدهم قد اعجب به
      //   sendNotification(
      //     userid: userId, 
      //     type: 0, 
      //     body:  "قام " + NAME! + " بالإعجاب بك واضافتك الى قائمة المفضلة ", 
      //     title: "طلب محادثة");

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
        url: DELETEFROMFAVOURITE,
        data: {
          "CurrentUserId": ID,
          "FavUserId": userId,
          "IsDeleted":true
        },
        token: TOKEN.toString())
        .then((value) {
      // log(value.toString());

      res = ServerResponse.fromJson(value.data);

      if(res.key == 0){
        emit(AddToFavouriteErrorState(res.msg!));
      }

      emit(RemoveFromFavouriteSuccessState());

    }).catchError((error) {
      // getInformationUserModel.isFavorate = !getInformationUserModel.isFavorate!;
      // log(error.toString());
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

  void addHimToMyContacts({required String userId}) 
  {
    emit(AddHimToMyContactsLoading());
    
    DioHelper.postDataWithBearearToken(
      url: ADD_HIM_TO_MY_CONTACTS, 
      data: { "userId":userId }, 
      token: TOKEN.toString())
    .then((value) {
      res = ServerResponse.fromJson(value.data);
      if( res.key == 0){
        emit(AddHimToMyContactsError( res.msg! ));
        return;
      }

      //تم اضافة المستخدم الحالي الى قائمة الطرف الاخر
      if( res.data?['i_am_added_to_his_list'] )
      {
        sendNotification(
          userid: userId, 
          type: 0, 
          body:  "قام " + NAME! + " بإضافتك الى قائمته وبإمكانك بدء المحادثه معه ", 
          title: "طلب محادثة");

        return; 
      }

      emit(AddHimToMyContactsSuccess( res.msg! ));

    }).catchError((error) {
      emit(AddHimToMyContactsError(error.toString()));
    });    
  }

  void blockHim({required String userId}) 
  {
    emit(BlockHimLoading());
    
    DioHelper.postDataWithBearearToken(
      url: BLOCK_HIM, 
      data: { "userId": userId }, 
      token: TOKEN.toString())
    .then((value) {
      res = ServerResponse.fromJson(value.data);
      if( res.key == 0){
        emit(BlockHimError( res.msg! ));
        return;
      }

      emit(BlockHimSuccess( res.msg! ));

    }).catchError((error) {
      emit(BlockHimError(error.toString()));
    });    
  }

  void unblockHim({required String userId}) 
  {
    emit(BlockHimLoading());
    
    DioHelper.postDataWithBearearToken(
      url: UNBLOCK_HIM, 
      data: { "userId": userId }, 
      token: TOKEN.toString())
    .then((value) {
      res = ServerResponse.fromJson(value.data);
      if( res.key == 0){
        emit(BlockHimError( res.msg! ));
        return;
      }

      emit(BlockHimSuccess( res.msg! ));

    }).catchError((error) {
      emit(BlockHimError(error.toString()));
    });    
    
  }//unblockHim


  //send notification
  void sendNotification({required String userid,required int type,required String body,required String title})
  {
      emit(SendNotificationLoadingState());

      DioHelper.postDataWithBearearToken(
        token: TOKEN.toString(),
        url: SENDNOTIFICATION, 
        data: {
          "userId":userid,
          "projectName":"استقرار",
          "deviceType":Platform.isIOS?"ios":"android",
          "notificationType":type,
          "body":body,
          "title":title
        }
      ).then((value) {
          // log(value.toString());
          emit(SendNotificationSuccessState());
      }).catchError((error){
          // log(error.toString());
          emit(SendNotificationErrorState(error.toString()));
      });
  }


  

}//end class
