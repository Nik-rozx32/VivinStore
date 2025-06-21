import 'package:flutter/material.dart';
import 'order_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.orange,
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
