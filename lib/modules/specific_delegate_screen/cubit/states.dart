abstract class ProfileDeleagateStates{}

class ProfileDelegateInitialState extends ProfileDeleagateStates{}

class GetProfileDelegateLoadingState extends ProfileDeleagateStates{}

class GetProfileDelegateSuccessState extends ProfileDeleagateStates{}

class GetProfileDelegateErrorState extends ProfileDeleagateStates{
  final String error;
  GetProfileDelegateErrorState(this.error);
}

class RemoveUserLoadingState extends ProfileDeleagateStates{}

class RemoveUserSuuccessState extends ProfileDeleagateStates{}

class RemoveUserErrorState extends ProfileDeleagateStates{
  final String error;
  RemoveUserErrorState(this.error);
}


