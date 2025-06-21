class Dress {
  final String id;
  final String name;
  final double price; // Base price
  final String imageUrl;
  final List<String> images; // Multiple images for gallery
  final List<String> sizes;
  final Map<String, double>? sizePricing; // Size-specific pricing
  final String description;
  final String category;
  final bool isAvailable;
  final DateTime createdAt;
  final DateTime updatedAt;

  Dress({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    this.images = const [],
    required this.sizes,
    this.sizePricing,
    this.description = '',
    this.category = '',
    this.isAvailable = true,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor for creating Dress from Supabase JSON
  factory Dress.fromJson(Map<String, dynamic> json) {
    return Dress(
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['image_url'] as String,
      images: json['images'] != null
          ? List<String>.from(json['images'] as List)
          : [],
      sizes: List<String>.from(json['sizes'] as List),
      sizePricing: json['size_pricing'] != null
          ? Map<String, double>.from(
              (json['size_pricing'] as Map).map(
                (key, value) =>
                    MapEntry(key.toString(), (value as num).toDouble()),
              ),
            )
          : null,
      description: json['description'] as String? ?? '',
      category: json['category'] as String? ?? '',
      isAvailable: json['is_available'] as bool? ?? true,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  // Convert Dress to JSON for Supabase
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'image_url': imageUrl,
      'images': images,
      'sizes': sizes,
      'size_pricing': sizePricing,
      'description': description,
      'category': category,
      'is_available': isAvailable,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  // Helper method to get price for a specific size
  double getPriceForSize(String size) {
    return sizePricing?[size] ?? price;
  }

  // Copy with method for updates
  Dress copyWith({
    String? id,
    String? name,
    double? price,
    String? imageUrl,
    List<String>? images,
    List<String>? sizes,
    Map<String, double>? sizePricing,
    String? description,
    String? category,
    bool? isAvailable,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Dress(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      images: images ?? this.images,
      sizes: sizes ?? this.sizes,
      sizePricing: sizePricing ?? this.sizePricing,
      description: description ?? this.description,
      category: category ?? this.category,
      isAvailable: isAvailable ?? this.isAvailable,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
