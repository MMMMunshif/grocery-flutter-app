class FavoriteSession {
  static final List<Map<String, dynamic>> favoriteItems = [];

  static bool isFavorite(String name) {
    return favoriteItems.any((item) => item['name'] == name);
  }

  static void addFavorite({
    required String name,
    required String price,
    required String icon,
  }) {
    final existingIndex = favoriteItems.indexWhere(
          (item) => item['name'] == name,
    );

    if (existingIndex == -1) {
      favoriteItems.add({
        'name': name,
        'price': price,
        'icon': icon,
        'addedAt': DateTime.now(),
      });
    }
  }

  static void removeFavorite(String name) {
    favoriteItems.removeWhere((item) => item['name'] == name);
  }

  static void toggleFavorite({
    required String name,
    required String price,
    required String icon,
  }) {
    if (isFavorite(name)) {
      removeFavorite(name);
    } else {
      addFavorite(
        name: name,
        price: price,
        icon: icon,
      );
    }
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

  static bool get hasFavorites {
    return favoriteItems.isNotEmpty;
  }

  static void removeAt(int index) {
    if (index >= 0 && index < favoriteItems.length) {
      favoriteItems.removeAt(index);
    }
  }

  static void clearFavorites() {
    favoriteItems.clear();
  }
}