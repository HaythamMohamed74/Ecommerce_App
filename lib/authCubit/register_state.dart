// part of 'register_cubit.dart';

// @immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class LoadingRegister extends RegisterState {}

class SuccsessRegister extends RegisterState {}

class FailedRegister extends RegisterState {
  final String message;

  FailedRegister({required this.message});
}
