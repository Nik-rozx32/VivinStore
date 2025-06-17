import 'package:flutter/material.dart';
import 'package:vivinstore/models/dress.dart';
import 'package:vivinstore/models/cart_item.dart';
import 'package:vivinstore/models/review.dart';

class ProductDetailPage extends StatefulWidget {
  final Dress dress;
  final Function(Dress, String) onAddToCart;
  final Function(Dress)? onToggleWishlist;
  final bool isWishlisted;
  final List<Review>? reviews; // Add reviews parameter

  const ProductDetailPage({
    Key? key,
    required this.dress,
    required this.onAddToCart,
    this.onToggleWishlist,
    this.isWishlisted = false,
    this.reviews, // Make reviews optional
  }) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  PageController _pageController = PageController();
  int _currentImageIndex = 0;
  String _selectedSize = '';
  bool _isWishlisted = false;
  List<Review> _reviews = []; // Dynamic reviews list

  // Sample product images (in real app, these would come from the dress model)
  late List<String> productImages;

  @override
  void initState() {
    super.initState();
    _isWishlisted = widget.isWishlisted;
    _reviews =
        widget.reviews ?? []; // Initialize with provided reviews or empty list

    // Initialize product images (using multiple versions of the same image for demo)
    productImages = [
      widget.dress.imageUrl,
      'https://images.unsplash.com/photo-1539008835657-9e8e9680c956?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1515372039744-b8f02a3ae446?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1566479179817-491fcd79daa4?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
    ];

    // Set default size if available
    if (widget.dress.sizes.isNotEmpty) {
      _selectedSize = widget.dress.sizes[0];
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  double get averageRating {
    if (_reviews.isEmpty) return 0.0;
    return _reviews.map((r) => r.rating).reduce((a, b) => a + b) /
        _reviews.length;
  }

  // Method to add a new review dynamically
  void addReview(Review review) {
    setState(() {
      _reviews.add(review);
    });
  }

  // Method to update reviews list (useful for fetching from API)
  void updateReviews(List<Review> newReviews) {
    setState(() {
      _reviews = newReviews;
    });
  }

  void _addToCart() {
    if (_selectedSize.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select a size first'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    widget.onAddToCart(widget.dress, _selectedSize);
  }

  void _toggleWishlist() {
    setState(() {
      _isWishlisted = !_isWishlisted;
    });
    widget.onToggleWishlist?.call(widget.dress);
  }

  // Method to show add review dialog
  void _showAddReviewDialog() {
    String userName = '';
    String comment = '';
    double rating = 5.0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text('Add Review'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Your Name',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) => userName = value,
                    ),
                    SizedBox(height: 16),
                    Text('Rating: ${rating.toInt()}/5'),
                    Slider(
                      value: rating,
                      min: 1,
                      max: 5,
                      divisions: 4,
                      onChanged: (value) {
                        setDialogState(() {
                          rating = value;
                        });
                      },
                    ),
                    SizedBox(height: 16),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Your Review',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                      onChanged: (value) => comment = value,
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (userName.isNotEmpty && comment.isNotEmpty) {
                      final newReview = Review(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        userName: userName,
                        rating: rating,
                        comment: comment,
                        date: DateTime.now(),
                        userAvatar: userName.isNotEmpty
                            ? userName[0].toUpperCase()
                            : 'U',
                      );
                      addReview(newReview);
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Review added successfully!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2C1810),
                  ),
                  child:
                      Text('Add Review', style: TextStyle(color: Colors.white)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return Scaffold(
      backgroundColor: Color(0xFFFAF9F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: Text(
          'Product Details',
          style: TextStyle(
            fontSize: isSmallScreen ? 18 : 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        // Removed the favorite icon from app bar actions
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Images Carousel
            Container(
              height: isSmallScreen ? 300 : 400,
              child: Stack(
                children: [
                  PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentImageIndex = index;
                      });
                    },
                    itemCount: productImages.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            productImages[index],
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[300],
                                child: Icon(
                                  Icons.image_not_supported,
                                  size: 50,
                                  color: Colors.grey[600],
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  // Image indicators
                  Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: productImages.asMap().entries.map((entry) {
                        return Container(
                          width: 8,
                          height: 8,
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentImageIndex == entry.key
                                ? Color(0xFFD4AF37)
                                : Colors.white.withOpacity(0.5),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),

            // Product Information
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name and Price
                  Text(
                    widget.dress.name,
                    style: TextStyle(
                      fontSize: isSmallScreen ? 24 : 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C1810),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'RS. ${widget.dress.price.toStringAsFixed(0)}',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 20 : 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 16),

                  // Rating (only show if reviews exist)
                  if (_reviews.isNotEmpty) ...[
                    Row(
                      children: [
                        Row(
                          children: List.generate(5, (index) {
                            return Icon(
                              index < averageRating.floor()
                                  ? Icons.star
                                  : index == averageRating.floor() &&
                                          averageRating % 1 != 0
                                      ? Icons.star_half
                                      : Icons.star_border,
                              color: Colors.amber,
                              size: 20,
                            );
                          }),
                        ),
                        SizedBox(width: 8),
                        Text(
                          '${averageRating.toStringAsFixed(1)} (${_reviews.length} reviews)',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],

                  // Size Selection
                  Text(
                    'Size',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C1810),
                    ),
                  ),
                  SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: widget.dress.sizes.map((size) {
                      final isSelected = _selectedSize == size;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedSize = size;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color:
                                isSelected ? Color(0xFF2C1810) : Colors.white,
                            border: Border.all(
                              color: isSelected
                                  ? Color(0xFF2C1810)
                                  : Colors.grey[300]!,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            size,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 30),

                  // Product Description
                  Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C1810),
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'This elegant dress is crafted from premium materials and designed for comfort and style. Perfect for both casual and formal occasions. The dress features a flattering silhouette that complements all body types.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 30),

                  // Reviews Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Reviews (${_reviews.length})',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2C1810),
                        ),
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: _showAddReviewDialog,
                            child: Text(
                              'Add Review',
                              style: TextStyle(
                                color: Color(0xFFD4AF37),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          if (_reviews.isNotEmpty)
                            TextButton(
                              onPressed: () {
                                // TODO: Navigate to all reviews page
                              },
                              child: Text(
                                'View All',
                                style: TextStyle(
                                  color: Color(0xFFD4AF37),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),

                  // Reviews List or No Reviews Message
                  if (_reviews.isEmpty)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.rate_review_outlined,
                            size: 48,
                            color: Colors.grey[400],
                          ),
                          SizedBox(height: 12),
                          Text(
                            'No reviews yet',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Be the first to review this product!',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Column(
                      children: _reviews.take(3).map((review) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 16),
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 8,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Color(0xFF2C1810),
                                    radius: 20,
                                    child: Text(
                                      review.userAvatar,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          review.userName,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Row(
                                              children:
                                                  List.generate(5, (index) {
                                                return Icon(
                                                  index < review.rating.floor()
                                                      ? Icons.star
                                                      : index ==
                                                                  review.rating
                                                                      .floor() &&
                                                              review.rating %
                                                                      1 !=
                                                                  0
                                                          ? Icons.star_half
                                                          : Icons.star_border,
                                                  color: Colors.amber,
                                                  size: 16,
                                                );
                                              }),
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              _formatDate(review.date),
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12),
                              Text(
                                review.comment,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: _addToCart,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2C1810),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Add to Cart',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(width: 16),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF2C1810)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                onPressed: _toggleWishlist,
                icon: Icon(
                  _isWishlisted ? Icons.favorite : Icons.favorite_border,
                  color: _isWishlisted ? Colors.red : Color(0xFF2C1810),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;

    if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Yesterday';
    } else if (difference < 7) {
      return '$difference days ago';
    } else if (difference < 30) {
      final weeks = (difference / 7).floor();
      return '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
    } else {
      final months = (difference / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    }
  }
}
