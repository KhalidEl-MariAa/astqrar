
import 'package:flutter_bloc/flutter_bloc.dart';

import 'states.dart';

class AboutVersionCubit extends Cubit<AboutVersionStates> 
{
  AboutVersionCubit() : super(AboutVersionInitialState());

  static AboutVersionCubit get(context) => BlocProvider.of(context);

}