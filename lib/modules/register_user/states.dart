import '../../models/server_response_model.dart';

abstract class RegisterState{ }

class RegisterState_Initial extends RegisterState{ }

class RegisterState_Loading extends RegisterState{ }

class RegisterState_Success extends RegisterState{
  final ServerResponse response;
  RegisterState_Success(this.response);
  
}

class RegisterState_Error extends RegisterState{
  final String err_msg;
  RegisterState_Error(this.err_msg);
}
