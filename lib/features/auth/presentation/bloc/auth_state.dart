import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}
///AUTH
class AuthInitialized extends AuthState {}

class Authenticated extends AuthState {}

class UnAuthenticated extends AuthState {}