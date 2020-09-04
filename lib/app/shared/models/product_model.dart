class ProductModel {
  int id;
  String name;
  String image;
  String description;
  double price;
  String category;

  ProductModel({this.id, this.name, this.image, this.description, this.category, this.price});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['title'];
    description = json['description'];
    category = json['category'];
    price = json['price']?.toDouble() ?? 0.0;
    image = json['image'] ?? '';
  }

  static List<ProductModel> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => ProductModel.fromJson(item)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.name;
    data['description'] = this.description;
    data['category'] = this.category;
    data['price'] = this.price;
    data['image'] = this.image ?? '';
    return data;
  }

  toString() => 'id: $id, name: $name, image: $image';
}
