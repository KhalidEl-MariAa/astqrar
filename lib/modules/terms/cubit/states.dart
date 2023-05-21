abstract class TermsAndConditionsStates{}

class TermsAndConditionsInitialState extends TermsAndConditionsStates{}

class TermsAndConditionsLoadingState extends TermsAndConditionsStates{}

class TermsAndConditionsSuccessState extends TermsAndConditionsStates{}

class TermsAndConditionsErrorState extends TermsAndConditionsStates{
  final String error;
  TermsAndConditionsErrorState(this.error);
}