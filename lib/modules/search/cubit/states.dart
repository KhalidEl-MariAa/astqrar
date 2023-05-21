abstract class SearchStates{}

class SearchInitialState extends SearchStates{}

class GetSearchLoadingState extends SearchStates{}

class GetSearchSuccessState extends SearchStates{}

class GetSearchErrorState extends SearchStates{
  final String error;
  GetSearchErrorState(this.error);
}

class FilterSearchLoadingState extends SearchStates{}

class FilterSearchSuccessState extends SearchStates{}

class FilterSearchErrorState extends SearchStates{
  final String error;
  FilterSearchErrorState(this.error);
}