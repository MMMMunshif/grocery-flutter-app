class OrderSession {
  static final List<Map<String, dynamic>> orders = [];

  static void addOrder({
    required List<Map<String, dynamic>> items,
    required int subtotal,
    required int deliveryFee,
    required int grandTotal,
  }) {
    if (items.isEmpty) return;

    orders.insert(0, {
      'orderId': DateTime.now().millisecondsSinceEpoch.toString(),
      'items': items,
      'subtotal': subtotal,
      'deliveryFee': deliveryFee,
      'grandTotal': grandTotal,
      'orderDate': DateTime.now(),
    });
  }

  static bool get hasOrders {
    return orders.isNotEmpty;
  }

  static String getFormattedDate(DateTime dateTime) {
    final day = dateTime.day.toString().padLeft(2, '0');
    final month = dateTime.month.toString().padLeft(2, '0');
    final year = dateTime.year.toString();

    final hour = dateTime.hour > 12
        ? dateTime.hour - 12
        : dateTime.hour == 0
        ? 12
        : dateTime.hour;

    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = dateTime.hour >= 12 ? 'PM' : 'AM';

    return '$day/$month/$year  $hour:$minute $period';
  }

  static String getTimeAgo(DateTime dateTime) {
    final difference = DateTime.now().difference(dateTime);

    if (difference.inSeconds < 10) {
      return 'Just now';
    } else if (difference.inSeconds < 60) {
      return '${difference.inSeconds} sec ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    }
  }

  static void removeOrder(int index) {
    if (index >= 0 && index < orders.length) {
      orders.removeAt(index);
    }
  }

  static void clearOrders() {
    orders.clear();
  }
}