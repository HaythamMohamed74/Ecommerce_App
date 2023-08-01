import 'dart:convert';

// import 'package:bloc/bloc.dart';
// import 'package:ecommerce_app/authCubit/register_state.dart';
import 'package:ecommerce_app/presentation/authCubit/register_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
// import 'package:http/http.dart';
// import 'package:http/http.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  register(
      {required String name,
      required String email,
      required String password,
      required String phone}) async {
    var url = "https://student.valuxapps.com/api/register";
    var body = {
      "name": name,
      "email": email,
      "password": password,
      "phone": phone
    };
    var header = {"lang": "ar"};
    emit(LoadingRegister());
    try {
      var response =
          await http.post(Uri.parse(url), body: body, headers: header);
      var responseBody = jsonDecode(response.body);
      if (response.statusCode == 200 && responseBody['status'] == true) {
        emit(SuccsessRegister());
      } else {
        emit(FailedRegister(message: responseBody['message']));
      }
    } on Exception catch (e) {
      print(e);
    }
  }
}
