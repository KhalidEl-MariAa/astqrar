import '../../../models/login.dart';
import '../../../models/user.dart';

abstract class UserProfileStates {}

class UserProfileInitialState extends UserProfileStates {}

class GetUserDataLoadingState extends UserProfileStates {}

class GetUserDataSucccessState extends UserProfileStates {
  final User current_user;
  GetUserDataSucccessState(this.current_user);
}

class GetUserDataErrorState extends UserProfileStates {
  final String error;
  GetUserDataErrorState(this.error);
}

class UpdateUserDataLoadingState extends UserProfileStates {}

class UpdateUserDataSucccessState extends UserProfileStates {
  final LoginModel updateProfileModel;
  UpdateUserDataSucccessState(this.updateProfileModel);
}

class UpdateUserDataErrorState extends UserProfileStates {
  final String error;
  UpdateUserDataErrorState(this.error);
}