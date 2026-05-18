import 'dart:async';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../services/notification_session.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          NotificationSession.markAllAsRead();
        });
      }
    });

    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _clearAllNotifications() {
    setState(() {
      NotificationSession.clearAll();
    });

    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.delete_outline,
              color: Colors.white,
              size: 18,
            ),
            SizedBox(width: 8),
            Text(
              'Notifications cleared',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.darkGreen,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.fromLTRB(70, 0, 70, 95),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }

  void _removeNotification(int index) {
    setState(() {
      NotificationSession.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final notifications = NotificationSession.notifications;

    final isDark = Theme.of(context).brightness == Brightness.dark;

    final backgroundColor =
    isDark ? AppColors.darkBackground : AppColors.lightBackground;

    final cardColor = isDark ? AppColors.darkCard : Colors.white;

    final textColor = isDark ? AppColors.darkText : AppColors.textDark;

    final subTextColor = isDark ? AppColors.darkSubText : AppColors.textGrey;

    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;

    final unreadCardColor = isDark
        ? AppColors.darkGreen.withOpacity(0.16)
        : AppColors.lightGreen.withOpacity(0.65);

    final iconBoxColor = isDark
        ? AppColors.darkGreen.withOpacity(0.18)
        : AppColors.lightGreen;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 430),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          size: 26,
                          color: textColor,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'Notifications',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: textColor,
                            ),
                          ),
                        ),
                      ),
                      if (notifications.isNotEmpty)
                        IconButton(
                          tooltip: 'Clear all',
                          icon: const Icon(
                            Icons.delete_outline,
                            color: AppColors.darkGreen,
                          ),
                          onPressed: _clearAllNotifications,
                        )
                      else
                        const SizedBox(width: 48),
                    ],
                  ),

                  const SizedBox(height: 10),

                  if (notifications.isNotEmpty)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.darkGreen.withOpacity(0.16)
                            : AppColors.lightGreen,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isDark
                              ? AppColors.darkGreen.withOpacity(0.35)
                              : Colors.transparent,
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.info_outline,
                            color: AppColors.darkGreen,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'You have ${notifications.length} notification(s)',
                              style: const TextStyle(
                                color: AppColors.darkGreen,
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  const SizedBox(height: 18),

                  Expanded(
                    child: notifications.isEmpty
                        ? _EmptyNotificationView(
                      cardColor: cardColor,
                      textColor: textColor,
                      subTextColor: subTextColor,
                      borderColor: borderColor,
                    )
                        : ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemCount: notifications.length,
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 14);
                      },
                      itemBuilder: (context, index) {
                        final notification = notifications[index];
                        final bool isRead =
                            notification['isRead'] == true;

                        return Dismissible(
                          key: ValueKey(
                            '${notification['title']}_${notification['createdAt']}_$index',
                          ),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          onDismissed: (_) {
                            _removeNotification(index);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color:
                              isRead ? cardColor : unreadCardColor,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isRead
                                    ? borderColor
                                    : AppColors.primaryGreen
                                    .withOpacity(0.45),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(
                                    isDark ? 0.16 : 0.03,
                                  ),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: iconBoxColor,
                                        borderRadius:
                                        BorderRadius.circular(16),
                                      ),
                                      child: Icon(
                                        notification['icon'],
                                        color: AppColors.darkGreen,
                                        size: 25,
                                      ),
                                    ),
                                    if (!isRead)
                                      Positioned(
                                        right: -2,
                                        top: -2,
                                        child: Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            color: Colors.redAccent,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: isDark
                                                  ? AppColors.darkCard
                                                  : Colors.white,
                                              width: 1.5,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),

                                const SizedBox(width: 14),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              notification['title'],
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight:
                                                FontWeight.w800,
                                                color: textColor,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            NotificationSession
                                                .getTimeAgo(
                                              notification['createdAt'],
                                            ),
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: subTextColor,
                                            ),
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 6),

                                      Text(
                                        notification['message'],
                                        style: TextStyle(
                                          fontSize: 13,
                                          height: 1.4,
                                          color: subTextColor,
                                        ),
                                      ),

                                      const SizedBox(height: 10),

                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets
                                                .symmetric(
                                              horizontal: 10,
                                              vertical: 5,
                                            ),
                                            decoration: BoxDecoration(
                                              color: AppColors.darkGreen
                                                  .withOpacity(
                                                isDark ? 0.18 : 0.08,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(
                                                20,
                                              ),
                                            ),
                                            child: Text(
                                              isRead ? 'Read' : 'Unread',
                                              style: TextStyle(
                                                fontSize: 11,
                                                fontWeight:
                                                FontWeight.w700,
                                                color: isRead
                                                    ? subTextColor
                                                    : AppColors
                                                    .darkGreen,
                                              ),
                                            ),
                                          ),

                                          const Spacer(),

                                          GestureDetector(
                                            onTap: () {
                                              _removeNotification(index);
                                            },
                                            child: const Text(
                                              'Remove',
                                              style: TextStyle(
                                                fontSize: 11,
                                                color: Colors.redAccent,
                                                fontWeight:
                                                FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _EmptyNotificationView extends StatelessWidget {
  final Color cardColor;
  final Color textColor;
  final Color subTextColor;
  final Color borderColor;

  const _EmptyNotificationView({
    required this.cardColor,
    required this.textColor,
    required this.subTextColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(26),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: borderColor,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.notifications_none_rounded,
              size: 70,
              color: AppColors.darkGreen,
            ),
            const SizedBox(height: 14),
            Text(
              'No notifications',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: textColor,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'You are all caught up.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: subTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}