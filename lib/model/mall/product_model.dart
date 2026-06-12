class Product {
  final String id;
  final String imageUrl;
  final String title;
  final double price;
  final String sales;

  Product({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.sales,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      imageUrl: json['imageUrl'],
      title: json['title'],
      price: json['price'],
      sales: json['sales'],
    );
  }
}
