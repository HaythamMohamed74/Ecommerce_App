import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../../utils/helper/constant.dart';
import 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit() : super(LogoutInitial());
  Future<void> logout() async {
    var url = 'https://student.valuxapps.com/api/logout';
    var headrs = {'Authorization': token!, 'lang': "en"};
    // emit(ProfileDataLoading());
    try {
      Response response = await http.post(Uri.parse(url), headers: headrs);
      var responsebody = jsonDecode(response.body);
      if (response.statusCode == 200 && responsebody['message'] == true) {
        print(responsebody);
        emit(LogoutSuccess(message: responsebody['message']));
        print(responsebody);
      } else {
        print(responsebody);
        emit(LogoutFailed(message: responsebody['message']));
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
