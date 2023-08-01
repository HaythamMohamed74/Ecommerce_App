// import 'dart:convert';
//
// import 'package:http/http.dart' as http;
//
// Future<Map<String, dynamic>> fetchData() async {
//   var url = 'https://student.valuxapps.com/api/home';
//   var headers = {'Authorization': 'YourAuthToken', 'lang': 'en'};
//
//   try {
//     http.Response response = await http.get(Uri.parse(url), headers: headers);
//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception('Failed to fetch data');
//     }
//   } catch (e) {
//     throw Exception('Error: $e');
//   }
// }
