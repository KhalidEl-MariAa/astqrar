import 'package:astarar/models/add_to_favourite.dart';
import 'package:astarar/models/delegate/update_price_model.dart';

abstract class PaymentStates{}

class PaymentInitialState extends PaymentStates{}

class PaymentConfirmationLoadingState extends PaymentStates{}

class PaymentConfirmationSuccessState extends PaymentStates{
  final UpdatePriceModel paymentConfirmationModel;
  PaymentConfirmationSuccessState(this.paymentConfirmationModel);
}


class PaymentConfirmationErrorState extends PaymentStates{
  final String error;
  PaymentConfirmationErrorState(this.error);
}

class SendNotificationLoadingState extends PaymentStates{}

class SendNotificationSuccessState extends PaymentStates{}

class SendNotificationErrorState extends PaymentStates{
  final String error;
  SendNotificationErrorState(this.error);
}

//checkclient pay or not

class CheckClientPayLoadingState extends PaymentStates{}

class CheckClientPaySuucessState extends PaymentStates{}

class CheckClientPayErrorState extends PaymentStates{
  final String error;
  CheckClientPayErrorState(this.error);
}

class GetPriceLoadingState extends PaymentStates{}

class GetPriceSuccessState extends PaymentStates{}

class GetPriceErrorState extends PaymentStates{
  final String error;
  GetPriceErrorState(this.error);
}

class AddRateLoadingState extends PaymentStates{}

class AddRateSuucessState extends PaymentStates{
  final AddToFavouriteModel rateDelegateModel;
  AddRateSuucessState(this.rateDelegateModel);
}

class AddRateErrorState extends PaymentStates{
  final String error;
  AddRateErrorState(this.error);
}

class RemoveUserLoadingState extends PaymentStates{}

class RemoveUserSuuccessState extends PaymentStates{}

class RemoveUserErrorState extends PaymentStates{
  final String error;
  RemoveUserErrorState(this.error);
}