import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class CategoryFilter extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const CategoryFilter({
    Key? key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            'Shop by Category',
            style: AppTheme.sectionTitle,
          ),
          SizedBox(height: 20),
          Wrap(
            spacing: 10,
            children: categories
                .map((category) => FilterChip(
                      label: Text(category),
                      selected: selectedCategory == category,
                      onSelected: (selected) => onCategorySelected(category),
                      selectedColor: AppTheme.accent,
                      checkmarkColor: AppTheme.primaryDark,
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
