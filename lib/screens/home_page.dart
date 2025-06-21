import 'package:flutter/material.dart';
import 'package:vivinstore/models/cart_item.dart';
import 'package:vivinstore/models/dress.dart';
import 'package:vivinstore/models/user.dart';
import 'package:vivinstore/widgets/dress_card.dart';
import 'package:vivinstore/widgets/image_carousel.dart';
import 'package:vivinstore/screens/wishlist_page.dart';
import 'package:vivinstore/screens/cart_page.dart';
import 'package:vivinstore/screens/profile_page.dart';
import 'package:vivinstore/screens/login_page.dart';

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

  final List<Dress> dresses = [];

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
        leading: isSmallScreen
            ? Builder(
                builder: (context) => IconButton(
                  icon: Icon(Icons.menu, color: Colors.black),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              )
            : null,
        title: !showSearchBar
            ? Row(
                mainAxisSize: MainAxisSize.min,
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
            // Show wishlist and cart only on larger screens
            if (!isSmallScreen) ...[
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
              // Cart Button
              Stack(
                children: [
                  IconButton(
                    icon: Icon(Icons.shopping_cart, color: Colors.black),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartPage(
                            cart: cart,
                            totalPrice: totalPrice,
                            onRemove: removeFromCart,
                            onUpdateQuantity: (index, newQuantity) {
                              setState(() {
                                if (newQuantity > 0) {
                                  cart[index].quantity = newQuantity;
                                } else {
                                  cart.removeAt(index);
                                }
                              });
                            },
                          ),
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
            ],
            // Profile/Login Button
            if (currentUser != null)
              IconButton(
                icon: const Icon(Icons.person, color: Colors.black),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ProfilePage(),
                    ),
                  );
                },
              )
            else
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF2C1810)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            SizedBox(width: isSmallScreen ? 5 : 16),
          ],
        ],
      ),
      drawer: isSmallScreen
          ? Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Color(0xFFD4AF37),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset('lib/assets/logo.png',
                                height: 40, width: 40),
                            SizedBox(width: 8),
                            Text(
                              'Vivin Store',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        if (currentUser != null)
                          Text(
                            'Welcome, ${currentUser!.name}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: Stack(
                      children: [
                        Icon(Icons.favorite_border, color: Colors.black),
                        if (wishlist.isNotEmpty)
                          Positioned(
                            right: 0,
                            top: 0,
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
                                  fontSize: 10,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                      ],
                    ),
                    title: Text('Wishlist'),
                    onTap: () {
                      Navigator.pop(context);
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
                  ListTile(
                    leading: Stack(
                      children: [
                        Icon(Icons.shopping_cart, color: Colors.black),
                        if (cart.isNotEmpty)
                          Positioned(
                            right: 0,
                            top: 0,
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
                                  fontSize: 10,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                      ],
                    ),
                    title: Text('Cart'),
                    trailing: cart.isNotEmpty
                        ? Text(
                            '\$${totalPrice.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFD4AF37),
                            ),
                          )
                        : null,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartPage(
                            cart: cart,
                            totalPrice: totalPrice,
                            onRemove: removeFromCart,
                            onUpdateQuantity: (index, newQuantity) {
                              setState(() {
                                if (newQuantity > 0) {
                                  cart[index].quantity = newQuantity;
                                } else {
                                  cart.removeAt(index);
                                }
                              });
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  Divider(),
                  if (currentUser != null) ...[
                    ListTile(
                      leading: Icon(Icons.person, color: Colors.black),
                      title: Text('Profile'),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ProfilePage(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.logout, color: Colors.red),
                      title: Text('Logout'),
                      onTap: () {
                        Navigator.pop(context);
                        logout();
                      },
                    ),
                  ] else
                    ListTile(
                      leading: Icon(Icons.login, color: Colors.green),
                      title: Text('Login'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                    ),
                ],
              ),
            )
          : null,
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
                  : GridView.builder(
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
                          onToggleWishlist: toggleWishlist,
                          isWishlisted: isInWishlist(dress),
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
