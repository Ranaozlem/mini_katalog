
class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final String category;
  final String image;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.image,
  });

  // JSON verisini Product nesnesine dönüştürür.
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      category: json['category'] as String,
      image: json['image'] as String,
    );
  }

  // Product nesnesini JSON formatına dönüştürür.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'category': category,
      'image': image,
    };
  }
}
