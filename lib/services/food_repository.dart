import '../models/food_item.dart';

class FoodRepository {
  static final List<FoodItem> _items = [
    FoodItem(
      id: '1',
      title: '50 Packets Surplus Dinner',
      quantity: '50 Packets',
      location: 'Dhanmondi, Dhaka',
      phone: '01700000000',
      description: 'Hot meal from event',
      category: 'human',
      timeAgo: '2 hours ago',
      status: 'Pending',
    ),
    FoodItem(
      id: '2',
      title: 'Fresh Bakery Products',
      quantity: '20 Items',
      location: 'Uttara, Dhaka',
      phone: '01800000000',
      description: 'Breads & Cakes',
      category: 'human',
      timeAgo: '5 hours ago',
      status: 'Pending',
    ),
  ];

  static List<FoodItem> get allItems => _items;

  // পেন্ডিং আইটেম ফিল্টার করার গেটার
  static List<FoodItem> get pendingItems =>
      _items.where((item) => item.status == 'Pending').toList();

  // এপ্রুভড আইটেম ফিল্টার করার গেটার
  static List<FoodItem> get approvedItems =>
      _items.where((item) => item.status == 'Approved').toList();

  // নতুন আইটেম যোগ করা
  static void addFoodItem(FoodItem item) {
    _items.add(item);
  }

  // স্ট্যাটাস আপডেট করা
  static void updateStatus(String id, String newStatus) {
    int index = _items.indexWhere((element) => element.id == id);
    if (index != -1) {
      _items[index].status = newStatus;
    }
  }
}