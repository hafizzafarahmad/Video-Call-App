import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState>{
  AuthBloc() : super(AuthInitialized());


  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {

    if(event is AppStarted){
      await Future.delayed(const Duration(seconds: 3));
      yield Authenticated();
    }

  }


}