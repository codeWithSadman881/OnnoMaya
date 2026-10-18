import 'package:flutter/material.dart';
import '../models/food_item.dart';
import '../services/food_repository.dart';

class DonateScreen extends StatefulWidget {
  const DonateScreen({super.key});

  @override
  State<DonateScreen> createState() => _DonateScreenState();
}

class _DonateScreenState extends State<DonateScreen> {
  final _titleController = TextEditingController();
  final _quantityController = TextEditingController();
  final _locationController = TextEditingController();
  final _phoneController = TextEditingController();
  final _descriptionController = TextEditingController();

  // ক্যাটাগরি ট্র্যাক করার জন্য ভেরিয়েবল (ডিফল্ট 'human')
  String _selectedCategory = 'human';

  @override
  void dispose() {
    _titleController.dispose();
    _quantityController.dispose();
    _locationController.dispose();
    _phoneController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitForm() {
    // খালি ঘর আছে কিনা চেক করা
    if (_titleController.text.trim().isEmpty ||
        _quantityController.text.trim().isEmpty ||
        _locationController.text.trim().isEmpty ||
        _phoneController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("অনুগ্রহ করে প্রয়োজনীয় সব ঘর পূরণ করুন!"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // নতুন পোস্ট অবজেক্ট তৈরি করে Repository-তে যোগ করা
    final newItem = FoodItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text.trim(),
      quantity: _quantityController.text.trim(),
      location: _locationController.text.trim(),
      phone: _phoneController.text.trim(),
      description: _descriptionController.text.trim(),
      category: _selectedCategory,
      status: 'Pending',
    );

    FoodRepository.addFoodItem(newItem);

    // সফল মেসেজ দেখানো
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("ডোনেশন পোস্টটি সফলভাবে অনুমোদনের জন্য পাঠানো হয়েছে!"),
        backgroundColor: Colors.green,
      ),
    );

    // পোস্ট জমা শেষে আগের স্ক্রিনে ফেরত যাওয়া
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Donate Food"),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category Selection Header & Toggle Buttons
            const Text(
              "Who is this food for?",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(
                  value: 'human',
                  label: Text('For Humans'),
                  icon: Icon(Icons.person),
                ),
                ButtonSegment(
                  value: 'animal',
                  label: Text('For Strays'),
                  icon: Icon(Icons.pets),
                ),
                ButtonSegment(
                  value: 'both',
                  label: Text('Both'),
                  icon: Icon(Icons.favorite),
                ),
              ],
              selected: {_selectedCategory},
              onSelectionChanged: (Set<String> newSelection) {
                setState(() {
                  _selectedCategory = newSelection.first;
                });
              },
            ),
            const SizedBox(height: 16),

            // Form Inputs
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: "Food Name / Title",
                prefixIcon: Icon(Icons.fastfood),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _quantityController,
              decoration: const InputDecoration(
                labelText: "Quantity (e.g. 5 Packets / 2 KG)",
                prefixIcon: Icon(Icons.shopping_cart),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(
                labelText: "Pickup Location Address",
                prefixIcon: Icon(Icons.location_on),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "Contact Phone Number",
                prefixIcon: Icon(Icons.phone),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Description (Optional / Condition)",
                prefixIcon: Icon(Icons.description),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Submit Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: _submitForm,
                child: const Text(
                  "Post Donation",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}