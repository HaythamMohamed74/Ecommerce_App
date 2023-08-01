class Product {
  int id;
  int price;
  int oldPrice;
  int dicoounnt;
  String img;
  String name;
  String desc;
  List<String> images;
  Product(
      {required this.id,
      required this.price,
      required this.oldPrice,
      required this.dicoounnt,
      required this.img,
      required this.name,
      required this.desc,
      required this.images});
  factory Product.fromJson(Map<String, dynamic> productData) {
    final imagesData = productData['images'];
    List<String> imagesList = [];

    if (imagesData is List<dynamic>) {
      imagesList = imagesData.map((item) => item.toString()).toList();
    }

    return Product(
      id: productData['id'],
      price: productData['price'].toInt(),
      oldPrice: productData['old_price'].toInt(),
      dicoounnt: productData['discount'].toInt(),
      img: productData['image'],
      name: productData['name'],
      desc: productData['description'].toString(),
      images: imagesList,
    );
  }
  // With this change, if productData['images'] is null or not a list, it will default to an empty list, and the error should be resolved. Remember to adapt the rest of your code to handle cases where the images list might be empty or not present for a product.
}
