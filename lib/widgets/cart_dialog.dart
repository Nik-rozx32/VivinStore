import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../utils/app_theme.dart';

class CartDialog extends StatelessWidget {
  final List<CartItem> cart;
  final double totalPrice;
  final Function(int) onRemove;

  const CartDialog({
    Key? key,
    required this.cart,
    required this.totalPrice,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Shopping Cart'),
      content: Container(
        width: double.maxFinite,
        height: 400,
        child: cart.isEmpty ? _buildEmptyCart() : _buildCartContent(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Close'),
        ),
      ],
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 64,
            color: Colors.grey,
          ),
          SizedBox(height: 16),
          Text(
            'Your cart is empty',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartContent() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: cart.length,
            itemBuilder: (context, index) => _buildCartItem(index),
          ),
        ),
        Divider(),
        _buildCartSummary(),
      ],
    );
  }

  Widget _buildCartItem(int index) {
    final item = cart[index];
    return Card(
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: NetworkImage(item.dress.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(item.dress.name),
        subtitle: Text('Size: ${item.size} • Qty: ${item.quantity}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '\$${item.totalPrice.toStringAsFixed(2)}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => onRemove(index),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartSummary() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Total: \$${totalPrice.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        ElevatedButton(
          onPressed: cart.isNotEmpty ? _checkout : null,
          child: Text('Checkout'),
        ),
      ],
    );
  }

  void _checkout() {
    // Implement checkout logic here
    print('Checkout with ${cart.length} items');
  }
}
