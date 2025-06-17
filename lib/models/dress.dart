class Dress {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String category;
  final List<String> sizes;

  Dress({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.sizes,
  });

  // Convert to JSON (useful for API integration)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'category': category,
      'sizes': sizes,
    };
  }

  // Create from JSON (useful for API integration)
  factory Dress.fromJson(Map<String, dynamic> json) {
    return Dress(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
      imageUrl: json['imageUrl'],
      category: json['category'],
      sizes: List<String>.from(json['sizes']),
    );
  }
}
