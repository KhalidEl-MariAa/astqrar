abstract class MenWomenStates{}

class MenWomenInitialState extends MenWomenStates{}

class MenWomenLoadingState extends MenWomenStates{}

class MenWomenSuccessState extends MenWomenStates{}

class MenWomenErrorState extends MenWomenStates{
  final String error;
  MenWomenErrorState(this.error);
}


class FiltersIndexSuccessState extends MenWomenStates{}

class QuickFilterLoading extends MenWomenStates{}

class QuickFilterSuccess extends MenWomenStates{}

class QuickFilterError extends MenWomenStates{
  final String error;
  QuickFilterError(this.error);
}
