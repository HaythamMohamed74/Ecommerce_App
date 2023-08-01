class SearchModel {
  final bool status;
  
  final String message;
  final int id;
  final int price;
  final String image;
  final String name;
  SearchModel(
      {required this.status,required this.message,required this.id,required this.price,required this.image,required this.name});
  
  factory SearchModel.fromJson(Map<String,dynamic>jsonData){
    return SearchModel(
        status: jsonData['status'],
        message: jsonData['message'],
        id: jsonData['id'],
        price: jsonData['price'],
        image: jsonData['image'],
        name: jsonData['name']);
  }
}
