import 'package:flutter/material.dart';
import 'donate_screen.dart';

class DonorDashboardScreen extends StatelessWidget {
  const DonorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Donor Dashboard"),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {
              // নোটিফিকেশন ফিউচারে যুক্ত করা হবে
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ১. ওয়েলকাম হেডার
            const Text(
              "Hello, Generous Donor! 👋",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Share your surplus food with those in need.",
              style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
            ),
            const SizedBox(height: 20),

            // ২. সামারি কার্ডস (Quick Stats)
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    title: "Total Donated",
                    value: "12 Times",
                    icon: Icons.volunteer_activism,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    title: "Active Posts",
                    value: "2 Food Items",
                    icon: Icons.fastfood,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // ৩. নতুন ডোনেশন পোস্ট করার অ্যাকশন কার্ড
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: Colors.orange.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.orange,
                      radius: 24,
                      child: Icon(Icons.add, color: Colors.white, size: 28),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Have Food to Share?",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Post surplus food in a few clicks",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        // সরাসরি ডোনেট স্ক্রিনে নিয়ে যাওয়া
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DonateScreen(),
                          ),
                        );
                      },
                      child: const Text("Donate Now"),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // ৪. মাই ডোনেশন হিস্ট্রি শিরোনাম
            const Text(
              "Your Recent Posts",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            // ডেমো সাম্প্রতিক পোস্ট
            _buildRecentDonationItem(
              title: "Cooked Rice & Chicken Curry",
              quantity: "For 10-12 people",
              timeAgo: "2 hours ago",
              status: "Pending Pickup",
              statusColor: Colors.orange,
            ),
            _buildRecentDonationItem(
              title: "Fresh Bread & Biscuits",
              quantity: "For 5 people",
              timeAgo: "1 day ago",
              status: "Completed",
              statusColor: Colors.green,
            ),
          ],
        ),
      ),
    );
  }

  // স্ট্যাটাস বা সামারি কার্ড তৈরি করার উইজেট
  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 12),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  // সাম্প্রতিক ডোনেশন আইটেমের লিস্ট টাইল উইজেট
  Widget _buildRecentDonationItem({
    required String title,
    required String quantity,
    required String timeAgo,
    required String status,
    required Color statusColor,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: statusColor.withValues(alpha: 0.1),
          child: Icon(Icons.restaurant, color: statusColor, size: 20),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
        subtitle: Text("$quantity • $timeAgo"),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: statusColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            status,
            style: TextStyle(
              color: statusColor,
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
        ),
      ),
    );
  }
}