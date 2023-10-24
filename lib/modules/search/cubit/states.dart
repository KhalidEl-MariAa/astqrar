import '../../../models/user.dart';

abstract class SearchStates{}

class SearchInitialState extends SearchStates{}

class GetSearchLoadingState extends SearchStates{}

class GetSearchSuccessState extends SearchStates{
  final List<User> searchResult;
  GetSearchSuccessState(this.searchResult);
}

class GetSearchErrorState extends SearchStates{
  final String error;
  GetSearchErrorState(this.error);
}

class FilterSearchLoadingState extends SearchStates{}

class FilterSearchSuccessState extends SearchStates{
  final List<User> searchResult;
  FilterSearchSuccessState(this.searchResult);
}

class FilterSearchErrorState extends SearchStates{
  final String error;
  FilterSearchErrorState(this.error);
}