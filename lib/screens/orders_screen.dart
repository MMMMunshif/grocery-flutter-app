import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../services/order_session.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  void _removeOrder(int index) {
    setState(() {
      OrderSession.removeOrder(index);
    });
  }

  void _clearAllOrders() {
    setState(() {
      OrderSession.clearOrders();
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
              'Orders cleared',
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
        margin: const EdgeInsets.fromLTRB(85, 0, 85, 95),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final orders = OrderSession.orders;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final backgroundColor =
    isDark ? AppColors.darkBackground : AppColors.lightBackground;

    final cardColor = isDark ? AppColors.darkCard : Colors.white;

    final secondCardColor =
    isDark ? AppColors.darkCardLight : const Color(0xFFF7FBF8);

    final textColor = isDark ? AppColors.darkText : AppColors.textDark;

    final subTextColor = isDark ? AppColors.darkSubText : AppColors.textGrey;

    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;

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
                            'My Orders',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: textColor,
                            ),
                          ),
                        ),
                      ),
                      if (orders.isNotEmpty)
                        IconButton(
                          tooltip: 'Clear all orders',
                          icon: const Icon(
                            Icons.delete_outline,
                            color: AppColors.darkGreen,
                          ),
                          onPressed: _clearAllOrders,
                        )
                      else
                        const SizedBox(width: 48),
                    ],
                  ),

                  const SizedBox(height: 16),

                  if (orders.isNotEmpty)
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
                            Icons.receipt_long_outlined,
                            color: AppColors.darkGreen,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'You have ${orders.length} past order(s)',
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
                    child: orders.isEmpty
                        ? _EmptyOrdersView(
                      cardColor: cardColor,
                      textColor: textColor,
                      subTextColor: subTextColor,
                      borderColor: borderColor,
                    )
                        : ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemCount: orders.length,
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 16);
                      },
                      itemBuilder: (context, index) {
                        final order = orders[index];

                        final List<Map<String, dynamic>> items =
                        List<Map<String, dynamic>>.from(
                          order['items'] ?? [],
                        );

                        final DateTime orderDate =
                        order['orderDate'] is DateTime
                            ? order['orderDate']
                            : DateTime.now();

                        final int subtotal = order['subtotal'] ?? 0;
                        final int deliveryFee =
                            order['deliveryFee'] ?? 0;
                        final int grandTotal =
                            order['grandTotal'] ?? 0;

                        return Dismissible(
                          key: ValueKey(
                            '${order['orderId']}_$index',
                          ),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(22),
                            ),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          onDismissed: (_) {
                            _removeOrder(index);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: cardColor,
                              borderRadius: BorderRadius.circular(22),
                              border: Border.all(
                                color: borderColor,
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
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 46,
                                      height: 46,
                                      decoration: BoxDecoration(
                                        color: iconBoxColor,
                                        borderRadius:
                                        BorderRadius.circular(14),
                                      ),
                                      child: const Icon(
                                        Icons.shopping_bag_outlined,
                                        color: AppColors.darkGreen,
                                        size: 24,
                                      ),
                                    ),

                                    const SizedBox(width: 12),

                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Order #${orders.length - index}',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w900,
                                              color: textColor,
                                            ),
                                          ),
                                          const SizedBox(height: 3),
                                          Text(
                                            OrderSession.getFormattedDate(
                                              orderDate,
                                            ),
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: subTextColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          OrderSession.getTimeAgo(
                                            orderDate,
                                          ),
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: subTextColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        GestureDetector(
                                          onTap: () {
                                            _removeOrder(index);
                                          },
                                          child: const Text(
                                            'Remove',
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.redAccent,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 14),

                                Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: borderColor,
                                ),

                                const SizedBox(height: 12),

                                ...items.map((item) {
                                  final String name =
                                      item['name'] ?? 'Unknown Product';
                                  final String icon =
                                      item['icon'] ?? '🛒';
                                  final int quantity =
                                      item['quantity'] ?? 1;
                                  final int totalPrice =
                                      item['totalPrice'] ?? 0;

                                  return Padding(
                                    padding:
                                    const EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 44,
                                          height: 44,
                                          decoration: BoxDecoration(
                                            color: secondCardColor,
                                            borderRadius:
                                            BorderRadius.circular(12),
                                          ),
                                          child: Center(
                                            child: Text(
                                              icon,
                                              style: const TextStyle(
                                                fontSize: 24,
                                              ),
                                            ),
                                          ),
                                        ),

                                        const SizedBox(width: 12),

                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                name,
                                                maxLines: 1,
                                                overflow:
                                                TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight:
                                                  FontWeight.w800,
                                                  color: textColor,
                                                ),
                                              ),
                                              const SizedBox(height: 3),
                                              Text(
                                                'Quantity: $quantity',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: subTextColor,
                                                  fontWeight:
                                                  FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        Text(
                                          'Rs. $totalPrice',
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w900,
                                            color: AppColors.darkGreen,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),

                                const SizedBox(height: 4),

                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(14),
                                  decoration: BoxDecoration(
                                    color: secondCardColor,
                                    borderRadius:
                                    BorderRadius.circular(16),
                                    border: Border.all(
                                      color: borderColor,
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      _OrderPriceRow(
                                        label: 'Subtotal',
                                        value: 'Rs. $subtotal',
                                        textColor: textColor,
                                        subTextColor: subTextColor,
                                      ),
                                      const SizedBox(height: 7),
                                      _OrderPriceRow(
                                        label: 'Delivery Fee',
                                        value: 'Rs. $deliveryFee',
                                        textColor: textColor,
                                        subTextColor: subTextColor,
                                      ),
                                      const SizedBox(height: 9),
                                      Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: borderColor,
                                      ),
                                      const SizedBox(height: 9),
                                      _OrderPriceRow(
                                        label: 'Total',
                                        value: 'Rs. $grandTotal',
                                        isTotal: true,
                                        textColor: textColor,
                                        subTextColor: subTextColor,
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

class _OrderPriceRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;
  final Color textColor;
  final Color subTextColor;

  const _OrderPriceRow({
    required this.label,
    required this.value,
    required this.textColor,
    required this.subTextColor,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 15 : 13,
            fontWeight: isTotal ? FontWeight.w900 : FontWeight.w600,
            color: isTotal ? textColor : subTextColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 16 : 13,
            fontWeight: FontWeight.w900,
            color: isTotal ? AppColors.darkGreen : textColor,
          ),
        ),
      ],
    );
  }
}

class _EmptyOrdersView extends StatelessWidget {
  final Color cardColor;
  final Color textColor;
  final Color subTextColor;
  final Color borderColor;

  const _EmptyOrdersView({
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
              Icons.receipt_long_outlined,
              size: 70,
              color: AppColors.darkGreen,
            ),
            const SizedBox(height: 14),
            Text(
              'No orders yet',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: textColor,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Your placed orders will appear here.',
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