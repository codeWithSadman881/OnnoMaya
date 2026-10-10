class FoodItem {
  final String id;
  final String title;
  final String description;
  final String quantity;
  final String location;
  final String timeAgo;
  final String contactNumber; // required করে দেওয়া হলো
  final String category;

  FoodItem({
    required this.id,
    required this.title,
    required this.description,
    required this.quantity,
    required this.location,
    required this.timeAgo,
    required this.contactNumber, // কোনো ডিফল্ট নম্বর থাকবে না
    required this.category,
  });
}