abstract class PriceStates{}

class PriceInitialState extends PriceStates{}

class GetPriceLoadingState extends PriceStates{}

class GetPriceSuccessState extends PriceStates{}

class GetPriceErrorState extends PriceStates{
  final String error;
  GetPriceErrorState(this.error);
}

class UpdatePriceLoadingState extends PriceStates{}

class UpdatePriceSuccessState extends PriceStates{}

class UpdatePriceErrorState extends PriceStates{
  final String error;
  UpdatePriceErrorState(this.error);
}

