import 'package:flutter/material.dart';
import '../models/food_item.dart';
import '../services/food_repository.dart';

class VolunteerDashboardScreen extends StatefulWidget {
  const VolunteerDashboardScreen({super.key});

  @override
  State<VolunteerDashboardScreen> createState() => _VolunteerDashboardScreenState();
}

class _VolunteerDashboardScreenState extends State<VolunteerDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    // শুধুমাত্র যেসব পোস্ট Admin থেকে 'Approved' হয়েছে সেগুলো ফিল্টার করে নেওয়া
    final approvedList = FoodRepository.allItems
        .where((item) => item.status == 'Approved')
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Volunteer & Receiver Panel"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ১. ওয়েলকাম হেডার
            const Text(
              "Hello, Hero Volunteer! 🤝",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Find available surplus food and deliver to those in need.",
              style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
            ),
            const SizedBox(height: 20),

            // ২. কুইক স্ট্যাটস কার্ড
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    title: "Available Foods",
                    value: "${approvedList.length} Items",
                    icon: Icons.fastfood,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    title: "Completed Deliveries",
                    value: "8 Deliveries",
                    icon: Icons.check_circle_outline,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // ৩. এভেইলেবল ফুড লিস্ট সেকশন হেডিং
            const Text(
              "Available Food Donations Near You",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            // যদি কোনো Approved পোস্ট না থাকে
            if (approvedList.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 30.0),
                  child: Text(
                    "No approved food items available right now 🍲",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ),
              )
            else
              ...approvedList.map((item) => _buildAvailableFoodCard(context, item)),
          ],
        ),
      ),
    );
  }

  // স্ট্যাটাস কার্ড হেল্পার
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

  // এভেইলেবল ফুড আইটেম কার্ড
  Widget _buildAvailableFoodCard(BuildContext context, FoodItem item) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    item.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    item.quantity,
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_on, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text(item.location, style: const TextStyle(color: Colors.grey, fontSize: 13)),
                const SizedBox(width: 16),
                const Icon(Icons.phone, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text(item.phone, style: const TextStyle(color: Colors.grey, fontSize: 13)),
              ],
            ),
            if (item.description.isNotEmpty) ...[
              const SizedBox(height: 6),
              Text(
                "Note: ${item.description}",
                style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: Colors.black54),
              ),
            ],
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // ক্লিম করার পর লিস্ট থেকে রিমুভ বা স্ট্যাটাস আপডেট করা
                  setState(() {
                    FoodRepository.updateStatus(item.id, 'Claimed');
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Food claim requested successfully! Thank you hero! ❤️"),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text("Claim / Request Food"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}