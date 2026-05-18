import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../services/cart_session.dart';
import 'payment_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void increaseQty(int index) {
    setState(() {
      final item = CartSession.cartItems[index];
      item['quantity'] = item['quantity'] + 1;
      item['totalPrice'] = item['unitPrice'] * item['quantity'];
    });
  }

  void decreaseQty(int index) {
    setState(() {
      final item = CartSession.cartItems[index];

      if (item['quantity'] > 1) {
        item['quantity'] = item['quantity'] - 1;
        item['totalPrice'] = item['unitPrice'] * item['quantity'];
      }
    });
  }

  void removeItem(int index) {
    setState(() {
      CartSession.cartItems.removeAt(index);
    });

    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Item removed from cart',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: AppColors.darkGreen,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.fromLTRB(65, 0, 65, 95),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }

  void goToPayment() {
    if (CartSession.cartItems.isEmpty) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentScreen(
          totalAmount: 'Rs. ${CartSession.grandTotal}',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartItems = CartSession.cartItems;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final backgroundColor =
    isDark ? AppColors.darkBackground : AppColors.lightBackground;

    final cardColor = isDark ? AppColors.darkCard : Colors.white;

    final secondCardColor =
    isDark ? AppColors.darkCardLight : const Color(0xFFF5FBFF);

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
                            'My Cart',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: textColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),

                  const SizedBox(height: 20),

                  if (cartItems.isEmpty)
                    Expanded(
                      child: Center(
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(24),
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
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.shopping_cart_outlined,
                                size: 70,
                                color: AppColors.darkGreen,
                              ),
                              const SizedBox(height: 14),
                              Text(
                                'Your cart is empty',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: textColor,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Add products to view them here.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: subTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  else
                    Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: cartItems.length,
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 14);
                        },
                        itemBuilder: (context, index) {
                          final item = cartItems[index];

                          return Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: cardColor,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: borderColor,
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
                              children: [
                                Container(
                                  width: 76,
                                  height: 76,
                                  decoration: BoxDecoration(
                                    color: iconBoxColor,
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Center(
                                    child: Text(
                                      item['icon'],
                                      style: const TextStyle(fontSize: 44),
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 14),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item['name'],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w800,
                                          color: textColor,
                                        ),
                                      ),

                                      const SizedBox(height: 6),

                                      Text(
                                        '${item['quantity']} item(s)',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: subTextColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),

                                      const SizedBox(height: 8),

                                      Text(
                                        'Rs. ${item['totalPrice']}',
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w800,
                                          color: AppColors.darkGreen,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Column(
                                  children: [
                                    Container(
                                      width: 88,
                                      height: 36,
                                      decoration: BoxDecoration(
                                        color: secondCardColor,
                                        borderRadius: BorderRadius.circular(14),
                                        border: Border.all(
                                          color: borderColor,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              decreaseQty(index);
                                            },
                                            child: Icon(
                                              Icons.remove,
                                              size: 18,
                                              color: textColor,
                                            ),
                                          ),

                                          Text(
                                            '${item['quantity']}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              color: textColor,
                                            ),
                                          ),

                                          InkWell(
                                            onTap: () {
                                              increaseQty(index);
                                            },
                                            child: Icon(
                                              Icons.add,
                                              size: 18,
                                              color: textColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(height: 8),

                                    GestureDetector(
                                      onTap: () {
                                        removeItem(index);
                                      },
                                      child: const Text(
                                        'Remove',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.redAccent,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                  if (cartItems.isNotEmpty) ...[
                    const SizedBox(height: 14),

                    Container(
                      padding: const EdgeInsets.all(18),
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
                        children: [
                          _CartTotalRow(
                            label: 'Subtotal',
                            value: 'Rs. ${CartSession.subtotal}',
                            textColor: textColor,
                            subTextColor: subTextColor,
                          ),

                          const SizedBox(height: 10),

                          _CartTotalRow(
                            label: 'Delivery Fee',
                            value: 'Rs. ${CartSession.deliveryFee}',
                            textColor: textColor,
                            subTextColor: subTextColor,
                          ),

                          const SizedBox(height: 14),

                          Divider(
                            height: 1,
                            thickness: 1,
                            color: borderColor,
                          ),

                          const SizedBox(height: 14),

                          _CartTotalRow(
                            label: 'Grand Total',
                            value: 'Rs. ${CartSession.grandTotal}',
                            isTotal: true,
                            textColor: textColor,
                            subTextColor: subTextColor,
                          ),

                          const SizedBox(height: 18),

                          SizedBox(
                            width: double.infinity,
                            height: 54,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.darkGreen,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              onPressed: goToPayment,
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.payment_rounded,
                                    size: 20,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Checkout',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CartTotalRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;
  final Color textColor;
  final Color subTextColor;

  const _CartTotalRow({
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
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.w900 : FontWeight.w600,
            color: isTotal ? textColor : subTextColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 18 : 14,
            fontWeight: FontWeight.w900,
            color: isTotal ? AppColors.darkGreen : textColor,
          ),
        ),
      ],
    );
  }
}