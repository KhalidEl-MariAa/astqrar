abstract class GetUserByGenderStates{}

class GetUserByGenderInitialState extends GetUserByGenderStates{}

class GetUserByGenderLoadingState extends GetUserByGenderStates{}

class GetUserByGenderSuccessState extends GetUserByGenderStates{}

class GetUserByGenderErrorState extends GetUserByGenderStates{
  final String error;
  GetUserByGenderErrorState(this.error);
}

class ChangeIndexSuccessState extends GetUserByGenderStates{}

class FiltersIndexSuccessState extends GetUserByGenderStates{}

class GetUsersByFilterLoadingState extends GetUserByGenderStates{}

class GetUsersByFilterSuccessState extends GetUserByGenderStates{}

class GetUsersByFilterErrorState extends GetUserByGenderStates{
  final String error;
  GetUsersByFilterErrorState(this.error);
}
