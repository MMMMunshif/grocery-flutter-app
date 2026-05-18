import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../services/cart_session.dart';
import '../services/notification_session.dart';
import '../services/order_session.dart';
import 'home_screen.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  void initState() {
    super.initState();

    _saveOrderAndClearCart();
  }

  void _saveOrderAndClearCart() {
    // Cart-la items irundha mattum order history save aagum
    if (CartSession.cartItems.isNotEmpty) {
      OrderSession.addOrder(
        items: CartSession.getCartCopy(),
        subtotal: CartSession.subtotal,
        deliveryFee: CartSession.deliveryFee,
        grandTotal: CartSession.grandTotal,
      );

      // Place Order success aana mattum notification red dot varum
      NotificationSession.addOrderSuccessNotification();

      // Order save aana piragu cart clear pannum
      CartSession.clearCart();
    }
  }

  void _goHome(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 430),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.fromLTRB(28, 80, 28, 34),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFF5FBFF),
                  Color(0xFF9BE0B3),
                  Color(0xFF26B85A),
                ],
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  const Spacer(),

                  Container(
                    width: 170,
                    height: 170,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.95),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.12),
                          blurRadius: 24,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      color: AppColors.darkGreen,
                      size: 120,
                    ),
                  ),

                  const SizedBox(height: 44),

                  const Text(
                    'Success!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    'Your order has been\nsuccessfully placed',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 23,
                      height: 1.45,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),

                  const Spacer(),

                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.orange,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () {
                        _goHome(context);
                      },
                      child: const Text(
                        'Continue Shopping',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
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