abstract class DelegateSectionStates{}

class DelegateSectionInitialState extends DelegateSectionStates{}

class GetDelegateLoadingState extends DelegateSectionStates{}

class GetDelegateSuucessState extends DelegateSectionStates{}

class GetDelegateErrorState extends DelegateSectionStates{
  final String error;
  GetDelegateErrorState(this.error);
}



