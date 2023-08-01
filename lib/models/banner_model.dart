class Banners {
  final int id;
  final String img;

  Banners({required this.id, required this.img});

  factory Banners.fromJson(Map<String, dynamic> data) {
    return Banners(id: data['id'], img: data['image']);
  }
}
