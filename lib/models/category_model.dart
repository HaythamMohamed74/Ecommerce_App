class Category {
  final int id;
  final String name;
  final String image;
  Category({required this.id, required this.name, required this.image});

  factory Category.fromJson(Map<String, dynamic> data) {
    return Category(id: data['id'], name: data['name'], image: data['image']);
  }
}
