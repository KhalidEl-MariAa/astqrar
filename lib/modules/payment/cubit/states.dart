abstract class PaymentStates {}

class PaymentInitialState extends PaymentStates {}

class ChangePaymentState extends PaymentStates {}

class AddInvoiceLoadingState extends PaymentStates {}

class AddInvoiceSuccessState extends PaymentStates {}

class AddInvoiceErrorState extends PaymentStates {
  final String error;

  AddInvoiceErrorState(this.error);
}

class SetUrlState extends PaymentStates {}

class SetControllerState extends PaymentStates {}

class SetProgressState extends PaymentStates {}

class GetInvoiceStatusLoadingState extends PaymentStates {}

class GetInvoiceStatusSuccessState extends PaymentStates {
  String? orderStatus;

  GetInvoiceStatusSuccessState(this.orderStatus);
}

class GetInvoiceStatusErrorState extends PaymentStates {
  final String error;

  GetInvoiceStatusErrorState(this.error);
}

class ActivateLoadingState extends PaymentStates {}

class ActivateSuccessState extends PaymentStates {
  int type;
  bool status;
  ActivateSuccessState({required this.type,required this.status} );
}

class ActivateErrorState extends PaymentStates {
  final String error;
  ActivateErrorState(this.error);
}


class SendNotificationToAllLoadingState extends PaymentStates{}

class SendNotificationToAllSuccessState extends PaymentStates{}

class SendNotificationToAllErrorState extends PaymentStates{
   String error;
  SendNotificationToAllErrorState(this.error);
}

