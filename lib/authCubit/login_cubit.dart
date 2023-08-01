import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

// import '../helper/user_token.dart';
import '../helper/user_token.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login({required String email, required String password}) async {
    var url = 'https://student.valuxapps.com/api/login';
    var body = {"email": email, "password": password};
    var header = {"lang": "ar"};
    emit(LoadingLogin());
    try {
      var response =
          await http.post(Uri.parse(url), body: body, headers: header);
      var responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (responseBody['status'] == true) {
          // Save the user token securely, for example, using secure storage or encryption.
          Cache.SaveUserToken(
              key: 'token', value: responseBody['data']['token']);
          emit(SuccessLogin());
        } else {
          // Show a generic error message.
          emit(FailedLogin(
              message: 'Login failed. Please check your credentials.'));
        }
      } else {
        // Show a generic error message for non-200 status codes.
        emit(FailedLogin(
            message:
                'Failed to connect to the server. Please try again later.'));
      }
    } on Exception catch (e) {
      print(e.toString());
      // Show a generic error message for other exceptions.
      emit(FailedLogin(message: 'An error occurred. Please try again later.'));
    }
  }
}
