import '../../../../../models/user.dart';

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

class SwitchHidingImgLodingState extends ChangeProfileImgStates {}

class SwitchHidingImgSuccessState  extends ChangeProfileImgStates{
  final bool hideImg;
  SwitchHidingImgSuccessState(this.hideImg);
}

class SwitchHidingImgErrorState  extends ChangeProfileImgStates{
  final String error;
  SwitchHidingImgErrorState(this.error);
}