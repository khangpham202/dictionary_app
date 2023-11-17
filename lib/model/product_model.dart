class Product {
  final int id;
  final String title;
  final double price;
  final String category;
  final String description;
  final String image;

  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.category,
    required this.description,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      title: json['title'] as String,
      price: json['price'] as double,
      category: json['category'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
    );
  }
}
