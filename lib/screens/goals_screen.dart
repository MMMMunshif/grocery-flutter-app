import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class GoalsScreen extends StatelessWidget {
  const GoalsScreen({super.key});

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
                            'Goals',
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
                    Icons.track_changes,
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
                          _GoalSection(
                            title: 'Waste Reduction Goal',
                            points: const [
                              'Finish all groceries before buying new items',
                              'Set reminders for expiring items',
                              'Check existing items before shopping',
                            ],
                            textColor: textColor,
                            subTextColor: subTextColor,
                          ),

                          const SizedBox(height: 22),

                          _GoalSection(
                            title: 'Meal Planning Goal',
                            points: const [
                              'Plan weekly meals in advance',
                              'Track ingredients needed vs. ingredients in stock',
                              'Prepare a shopping list based on meal plans',
                            ],
                            textColor: textColor,
                            subTextColor: subTextColor,
                          ),

                          const SizedBox(height: 22),

                          _GoalSection(
                            title: 'Budget Control Goal',
                            points: const [
                              'Set a weekly grocery budget',
                              'Compare product prices before buying',
                              'Avoid unnecessary impulse purchases',
                            ],
                            textColor: textColor,
                            subTextColor: subTextColor,
                          ),

                          const SizedBox(height: 22),

                          _GoalSection(
                            title: 'Healthy Lifestyle Goal',
                            points: const [
                              'Buy more fruits and vegetables',
                              'Reduce sugary snacks and processed food',
                              'Choose fresh items for daily meals',
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
                      _PageDot(isDark: isDark),
                      _PageDot(isActive: true, isDark: isDark),
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

class _GoalSection extends StatelessWidget {
  final String title;
  final List<String> points;
  final Color textColor;
  final Color subTextColor;

  const _GoalSection({
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