class FoodItem {
  final String id;
  final String title;
  final String quantity;
  final String location;
  final String phone;
  final String description;
  final String category; // 'human', 'animal', 'both'
  final String timeAgo;  
  String status; // 'Pending', 'Approved', 'Rejected', 'Claimed'

  FoodItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.location,
    required this.phone,
    required this.description,
    required this.category,
    this.timeAgo = 'Just now',
    this.status = 'Pending',
  });
}