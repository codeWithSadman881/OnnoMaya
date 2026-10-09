import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../services/location_service.dart';
import '../models/food_item.dart';
import '../widgets/food_card.dart';
import 'donate_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _locationInfo = "Location not fetched";

  final List<FoodItem> _foodList = [
    FoodItem(
      id: '1',
      title: 'Cooked Rice & Chicken Curry',
      description: 'Freshly prepared extra food from event, good condition.',
      quantity: '10 Packets',
      location: 'Dhanmondi 32, Dhaka',
      timeAgo: '20 mins ago',
    ),
    FoodItem(
      id: '2',
      title: 'Vegetable Khichuri',
      description: 'Hot vegetarian meal packaged properly.',
      quantity: '5 Packets',
      location: 'Uttara Sector 10, Dhaka',
      timeAgo: '45 mins ago',
    ),
    FoodItem(
      id: '3',
      title: 'Bakery Items & Bread',
      description: 'Fresh surplus bakery items from shop.',
      quantity: '15 Pcs',
      location: 'Mirpur 10, Dhaka',
      timeAgo: '1 hr ago',
    ),
  ];

  void _getLocation() async {
    Position? pos = await LocationService.getCurrentLocation();
    if (pos != null) {
      String address = await LocationService.getAddressFromCoordinates(
        pos.latitude,
        pos.longitude,
      );
      setState(() {
        _locationInfo = address;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OnnoMaya - Nearby Food'),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: _getLocation,
            tooltip: 'Get Current Location',
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.orange.shade50,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                const Icon(Icons.location_on, color: Colors.orange, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _locationInfo,
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                ),
                TextButton(
                  onPressed: _getLocation,
                  child: const Text('Update'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _foodList.length,
              itemBuilder: (context, index) {
                final food = _foodList[index];
                return FoodCard(
                  item: food,
                  onRequest: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Request sent for ${food.title}!')),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          // ডোনেট স্ক্রিন থেকে নতুন ডাটা ফেরত পাওয়া
          final newFood = await Navigator.push<FoodItem>(
            context,
            MaterialPageRoute(builder: (context) => const DonateScreen()),
          );

          if (newFood != null) {
            setState(() {
              _foodList.insert(0, newFood); // সবার উপরে নতুন খাবার যোগ হবে
            });
          }
        },
        backgroundColor: Colors.orange,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Donate Food', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}