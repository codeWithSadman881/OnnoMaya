import 'package:flutter/material.dart';
import '../models/food_item.dart';
import '../widgets/food_card.dart'; // আপনার তৈরি কাস্টম ফুড কার্ড উইজেট

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _activeFilter = 'all'; // 'all', 'human', 'animal'

  // ডেমো খাবারের তালিকা
  final List<FoodItem> _allFoodItems = [
    FoodItem(
      id: '1',
      title: 'Cooked Rice & Chicken Curry',
      description: 'Freshly prepared extra food from event, good condition.',
      quantity: '10 Packets',
      location: 'Dhanmondi 32, Dhaka',
      timeAgo: '20 mins ago',
      contactNumber: '01700000000',
      category: 'human',
    ),
    FoodItem(
      id: '2',
      title: 'Fresh Dog Food & Meat Trimmings',
      description: 'Clean chicken remnants and boiled rice for street dogs.',
      quantity: '15 Packets',
      location: 'Uttara Sector 10, Dhaka',
      timeAgo: '35 mins ago',
      contactNumber: '01800000000',
      category: 'animal',
    ),
    FoodItem(
      id: '3',
      title: 'Bakery Items & Bread',
      description: 'Fresh surplus bakery items from shop.',
      quantity: '15 Pcs',
      location: 'Mirpur 10, Dhaka',
      timeAgo: '1 hr ago',
      contactNumber: '01900000000',
      category: 'both',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // ফিল্টারিং লজিক
    final filteredItems = _allFoodItems.where((item) {
      if (_activeFilter == 'all') return true;
      if (item.category == 'both') return true; // 'both' হলে মানুষ বা প্রাণী দুই ফিল্টারেই দেখাবে
      return item.category == _activeFilter;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("OnnoMaya - Nearby Food"),
        backgroundColor: Colors.orange,
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
            child: ListView.builder(
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                final item = filteredItems[index];
                // এখানে foodItem-এর বদলে 'item' এবং onRequest পাস করা হলো
                return FoodCard(
                  item: item,
                  onRequest: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Requested for ${item.title}')),
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
        onPressed: () {
          // Navigate to Donate Screen
        },
        icon: const Icon(Icons.add),
        label: const Text("Donate Food"),
      ),
    );
  }
}