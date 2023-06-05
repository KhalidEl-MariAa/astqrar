import 'package:astarar/models/server_response_model.dart';
import 'package:flutter/src/widgets/framework.dart';

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
