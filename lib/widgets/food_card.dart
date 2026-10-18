import 'package:flutter/material.dart';
import '../models/food_item.dart';

class FoodCard extends StatelessWidget {
  final FoodItem item;
  final VoidCallback? onRequest;

  const FoodCard({
    super.key,
    required this.item,
    this.onRequest,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // সঠিক জায়গায় রাখা হলো
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    item.timeAgo,
                    style: TextStyle(color: Colors.orange.shade800, fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text("Quantity: ${item.quantity}", style: const TextStyle(color: Colors.grey)),
            Text("Location: ${item.location}", style: const TextStyle(color: Colors.grey)),
            const Divider(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Calling Donor: ${item.phone}')),
                    );
                  },
                  icon: const Icon(Icons.phone, size: 18, color: Colors.green),
                  label: Text(
                    item.phone,
                    style: const TextStyle(color: Colors.green, fontSize: 13),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.green),
                  ),
                ),
                if (onRequest != null)
                  ElevatedButton(
                    onPressed: onRequest,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                    child: const Text('Request Food', style: TextStyle(color: Colors.white, fontSize: 13)),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}