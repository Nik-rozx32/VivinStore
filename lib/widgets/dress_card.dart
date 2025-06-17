import 'package:flutter/material.dart';
import '../models/dress.dart';
import 'size_selection_dialog.dart';
import '../screens/product_detail.dart';

class DressCard extends StatelessWidget {
  final Dress dress;
  final Function(Dress, String) onAddToCart;
  final Function(Dress)? onToggleWishlist;
  final bool isWishlisted;

  const DressCard({
    Key? key,
    required this.dress,
    required this.onAddToCart,
    this.onToggleWishlist,
    this.isWishlisted = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to product detail page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(
              dress: dress,
              onAddToCart: onAddToCart,
              onToggleWishlist: onToggleWishlist,
              isWishlisted: isWishlisted,
            ),
          ),
        );
      },
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section with Icons
            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(dress.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Top Right Icons
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Column(
                      children: [
                        // Cart Icon
                        GestureDetector(
                          onTap: () => _showSizeSelection(context),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.shopping_cart_outlined,
                              color: Colors.black,
                              size: 18,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Heart Icon
                        GestureDetector(
                          onTap: () => onToggleWishlist?.call(dress),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Icon(
                              isWishlisted
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isWishlisted ? Colors.red : Colors.black,
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Product Info Section
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name
                  Text(
                    dress.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  // Price
                  Text(
                    'RS. ${dress.price.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSizeSelection(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => SizeSelectionDialog(
        dress: dress,
        onAddToCart: onAddToCart,
      ),
    );
  }
}
