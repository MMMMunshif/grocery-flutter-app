import 'package:flutter/material.dart';

class NotificationSession {
  static final List<Map<String, dynamic>> notifications = [];

  static int get unreadCount {
    return notifications.where((item) => item['isRead'] == false).length;
  }

  static bool get hasUnreadNotifications {
    return unreadCount > 0;
  }

  static void addNotification({
    required String title,
    required String message,
    required IconData icon,
  }) {
    notifications.insert(0, {
      'title': title,
      'message': message,
      'icon': icon,
      'createdAt': DateTime.now(),
      'isRead': false,
    });
  }

  static void addOrderSuccessNotification() {
    addNotification(
      title: 'Order Placed',
      message: 'Your grocery order has been placed successfully.',
      icon: Icons.check_circle_outline,
    );
  }

  static String getTimeAgo(dynamic createdAt) {
    if (createdAt is! DateTime) {
      return 'Just now';
    }

    final Duration difference = DateTime.now().difference(createdAt);

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

  static void markAllAsRead() {
    for (final item in notifications) {
      item['isRead'] = true;
    }
  }

  static void clearAll() {
    notifications.clear();
  }

  static void removeAt(int index) {
    if (index >= 0 && index < notifications.length) {
      notifications.removeAt(index);
    }
  }
}