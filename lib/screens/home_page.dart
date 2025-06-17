import 'package:flutter/material.dart';
import 'package:vivinstore/models/cart_item.dart';
import 'package:vivinstore/models/dress.dart';
import 'package:vivinstore/models/user.dart';
import 'dart:async';
import 'package:flutter/rendering.dart';
import 'package:vivinstore/widgets/cart_dialog.dart';
import 'package:vivinstore/widgets/dress_card.dart';
import 'package:vivinstore/screens/wishlist_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CartItem> cart = [];
  List<Dress> wishlist = [];
  String selectedCategory = 'All';
  String searchQuery = '';
  User? currentUser;
  TextEditingController searchController = TextEditingController();
  bool showSearchBar = false;

  final List<Dress> dresses = [
    Dress(
      id: '1',
      name: 'Elegant Evening Gown',
      price: 299.99,
      imageUrl: 'lib/image/pic1.jpg',
      category: 'Women',
      sizes: ['XS', 'S', 'M', 'L', 'XL'],
    ),
    Dress(
      id: '2',
      name: 'Floral Dress',
      price: 89.99,
      imageUrl: 'lib/image/pic1.jpg',
      category: 'Men',
      sizes: ['S', 'M', 'L', 'XL'],
    ),
    Dress(
      id: '3',
      name: ' Midi Dress',
      price: 159.99,
      imageUrl: 'lib/image/pic1.jpg',
      category: 'Kids',
      sizes: ['XS', 'S', 'M', 'L'],
    ),
    Dress(
      id: '4',
      name: 'Cocktail Party Dress',
      price: 199.99,
      imageUrl: 'lib/image/pic1.jpg',
      category: 'Women',
      sizes: ['S', 'M', 'L', 'XL'],
    ),
    Dress(
      id: '5',
      name: 'Bohemian Maxi Dress',
      price: 129.99,
      imageUrl: 'lib/image/pic1.jpg',
      category: 'Men',
      sizes: ['S', 'M', 'L', 'XL', 'XXL'],
    ),
    Dress(
      id: '6',
      name: 'Little Black Dress',
      price: 179.99,
      imageUrl: 'lib/image/pic1.jpg',
      category: 'Women',
      sizes: ['XS', 'S', 'M', 'L'],
    ),
  ];

  List<Dress> get filteredDresses {
    List<Dress> filtered = dresses;

    // Filter by category
    if (selectedCategory != 'All') {
      filtered = filtered
          .where((dress) => dress.category == selectedCategory)
          .toList();
    }

    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered
          .where((dress) =>
              dress.name.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }

    return filtered;
  }

  void addToCart(Dress dress, String size) {
    setState(() {
      final existingItem = cart.firstWhere(
        (item) => item.dress.id == dress.id && item.size == size,
        orElse: () => CartItem(dress: dress, size: size, quantity: 0),
      );

      if (existingItem.quantity > 0) {
        existingItem.quantity++;
      } else {
        cart.add(CartItem(dress: dress, size: size));
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${dress.name} added to cart!'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void removeFromCart(int index) {
    setState(() {
      cart.removeAt(index);
    });
  }

  void toggleWishlist(Dress dress) {
    setState(() {
      if (wishlist.any((item) => item.id == dress.id)) {
        wishlist.removeWhere((item) => item.id == dress.id);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${dress.name} removed from wishlist!'),
            backgroundColor: Colors.orange,
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        wishlist.add(dress);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${dress.name} added to wishlist!'),
            backgroundColor: Colors.black,
            duration: Duration(seconds: 2),
          ),
        );
      }
    });
  }

  bool isInWishlist(Dress dress) {
    return wishlist.any((item) => item.id == dress.id);
  }

  void login(String name, String email) {
    setState(() {
      currentUser = User(name: name, email: email);
    });
  }

  void logout() {
    setState(() {
      currentUser = null;
    });
  }

  void onSearchChanged(String value) {
    setState(() {
      searchQuery = value;
    });
  }

  void toggleSearchBar() {
    setState(() {
      showSearchBar = !showSearchBar;
      if (!showSearchBar) {
        searchController.clear();
        searchQuery = '';
      }
    });
  }

  double get totalPrice {
    return cart.fold(
        0, (sum, item) => sum + (item.dress.price * item.quantity));
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
        title: !showSearchBar
            ? Row(
                children: [
                  Image.asset('lib/assets/logo.png', height: 50, width: 50),
                  SizedBox(width: 4),
                  Text(
                    'Vivin Store',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 20 : 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              )
            : null,
        actions: [
          if (showSearchBar)
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TextField(
                  controller: searchController,
                  onChanged: onSearchChanged,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: 'Search dresses...',
                    hintStyle: TextStyle(color: Colors.black.withOpacity(0.7)),
                    prefixIcon: Icon(Icons.search,
                        color: Colors.black.withOpacity(0.7)),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.close,
                          color: Colors.black.withOpacity(0.7)),
                      onPressed: toggleSearchBar,
                    ),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
              ),
            ),
          if (!showSearchBar) ...[
            IconButton(
              icon: Icon(Icons.search, color: Colors.black),
              onPressed: toggleSearchBar,
            ),
            // Wishlist Button
            Stack(
              children: [
                IconButton(
                  icon: Icon(Icons.favorite_border, color: Colors.black),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => WishlistPage(
                          wishlist: wishlist,
                          onRemove: (dress) {
                            setState(() {
                              wishlist
                                  .removeWhere((item) => item.id == dress.id);
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    '${dress.name} removed from wishlist!'),
                                backgroundColor: Colors.orange,
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                          onAddToCart: addToCart,
                        ),
                      ),
                    );
                  },
                ),
                if (wishlist.isNotEmpty)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        '${wishlist.length}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            // Login/Profile Button
            IconButton(
              icon: Icon(
                currentUser != null ? Icons.account_circle : Icons.login,
                color: Colors.black,
              ),
              onPressed: () {
                if (currentUser != null) {
                  showDialog(
                    context: context,
                    builder: (context) => ProfileDialog(
                      user: currentUser!,
                      onLogout: logout,
                    ),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => LoginDialog(onLogin: login),
                  );
                }
              },
            ),
            // Cart Button
            Stack(
              children: [
                IconButton(
                  icon: Icon(Icons.shopping_cart, color: Colors.black),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => CartDialog(
                        cart: cart,
                        totalPrice: totalPrice,
                        onRemove: removeFromCart,
                      ),
                    );
                  },
                ),
                if (cart.isNotEmpty)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        '${cart.length}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(width: isSmallScreen ? 8 : 16),
          ],
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Image Carousel
            ImageCarousel(),

            // Category Filter
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    'Shop by Category',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 22 : 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C1810),
                    ),
                  ),
                  SizedBox(height: 20),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: ['All', 'New Arrival', 'Men', 'Women', 'Kids']
                          .map((category) => Padding(
                                padding: EdgeInsets.only(right: 8),
                                child: FilterChip(
                                  label: Text(category),
                                  selected: selectedCategory == category,
                                  onSelected: (selected) {
                                    setState(() {
                                      selectedCategory = category;
                                    });
                                  },
                                  selectedColor: Color(0xFFD4AF37),
                                  checkmarkColor: Color(0xFF2C1810),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),

            // Search Results Info
            if (searchQuery.isNotEmpty)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Showing ${filteredDresses.length} results for "$searchQuery"',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF2C1810),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),

            // Products Grid
            Container(
              padding: EdgeInsets.all(20),
              child: filteredDresses.isEmpty
                  ? Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 64,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'No dresses found',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                          if (searchQuery.isNotEmpty)
                            TextButton(
                              onPressed: () {
                                searchController.clear();
                                onSearchChanged('');
                              },
                              child: Text('Clear search'),
                            ),
                        ],
                      ),
                    )
                  : // Replace your GridView.builder in HomePage with this:
                  GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: screenWidth > 1200
                            ? 3
                            : screenWidth > 800
                                ? 2
                                : 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.85,
                      ),
                      itemCount: filteredDresses.length,
                      itemBuilder: (context, index) {
                        final dress = filteredDresses[index];
                        return DressCard(
                          dress: dress,
                          onAddToCart: addToCart,
                          onToggleWishlist: toggleWishlist, // This was missing
                          isWishlisted: isInWishlist(dress), // This was missing
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginDialog extends StatefulWidget {
  final Function(String, String) onLogin;

  const LoginDialog({Key? key, required this.onLogin}) : super(key: key);

  @override
  _LoginDialogState createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Login'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!value.contains('@')) {
                  return 'Please enter a valid email';
                }
                return null;
              },
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
            if (_formKey.currentState!.validate()) {
              widget.onLogin(_nameController.text, _emailController.text);
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Welcome, ${_nameController.text}!'),
                  backgroundColor: Colors.green,
                ),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF2C1810),
            foregroundColor: Colors.white,
          ),
          child: Text('Login'),
        ),
      ],
    );
  }
}

