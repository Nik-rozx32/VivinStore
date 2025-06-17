import 'dress.dart';

class CartItem {
  final Dress dress;
  final String size;
  int quantity;

  CartItem({
    required this.dress,
    required this.size,
    this.quantity = 1,
  });

  double get totalPrice => dress.price * quantity;

  Map<String, dynamic> toJson() {
    return {
      'dress': dress.toJson(),
      'size': size,
      'quantity': quantity,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      dress: Dress.fromJson(json['dress']),
      size: json['size'],
      quantity: json['quantity'],
    );
  }
}
