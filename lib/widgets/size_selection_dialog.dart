import 'package:flutter/material.dart';
import '../models/dress.dart';
import '../utils/app_theme.dart';

class SizeSelectionDialog extends StatefulWidget {
  final Dress dress;
  final Function(Dress, String) onAddToCart;

  const SizeSelectionDialog({
    Key? key,
    required this.dress,
    required this.onAddToCart,
  }) : super(key: key);

  @override
  _SizeSelectionDialogState createState() => _SizeSelectionDialogState();
}

class _SizeSelectionDialogState extends State<SizeSelectionDialog> {
  String? selectedSize;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Size'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Choose a size for ${widget.dress.name}'),
          SizedBox(height: 16),
          Wrap(
            spacing: 8,
            children: widget.dress.sizes.map((size) {
              return ChoiceChip(
                label: Text(size),
                selected: selectedSize == size,
                onSelected: (selected) {
                  setState(() {
                    selectedSize = selected ? size : null;
                  });
                },
                selectedColor: AppTheme.accent,
              );
            }).toList(),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: selectedSize != null ? _addToCart : null,
          child: Text('Add to Cart'),
        ),
      ],
    );
  }

  void _addToCart() {
    widget.onAddToCart(widget.dress, selectedSize!);
    Navigator.of(context).pop();
  }
}
