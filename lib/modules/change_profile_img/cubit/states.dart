import '../../../models/server_response_model.dart';
import '../../../models/user.dart';

abstract class ChangeProfileImgStates{}

class ChangeProfileImageInitialState extends ChangeProfileImgStates{}

class ChangeProfileImageLoadingState extends ChangeProfileImgStates{}

class ChangeProfileImageSuccessState extends ChangeProfileImgStates
{
  // final ServerResponse res;
  final User updatedUser;
  ChangeProfileImageSuccessState(this.updatedUser);

}

class ChangeProfileImageErrorState extends ChangeProfileImgStates{
  final String error;
  ChangeProfileImageErrorState(this.error);
}