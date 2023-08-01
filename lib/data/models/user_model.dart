class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String img;
  final String tokenn;
  UserModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.phone,
      required this.img,
      required this.tokenn});

  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    return UserModel(
      id: jsonData['id'].toString(),
      name: jsonData['name'],
      email: jsonData['email'],
      phone: jsonData['phone'],
      img: jsonData['image'],
      tokenn: jsonData['token'],
    );
  }
}
