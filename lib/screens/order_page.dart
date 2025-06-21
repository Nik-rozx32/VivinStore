import 'package:flutter/material.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 152, 0),
        elevation: 0,
        title: const Text(
          'My Orders',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),

            // Current Orders Section
            _buildSectionHeader('Current Orders'),
            const SizedBox(height: 8),
            _buildCurrentOrderCard(
              orderNumber: '#FL123456789',
              productName: 'Samsung Galaxy S24 Ultra (Titanium Black, 256GB)',
              orderDate: 'Ordered on 15 Jun 2025',
              status: 'On the way',
              statusColor: const Color.fromARGB(255, 255, 152, 0),
              deliveryDate: 'Expected by 18 Jun 2025',
              imageUrl: 'https://via.placeholder.com/80x80',
            ),
            const SizedBox(height: 8),
            _buildCurrentOrderCard(
              orderNumber: '#FL987654321',
              productName: 'Nike Air Max 270 Running Shoes',
              orderDate: 'Ordered on 12 Jun 2025',
              status: 'Shipped',
              statusColor: const Color.fromARGB(255, 255, 0, 0),
              deliveryDate: 'Expected by 19 Jun 2025',
              imageUrl: 'https://via.placeholder.com/80x80',
            ),

            const SizedBox(height: 24),

            // Delivered Orders Section
            _buildSectionHeader('Delivered Orders'),
            const SizedBox(height: 8),
            _buildDeliveredOrderCard(
              orderNumber: '#FL456789123',
              productName: 'Apple iPhone 15 Pro Max (Natural Titanium, 512GB)',
              orderDate: 'Ordered on 28 May 2025',
              deliveredDate: 'Delivered on 2 Jun 2025',
              rating: true,
              imageUrl: 'https://via.placeholder.com/80x80',
            ),
            const SizedBox(height: 8),
            _buildDeliveredOrderCard(
              orderNumber: '#FL789123456',
              productName: 'Sony WH-1000XM5 Wireless Headphones',
              orderDate: 'Ordered on 20 May 2025',
              deliveredDate: 'Delivered on 25 May 2025',
              rating: true,
              imageUrl: 'https://via.placeholder.com/80x80',
            ),
            const SizedBox(height: 8),
            _buildDeliveredOrderCard(
              orderNumber: '#FL321654987',
              productName: 'Lenovo ThinkPad E14 Laptop (Intel i5, 8GB RAM)',
              orderDate: 'Ordered on 10 May 2025',
              deliveredDate: 'Delivered on 18 May 2025',
              rating: false,
              imageUrl: 'https://via.placeholder.com/80x80',
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildCurrentOrderCard({
    required String orderNumber,
    required String productName,
    required String orderDate,
    required String status,
    required Color statusColor,
    required String deliveryDate,
    required String imageUrl,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[200],
                    ),
                    child: const Icon(
                      Icons.image,
                      color: Colors.grey,
                      size: 40,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productName,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          orderNumber,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          orderDate,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: statusColor,
                      ),
                    ),
                  ),
                  Text(
                    deliveryDate,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color.fromARGB(255, 255, 152, 0),
                        side: BorderSide(
                            color: const Color.fromARGB(255, 255, 152, 0)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: const Text('Track Package'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.grey[700],
                        side: BorderSide(color: Colors.grey[400]!),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: const Text('View Details'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeliveredOrderCard({
    required String orderNumber,
    required String productName,
    required String orderDate,
    required String deliveredDate,
    required bool rating,
    required String imageUrl,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[200],
                    ),
                    child: const Icon(
                      Icons.image,
                      color: Colors.grey,
                      size: 40,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productName,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          orderNumber,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          orderDate,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: 14,
                          color: Colors.green[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Delivered',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.green[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    deliveredDate,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color.fromARGB(255, 255, 152, 0),
                        side: BorderSide(
                            color: const Color.fromARGB(255, 255, 152, 0)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: Text(rating ? 'Update Review' : 'Rate & Review'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.grey[700],
                        side: BorderSide(color: Colors.grey[400]!),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: const Text('Buy Again'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 152, 0),
        elevation: 0,
        title: const Text(
          'My Account',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header Section
            Container(
              width: double.infinity,
              color: const Color.fromARGB(255, 255, 152, 0),
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Text(
                      'JD',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 255, 152, 0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Hello John Doe',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'john.doe@email.com',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Orders Section
            _buildSection([
              _buildMenuItem(
                icon: Icons.shopping_bag_outlined,
                title: 'Orders',
                subtitle: 'Check your order status',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OrdersPage(),
                    ),
                  );
                },
              ),
            ]),

            const SizedBox(height: 12),

            // Account Settings Section
            _buildSection([
              _buildMenuItem(
                icon: Icons.person_outline,
                title: 'Account Settings',
                subtitle: 'Profile information, addresses',
                onTap: () {},
              ),
              _buildMenuItem(
                icon: Icons.payment_outlined,
                title: 'Payments',
                subtitle: 'Manage payment methods & settings',
                onTap: () {},
              ),
              _buildMenuItem(
                icon: Icons.card_giftcard_outlined,
                title: 'My Rewards',
                subtitle: 'Coupons, credits and gift cards',
                onTap: () {},
              ),
            ]),

            const SizedBox(height: 12),

            // My Activity Section
            _buildSection([
              _buildMenuItem(
                icon: Icons.rate_review_outlined,
                title: 'My Reviews & Ratings',
                subtitle: 'Review your purchases',
                onTap: () {},
              ),
              _buildMenuItem(
                icon: Icons.help_outline,
                title: 'My Questions & Answers',
                subtitle: 'View your Q&As',
                onTap: () {},
              ),
            ]),

            const SizedBox(height: 12),

            // Earn with Flipkart Section
            _buildSection([
              _buildMenuItem(
                icon: Icons.storefront_outlined,
                title: 'Sell on Flipkart',
                subtitle: 'Start your business on Flipkart',
                onTap: () {},
              ),
            ]),

            const SizedBox(height: 12),

            // Feedback & Information Section
            _buildSection([
              _buildMenuItem(
                icon: Icons.feedback_outlined,
                title: 'Feedback',
                subtitle: 'We\'d love to hear from you',
                onTap: () {},
              ),
              _buildMenuItem(
                icon: Icons.info_outline,
                title: 'About',
                subtitle: 'About us, careers, press',
                onTap: () {},
              ),
              _buildMenuItem(
                icon: Icons.help_center_outlined,
                title: 'Help Center',
                subtitle: 'Help regarding your recent purchases',
                onTap: () {},
              ),
            ]),

            const SizedBox(height: 12),

            // Legal Section
            _buildSection([
              _buildMenuItem(
                icon: Icons.policy_outlined,
                title: 'Terms, Policies and Licenses',
                subtitle: 'Legal information',
                onTap: () {},
              ),
            ]),

            const SizedBox(height: 12),

            // Browse Categories
            _buildSection([
              _buildMenuItem(
                icon: Icons.category_outlined,
                title: 'Browse Categories',
                subtitle: 'Explore all categories',
                onTap: () {},
              ),
            ]),

            const SizedBox(height: 20),

            // Logout Button
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color.fromARGB(255, 255, 152, 0),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                    side: BorderSide(
                        color: const Color.fromARGB(255, 255, 152, 0)),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              icon,
              size: 24,
              color: Colors.grey[600],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }
}
