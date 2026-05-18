import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../services/user_session.dart';
import 'login_screen.dart';
import 'orders_screen.dart';
import 'favorites_screen.dart';
import 'settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<void> _logout(BuildContext context) async {
    await UserSession.logout();

    if (!context.mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
          (route) => false,
    );
  }

  void _openScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: isDark ? const Color(0xFF1B2733) : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          title: Text(
            'Log Out?',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: isDark ? Colors.white : AppColors.textDark,
            ),
          ),
          content: Text(
            'Are you sure you want to log out from your account?',
            style: TextStyle(
              color: isDark ? Colors.white70 : AppColors.textGrey,
              height: 1.4,
            ),
          ),
          actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: isDark ? Colors.white70 : AppColors.textGrey,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.orange,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () async {
                Navigator.pop(dialogContext);
                await _logout(context);
              },
              child: const Text(
                'Log Out',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final userName = UserSession.name.isEmpty ? 'No User' : UserSession.name;

    final userEmail =
    UserSession.email.isEmpty ? 'No email available' : UserSession.email;

    final userPhone =
    UserSession.phone.isEmpty ? 'No phone available' : UserSession.phone;

    final userAddress = UserSession.address.isEmpty
        ? 'Please select location and enter address from Home page'
        : UserSession.address;

    final backgroundColor =
    isDark ? const Color(0xFF101820) : const Color(0xFFF7FBF8);

    final cardColor = isDark ? const Color(0xFF1B2733) : Colors.white;

    final textColor = isDark ? Colors.white : AppColors.textDark;

    final subTextColor = isDark ? Colors.white70 : AppColors.textGrey;

    final borderColor =
    isDark ? Colors.white.withOpacity(0.08) : const Color(0xFFEEEEEE);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 430),
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 14, 8, 0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                          size: 20,
                          color: textColor,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),

                      Expanded(
                        child: Center(
                          child: Text(
                            'Profile',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              color: textColor,
                            ),
                          ),
                        ),
                      ),

                      IconButton(
                        icon: Icon(
                          Icons.settings_outlined,
                          color: subTextColor,
                        ),
                        onPressed: () {
                          _openScreen(
                            context,
                            const SettingsScreen(),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            vertical: 28,
                            horizontal: 20,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: isDark
                                  ? [
                                const Color(0xFF1B2733),
                                const Color(0xFF223447),
                              ]
                                  : [
                                const Color(0xFFEAF8F0),
                                const Color(0xFFD0F0E2),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(26),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primaryGreen.withOpacity(
                                  isDark ? 0.08 : 0.12,
                                ),
                                blurRadius: 20,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: 122,
                                    height: 122,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFFF26B21),
                                          Color(0xFFFFAA55),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 114,
                                    height: 114,
                                    decoration: BoxDecoration(
                                      color: isDark
                                          ? const Color(0xFF101820)
                                          : Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Container(
                                    width: 106,
                                    height: 106,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: isDark
                                          ? const Color(0xFF1B2733)
                                          : Colors.white,
                                    ),
                                    child: ClipOval(
                                      child: Image.asset(
                                        'assets/images/profile.png',
                                        width: 106,
                                        height: 106,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return const Icon(
                                            Icons.person,
                                            size: 60,
                                            color: AppColors.darkGreen,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 16),

                              Text(
                                userName,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.w900,
                                  color: textColor,
                                ),
                              ),

                              const SizedBox(height: 5),

                              Text(
                                userEmail,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: subTextColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        _SectionTitle(
                          title: 'Account Information',
                          textColor: textColor,
                        ),

                        _ProfileTile(
                          icon: Icons.person_outline,
                          title: 'Full Name',
                          value: userName,
                          cardColor: cardColor,
                          textColor: textColor,
                          subTextColor: subTextColor,
                          borderColor: borderColor,
                        ),

                        _ProfileTile(
                          icon: Icons.email_outlined,
                          title: 'Email',
                          value: userEmail,
                          cardColor: cardColor,
                          textColor: textColor,
                          subTextColor: subTextColor,
                          borderColor: borderColor,
                        ),

                        _ProfileTile(
                          icon: Icons.phone_outlined,
                          title: 'Phone',
                          value: userPhone,
                          cardColor: cardColor,
                          textColor: textColor,
                          subTextColor: subTextColor,
                          borderColor: borderColor,
                        ),

                        _ProfileTile(
                          icon: Icons.location_on_outlined,
                          title: 'Address',
                          value: userAddress,
                          maxLines: 2,
                          cardColor: cardColor,
                          textColor: textColor,
                          subTextColor: subTextColor,
                          borderColor: borderColor,
                        ),

                        const SizedBox(height: 8),

                        _SectionTitle(
                          title: 'My Activity',
                          textColor: textColor,
                        ),

                        _ProfileTile(
                          icon: Icons.receipt_long_outlined,
                          title: 'Orders',
                          value: 'View your past orders',
                          showArrow: true,
                          cardColor: cardColor,
                          textColor: textColor,
                          subTextColor: subTextColor,
                          borderColor: borderColor,
                          onTap: () {
                            _openScreen(
                              context,
                              const OrdersScreen(),
                            );
                          },
                        ),

                        _ProfileTile(
                          icon: Icons.favorite_border,
                          title: 'Favorites',
                          value: 'View your favorite products',
                          showArrow: true,
                          cardColor: cardColor,
                          textColor: textColor,
                          subTextColor: subTextColor,
                          borderColor: borderColor,
                          onTap: () {
                            _openScreen(
                              context,
                              const FavoritesScreen(),
                            );
                          },
                        ),

                        const SizedBox(height: 24),

                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.orange,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            onPressed: () {
                              _showLogoutDialog(context);
                            },
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.logout_rounded,
                                  size: 20,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Log Out',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final Color textColor;

  const _SectionTitle({
    required this.title,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w900,
          color: textColor,
        ),
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final bool showArrow;
  final VoidCallback? onTap;
  final int maxLines;
  final Color cardColor;
  final Color textColor;
  final Color subTextColor;
  final Color borderColor;

  const _ProfileTile({
    required this.icon,
    required this.title,
    required this.value,
    required this.cardColor,
    required this.textColor,
    required this.subTextColor,
    required this.borderColor,
    this.showArrow = false,
    this.onTap,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: borderColor,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isDark ? 0.18 : 0.03),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.darkGreen.withOpacity(0.18)
                      : AppColors.lightGreen,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: AppColors.darkGreen,
                  size: 21,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 11,
                        color: subTextColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      value,
                      maxLines: maxLines,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              ),

              if (showArrow)
                Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: subTextColor,
                ),
            ],
          ),
        ),
      ),
    );
  }
}