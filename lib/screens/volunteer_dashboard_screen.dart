import 'package:flutter/material.dart';

class VolunteerDashboardScreen extends StatelessWidget {
  const VolunteerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Volunteer & Receiver Panel"),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ১. ওয়েলকাম হেডার
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
                    value: "5 Items",
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

            // ডেমো এভেইলেবল ফুড কার্ড ১
            _buildAvailableFoodCard(
              context,
              title: "Fresh Biryani Packets",
              quantity: "20 Portions",
              location: "Gulshan-2, Dhaka",
              donor: "Rahim Restaurant",
              onClaim: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Food claim requested successfully!")),
                );
              },
            ),

            // ডেমো এভেইলেবল ফুড কার্ড ২
            _buildAvailableFoodCard(
              context,
              title: "Mixed Vegetable & Roti",
              quantity: "10 Persons",
              location: "Banani, Dhaka",
              donor: "Community Kitchen",
              onClaim: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Food claim requested successfully!")),
                );
              },
            ),
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
  Widget _buildAvailableFoodCard(
    BuildContext context, {
    required String title,
    required String quantity,
    required String location,
    required String donor,
    required VoidCallback onClaim,
  }) {
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
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    quantity,
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
                Text(location, style: const TextStyle(color: Colors.grey, fontSize: 13)),
                const SizedBox(width: 16),
                const Icon(Icons.person, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text(donor, style: const TextStyle(color: Colors.grey, fontSize: 13)),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onClaim,
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