class ProfileDialog extends StatelessWidget {
  final User user;
  final VoidCallback onLogout;

  const ProfileDialog({Key? key, required this.user, required this.onLogout})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Profile'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Color(0xFF2C1810),
                child: Text(
                  user.name[0].toUpperCase(),
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(user.email, style: TextStyle(color: Colors.grey)),
                ],
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Close'),
        ),
        ElevatedButton(
          onPressed: () {
            onLogout();
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Logged out successfully'),
                backgroundColor: Colors.orange,
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
          child: Text('Logout'),
        ),
      ],
    );
  }
}

// Continue with the rest of the original classes...
class ImageCarousel extends StatefulWidget {
  const ImageCarousel({super.key});

  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  int currentIndex = 0;
  Timer? timer;
  PageController pageController = PageController();

  final List<String> carouselImages = [
    'https://images.unsplash.com/photo-1539008835657-9e8e9680c956?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
    'https://images.unsplash.com/photo-1515372039744-b8f02a3ae446?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
    'https://images.unsplash.com/photo-1566479179817-491fcd79daa4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
    'https://images.unsplash.com/photo-1594633312681-425c7b97ccd1?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
    'https://images.unsplash.com/photo-1485968579580-b6d095142e6e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
  ];

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 2), (Timer timer) {
      if (currentIndex < carouselImages.length - 1) {
        currentIndex++;
      } else {
        currentIndex = 0;
      }

      if (pageController.hasClients) {
        pageController.animateToPage(
          currentIndex,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Stack(
        children: [
          PageView.builder(
            controller: pageController,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemCount: carouselImages.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(carouselImages[index]),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.3),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: carouselImages.asMap().entries.map((entry) {
                return Container(
                  width: 8,
                  height: 8,
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentIndex == entry.key
                        ? Color(0xFFD4AF37)
                        : Colors.white.withOpacity(0.5),
                  ),
                );
              }).toList(),
            ),
          ),
          Positioned(
            left: 16,
            top: 0,
            bottom: 0,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  if (currentIndex > 0) {
                    currentIndex--;
                    pageController.animateToPage(
                      currentIndex,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 16,
            top: 0,
            bottom: 0,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  if (currentIndex < carouselImages.length - 1) {
                    currentIndex++;
                    pageController.animateToPage(
                      currentIndex,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
