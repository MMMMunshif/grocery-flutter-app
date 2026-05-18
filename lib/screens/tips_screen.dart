import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class TipsScreen extends StatelessWidget {
  const TipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final backgroundColor =
    isDark ? AppColors.darkBackground : AppColors.lightBackground;

    final cardColor = isDark ? AppColors.darkCard : Colors.white;

    final textColor = isDark ? AppColors.darkText : AppColors.textDark;

    final subTextColor = isDark ? AppColors.darkSubText : AppColors.textGrey;

    final borderColor = isDark ? AppColors.darkBorder : AppColors.primaryGreen;

    final iconBoxColor = isDark
        ? AppColors.darkGreen.withOpacity(0.18)
        : AppColors.lightGreen;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 430),
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 12),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          size: 28,
                          color: textColor,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'Tips',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: textColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                Container(
                  width: 132,
                  height: 132,
                  decoration: BoxDecoration(
                    color: iconBoxColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.darkGreen.withOpacity(0.25),
                    ),
                  ),
                  child: const Icon(
                    Icons.lightbulb_outline,
                    size: 82,
                    color: AppColors.darkGreen,
                  ),
                ),

                const SizedBox(height: 18),

                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(26),
                        border: Border.all(
                          color: borderColor,
                          width: 1.2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(
                              isDark ? 0.18 : 0.03,
                            ),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _TipSection(
                            title: 'Shopping Tips',
                            points: const [
                              'Make a grocery list before going shopping',
                              'Avoid shopping when hungry to reduce impulse buys',
                              'Shop seasonal items for better prices',
                            ],
                            textColor: textColor,
                            subTextColor: subTextColor,
                          ),

                          const SizedBox(height: 22),

                          _TipSection(
                            title: 'Budget Tips',
                            points: const [
                              'Buy in bulk for savings',
                              'Use discount and loyalty cards',
                              'Shop from local markets or promotions',
                            ],
                            textColor: textColor,
                            subTextColor: subTextColor,
                          ),

                          const SizedBox(height: 22),

                          _TipSection(
                            title: 'Healthy Eating Tips',
                            points: const [
                              'Read nutrition labels before buying packed food',
                              'Choose whole grains over refined ones',
                              'Add more fruits and vegetables to your meals',
                            ],
                            textColor: textColor,
                            subTextColor: subTextColor,
                          ),

                          const SizedBox(height: 22),

                          _TipSection(
                            title: 'Storage Tips',
                            points: const [
                              'Keep vegetables in a clean and dry place',
                              'Store meat and fish in the freezer',
                              'Check expiry dates before storing products',
                            ],
                            textColor: textColor,
                            subTextColor: subTextColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _PageDot(isDark: isDark),
                      _PageDot(isDark: isDark),
                      _PageDot(isDark: isDark),
                      _PageDot(isDark: isDark),
                      _PageDot(isDark: isDark),
                      _PageDot(isActive: true, isDark: isDark),
                      _PageDot(isDark: isDark),
                      _PageDot(isDark: isDark),
                    ],
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

class _TipSection extends StatelessWidget {
  final String title;
  final List<String> points;
  final Color textColor;
  final Color subTextColor;

  const _TipSection({
    required this.title,
    required this.points,
    required this.textColor,
    required this.subTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w900,
            color: textColor,
          ),
        ),

        const SizedBox(height: 10),

        ...points.map(
              (point) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 7),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '•',
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.4,
                      color: AppColors.darkGreen,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      point,
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.45,
                        color: subTextColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class _PageDot extends StatelessWidget {
  final bool isActive;
  final bool isDark;

  const _PageDot({
    this.isActive = false,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isActive ? 7 : 5,
      height: isActive ? 7 : 5,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: isActive
            ? AppColors.primaryGreen
            : isDark
            ? Colors.white24
            : Colors.black12,
        shape: BoxShape.circle,
      ),
    );
  }
}