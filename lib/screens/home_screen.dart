import 'package:flutter/material.dart';
import '../models/food_item.dart';
import '../services/food_repository.dart';
import '../services/auth_service.dart';
import '../widgets/food_card.dart';
import 'donate_screen.dart';
import 'admin_dashboard_screen.dart';
import 'volunteer_dashboard_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _activeFilter = 'all'; // 'all', 'human', 'animal'
  
  String? _userRole;
  bool _isRoleLoading = true;
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _fetchCurrentUserRole();
  }

  // ফায়ারবেস বা অথ সার্ভিস থেকে ইউজারের রোল ফেচ করার ফাংশন
  Future<void> _fetchCurrentUserRole() async {
    try {
      // এখানে _authService.currentUser একটি getter, তাই ব্র্যাকেট () হবে না
      var currentUser = _authService.currentUser; 
      if (currentUser != null) {
        String? role = await _authService.getUserRole(currentUser.uid);
        setState(() {
          _userRole = role;
          _isRoleLoading = false;
        });
      } else {
        setState(() {
          _isRoleLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isRoleLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // FoodRepository থেকে শুধু Approved স্ট্যাটাসের খাবারগুলো ফিল্টার করা
    final approvedItems = FoodRepository.allItems.where((item) {
      return item.status == 'Approved';
    }).toList();

    // ক্যাটাগরি ফিল্টারিং লজিক (All, For Humans, For Stray Animals)
    final filteredItems = approvedItems.where((item) {
      if (_activeFilter == 'all') return true;
      if (item.category == 'both') return true; // 'both' হলে দুই ফিল্টারেই দেখাবে
      return item.category == _activeFilter;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("OnnoMaya - Nearby Food"),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        actions: [
          // রোল চেক করে শুধু নির্দিষ্ট ইউজারের জন্য প্যানেল শর্টকাট দেখানো
          if (!_isRoleLoading) ...[
            // ভলান্টিয়ার প্যানেল শর্টকাট (শুধু volunteer বা admin দেখতে পাবে)
            if (_userRole == 'volunteer' || _userRole == 'admin')
              IconButton(
                icon: const Icon(Icons.delivery_dining),
                tooltip: "Volunteer Panel",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const VolunteerDashboardScreen()),
                  ).then((_) => setState(() {}));
                },
              ),

            // এডমিন প্যানেল শর্টকাট (শুধু admin দেখতে পাবে)
            if (_userRole == 'admin')
              IconButton(
                icon: const Icon(Icons.admin_panel_settings),
                tooltip: "Admin Panel",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AdminDashboardScreen()),
                  ).then((_) => setState(() {}));
                },
              ),
          ],
        ],
      ),
      body: Column(
        children: [
          // Filter Chips Row
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                FilterChip(
                  label: const Text('All'),
                  selected: _activeFilter == 'all',
                  onSelected: (selected) {
                    setState(() => _activeFilter = 'all');
                  },
                ),
                const SizedBox(width: 8),
                FilterChip(
                  avatar: const Icon(Icons.person, size: 18),
                  label: const Text('For Humans'),
                  selected: _activeFilter == 'human',
                  onSelected: (selected) {
                    setState(() => _activeFilter = 'human');
                  },
                ),
                const SizedBox(width: 8),
                FilterChip(
                  avatar: const Icon(Icons.pets, size: 18),
                  label: const Text('For Stray Animals'),
                  selected: _activeFilter == 'animal',
                  onSelected: (selected) {
                    setState(() => _activeFilter = 'animal');
                  },
                ),
              ],
            ),
          ),

          // Food List View
          Expanded(
            child: filteredItems.isEmpty
                ? const Center(
                    child: Text(
                      "No approved food donations nearby right now 🍲",
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = filteredItems.length > index ? filteredItems[index] : null;
                      if (item == null) return const SizedBox();
                      return FoodCard(
                        item: item,
                        onRequest: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Requested for ${item.title}'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        onPressed: () {
          // DonateScreen-এ নিয়ে যাওয়া এবং ফিরে আসলে পেজ রিফ্রেশ করা
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DonateScreen()),
          ).then((_) {
            setState(() {});
          });
        },
        icon: const Icon(Icons.add),
        label: const Text("Donate Food"),
      ),
    );
  }
}