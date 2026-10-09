class FoodItem {
  final String id;
  final String title;
  final String description;
  final String quantity;
  final String location;
  final String timeAgo;
  final String contactNumber;

  FoodItem({
    required this.id,
    required this.title,
    required this.description,
    required this.quantity,
    required this.location,
    required this.timeAgo,
    this.contactNumber = '01700000000',
  });
}