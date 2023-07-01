import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../shared/network/remote.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> 
{
  SplashCubit() : super(SplashInitial());

}
