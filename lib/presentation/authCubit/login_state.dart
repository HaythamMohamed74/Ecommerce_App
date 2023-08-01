abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoadingLogin extends LoginState {}

class SuccessLogin extends LoginState {
  // final String message;
  // SuccessLogin({required this.message});
}

class FailedLogin extends LoginState {
  final String message;
  FailedLogin({required this.message});
}
