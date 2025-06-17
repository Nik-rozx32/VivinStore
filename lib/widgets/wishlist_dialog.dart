import 'package:flutter/material.dart';
import 'package:vivinstore/widgets/size_selection_dialog.dart';
import 'package:vivinstore/models/dress.dart';

class WishlistDialog extends StatelessWidget {
  final List<Dress> wishlist;
  final Function(Dress) onRemove;
  final Function(Dress, String) onAddToCart;

  const WishlistDialog({
    Key? key,
    required this.wishlist,
    required this.onRemove,
    required this.onAddToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Wishlist'),
      content: SizedBox(
        width: double.maxFinite,
        height: 400,
        child: wishlist.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.favorite_border, size: 64, color: Colors.grey),
                    SizedBox(height: 16),
                    Text('Your wishlist is empty'),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: wishlist.length,
                itemBuilder: (context, index) {
                  final dress = wishlist[index];
                  return Card(
                    child: ListTile(
                      leading: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: NetworkImage(dress.imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      title: Text(dress.name),
                      subtitle: Text('\$${dress.price.toStringAsFixed(2)}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.add_shopping_cart,
                                color: Color(0xFF2C1810)),
                            onPressed: () {
                              Navigator.of(context).pop();
                              showDialog(
                                context: context,
                                builder: (context) => SizeSelectionDialog(
                                  dress: dress,
                                  onAddToCart: onAddToCart,
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => onRemove(dress),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Close'),
        ),
      ],
    );
  }
}
