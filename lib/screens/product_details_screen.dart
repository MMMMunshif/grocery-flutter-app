import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../services/cart_session.dart';
import '../services/favorite_session.dart';
import 'cart_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String name;
  final String price;
  final String icon;

  const ProductDetailsScreen({
    super.key,
    required this.name,
    required this.price,
    required this.icon,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen>
    with SingleTickerProviderStateMixin {
  int quantity = 1;
  bool isAddedToCart = false;
  bool isFavorite = false;

  late AnimationController _heartController;
  late Animation<double> _heartAnimation;

  @override
  void initState() {
    super.initState();

    isFavorite = FavoriteSession.isFavorite(widget.name);

    _heartController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _heartAnimation = Tween<double>(begin: 1.0, end: 1.4).animate(
      CurvedAnimation(
        parent: _heartController,
        curve: Curves.elasticOut,
      ),
    );
  }

  @override
  void dispose() {
    _heartController.dispose();
    super.dispose();
  }

  int get unitPrice {
    final onlyNumbers = widget.price.replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(onlyNumbers) ?? 0;
  }

  int get totalPrice {
    return unitPrice * quantity;
  }

  String get totalPriceText {
    return 'Rs. $totalPrice';
  }

  void increaseQuantity() {
    setState(() {
      quantity++;
      isAddedToCart = false;
    });
  }

  void decreaseQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
        isAddedToCart = false;
      });
    }
  }

  void toggleFavorite() {
    FavoriteSession.toggleFavorite(
      name: widget.name,
      price: widget.price,
      icon: widget.icon,
    );

    setState(() {
      isFavorite = FavoriteSession.isFavorite(widget.name);
    });

    _heartController.forward().then((_) {
      _heartController.reverse();
    });

    _showSmallMessage(
      isFavorite ? 'Added to Favorites' : 'Removed from Favorites',
      isFavorite ? Icons.favorite : Icons.favorite_border,
      isFavorite ? Colors.redAccent : AppColors.darkGreen,
    );
  }

  void _showSmallMessage(String message, IconData icon, Color backgroundColor) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 18,
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.fromLTRB(45, 0, 45, 95),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }

  void _showCartAddedDialog({
    required bool isDark,
    required Color cardColor,
    required Color textColor,
    required Color subTextColor,
    required Color borderColor,
    required Color secondCardColor,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.45),
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Center(
            child: Container(
              width: 300,
              padding: const EdgeInsets.fromLTRB(24, 30, 24, 24),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: borderColor),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(isDark ? 0.35 : 0.12),
                    blurRadius: 40,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 78,
                    height: 78,
                    decoration: BoxDecoration(
                      color: AppColors.iconBackground(context),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primaryGreen.withOpacity(0.3),
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      color: AppColors.darkGreen,
                      size: 40,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'Added to Cart! 🛒',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Item successfully added',
                    style: TextStyle(
                      fontSize: 13,
                      color: subTextColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: secondCardColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: borderColor),
                    ),
                    child: Row(
                      children: [
                        Text(
                          widget.icon,
                          style: const TextStyle(fontSize: 30),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.name,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: textColor,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 3),
                              Text(
                                '$quantity item${quantity > 1 ? 's' : ''} • $totalPriceText',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: subTextColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(dialogContext).pop();

                      Future.delayed(const Duration(milliseconds: 100), () {
                        goToCart();
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: AppColors.darkGreen,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.darkGreen.withOpacity(0.30),
                            blurRadius: 12,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.white,
                            size: 18,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'View Cart',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(dialogContext).pop();
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: borderColor),
                      ),
                      child: Text(
                        'Continue Shopping',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: subTextColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void addToCart({
    required bool isDark,
    required Color cardColor,
    required Color textColor,
    required Color subTextColor,
    required Color borderColor,
    required Color secondCardColor,
  }) {
    CartSession.addItem(
      name: widget.name,
      price: widget.price,
      icon: widget.icon,
      quantity: quantity,
    );

    setState(() {
      isAddedToCart = true;
    });

    _showCartAddedDialog(
      isDark: isDark,
      cardColor: cardColor,
      textColor: textColor,
      subTextColor: subTextColor,
      borderColor: borderColor,
      secondCardColor: secondCardColor,
    );
  }

  void goToCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CartScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.only(left: 16),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: borderColor),
            ),
            child: Icon(
              Icons.arrow_back_ios_new,
              size: 16,
              color: textColor,
            ),
          ),
        ),
        title: Text(
          'Product Details',
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w800,
            fontSize: 17,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: goToCart,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: borderColor),
                ),
                child: const Icon(
                  Icons.shopping_cart_outlined,
                  size: 18,
                  color: AppColors.darkGreen,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 430),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(28),
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(color: borderColor),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(
                                isDark ? 0.18 : 0.04,
                              ),
                              blurRadius: 16,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 0,
                              left: 0,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: iconBoxColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.eco_outlined,
                                      size: 12,
                                      color: AppColors.darkGreen,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      'Fresh',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.darkGreen,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: toggleFavorite,
                                child: ScaleTransition(
                                  scale: _heartAnimation,
                                  child: Container(
                                    width: 36,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      color: isFavorite
                                          ? Colors.redAccent.withOpacity(0.12)
                                          : secondCardColor,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: borderColor),
                                    ),
                                    child: Icon(
                                      isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: isFavorite
                                          ? Colors.redAccent
                                          : subTextColor,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Center(
                                child: Text(
                                  widget.icon,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 110),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 18),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(color: borderColor),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.name,
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w800,
                                      color: textColor,
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      widget.price,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.darkGreen,
                                      ),
                                    ),
                                    Text(
                                      'per kg',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: subTextColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                ...List.generate(
                                  5,
                                      (i) => const Icon(
                                    Icons.star_rounded,
                                    size: 16,
                                    color: Color(0xFFFFC107),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  '4.9  •  128 reviews',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: subTextColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Fresh and healthy grocery product selected from high quality farms and delivered fresh to your doorstep. Rich in vitamins and minerals.',
                              style: TextStyle(
                                fontSize: 13,
                                height: 1.6,
                                color: subTextColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(26),
                    topRight: Radius.circular(26),
                  ),
                  border: Border(
                    top: BorderSide(color: borderColor),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(isDark ? 0.25 : 0.06),
                      blurRadius: 20,
                      offset: const Offset(0, -6),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Price',
                          style: TextStyle(
                            fontSize: 14,
                            color: subTextColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          totalPriceText,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            color: AppColors.darkGreen,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Container(
                          height: 52,
                          decoration: BoxDecoration(
                            color: secondCardColor,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: borderColor),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                onTap: decreaseQuantity,
                                borderRadius: const BorderRadius.horizontal(
                                  left: Radius.circular(16),
                                ),
                                child: Container(
                                  width: 44,
                                  height: 52,
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.remove,
                                    size: 20,
                                    color: quantity == 1
                                        ? subTextColor.withOpacity(0.45)
                                        : AppColors.darkGreen,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 38,
                                child: Text(
                                  quantity.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                    color: textColor,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: increaseQuantity,
                                borderRadius: const BorderRadius.horizontal(
                                  right: Radius.circular(16),
                                ),
                                child: Container(
                                  width: 44,
                                  height: 52,
                                  alignment: Alignment.center,
                                  child: const Icon(
                                    Icons.add,
                                    size: 20,
                                    color: AppColors.darkGreen,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: GestureDetector(
                            onTap: isAddedToCart
                                ? null
                                : () {
                              addToCart(
                                isDark: isDark,
                                cardColor: cardColor,
                                textColor: textColor,
                                subTextColor: subTextColor,
                                borderColor: borderColor,
                                secondCardColor: secondCardColor,
                              );
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              height: 52,
                              decoration: BoxDecoration(
                                color: isAddedToCart
                                    ? iconBoxColor
                                    : AppColors.darkGreen,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: isAddedToCart
                                    ? []
                                    : [
                                  BoxShadow(
                                    color: AppColors.darkGreen
                                        .withOpacity(0.30),
                                    blurRadius: 12,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    isAddedToCart
                                        ? Icons.check_circle_outline
                                        : Icons.shopping_cart_outlined,
                                    color: isAddedToCart
                                        ? AppColors.darkGreen
                                        : Colors.white,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    isAddedToCart ? 'Added!' : 'Add to Cart',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                      color: isAddedToCart
                                          ? AppColors.darkGreen
                                          : Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (isAddedToCart) ...[
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: goToCart,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 13),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: AppColors.primaryGreen.withOpacity(0.5),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.shopping_cart_checkout,
                                color: AppColors.darkGreen,
                                size: 17,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'View Cart Details',
                                style: TextStyle(
                                  color: AppColors.darkGreen,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}