import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vconapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:vconapp/features/auth/presentation/bloc/auth_event.dart';
import 'package:vconapp/features/auth/presentation/bloc/auth_state.dart';
import 'package:vconapp/features/auth/presentation/screens/splash_screen_screen.dart';
import 'package:vconapp/features/main_feature/presentation/screens/main_feature_screen.dart';

class IndexAuth extends StatefulWidget {
  const IndexAuth({Key? key}) : super(key: key);

  @override
  _IndexAuthState createState() => _IndexAuthState();
}

class _IndexAuthState extends State<IndexAuth> {

  @override
  void initState() {
    context.read<AuthBloc>().add(AppStarted());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if(state is AuthInitialized){
            return const SplashScreenScreen();
          } else if(state is Authenticated){
            return const MainFeatureScreen();
          } else {
            return Container();
          }
        }
    );
  }
}
