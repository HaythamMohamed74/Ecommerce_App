abstract class LogoutState {}

class LogoutInitial extends LogoutState {}

class LogoutSuccess extends LogoutState {
  final String message;
  LogoutSuccess({required this.message});
}

class LogoutFailed extends LogoutState {
  final String message;

  LogoutFailed({required this.message});
}
