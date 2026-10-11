import 'package:flutter/material.dart';
import 'admin_dashboard_screen.dart'; // এডমিন ড্যাশবোর্ড স্ক্রিন ইম্পোর্ট করা হলো
import 'donor_dashboard_screen.dart'; // ডোনর ড্যাশবোর্ড স্ক্রিন ইম্পোর্ট করা হলো
import 'volunteer_dashboard_screen.dart'; // ভলান্টিয়ার ড্যাশবোর্ড স্ক্রিন ইম্পোর্ট করা হলো

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text("Welcome to OnnoMaya"),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.volunteer_activism,
              size: 80,
              color: Colors.orange,
            ),
            const SizedBox(height: 16),
            const Text(
              "Select Your Role",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Choose how you want to contribute to the community",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 40),

            // ১. Donor Card / Button
            _buildRoleCard(
              context,
              title: "Donor Panel",
              subtitle: "Donate surplus food for humans and stray animals",
              icon: Icons.fastfood,
              color: Colors.orange,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DonorDashboardScreen()),
                );
              },
            ),
            const SizedBox(height: 16),

            // ২. Volunteer / Receiver Card / Button
            _buildRoleCard(
              context,
              title: "Volunteer / Receiver Panel",
              subtitle: "Find, request and distribute food to those in need",
              icon: Icons.people,
              color: Colors.green,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const VolunteerDashboardScreen()),
                );
              },
            ),
            const SizedBox(height: 16),

            // ৩. Admin Card / Button (আপডেট করা হয়েছে)
            _buildRoleCard(
              context,
              title: "Admin Panel",
              subtitle: "Manage posts, users and monitor system activities",
              icon: Icons.admin_panel_settings,
              color: Colors.blueAccent,
              onTap: () {
                // এডমিন ড্যাশবোর্ডে নিয়ে যাওয়া
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AdminDashboardScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // সুন্দর কার্ড ডিজাইন করার জন্য হেল্পার উইজেট
  Widget _buildRoleCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: color.withValues(alpha: 0.1),
                child: Icon(icon, size: 28, color: color),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}