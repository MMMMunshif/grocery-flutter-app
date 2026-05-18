class CartSession {
  static final List<Map<String, dynamic>> cartItems = [];

  static void addItem({
    required String name,
    required String price,
    required String icon,
    required int quantity,
  }) {
    final onlyNumbers = price.replaceAll(RegExp(r'[^0-9]'), '');
    final unitPrice = int.tryParse(onlyNumbers) ?? 0;
    final totalPrice = unitPrice * quantity;

    final existingIndex = cartItems.indexWhere((item) => item['name'] == name);

    if (existingIndex != -1) {
      cartItems[existingIndex]['quantity'] =
          cartItems[existingIndex]['quantity'] + quantity;

      cartItems[existingIndex]['totalPrice'] =
          cartItems[existingIndex]['unitPrice'] *
              cartItems[existingIndex]['quantity'];
    } else {
      cartItems.add({
        'name': name,
        'price': price,
        'icon': icon,
        'quantity': quantity,
        'unitPrice': unitPrice,
        'totalPrice': totalPrice,
      });
    }
  }

  static int get subtotal {
    int total = 0;

    for (final item in cartItems) {
      total += item['totalPrice'] as int;
    }

    return total;
  }

  static int get deliveryFee {
    if (cartItems.isEmpty) return 0;
    return 50;
  }

  static int get grandTotal {
    return subtotal + deliveryFee;
  }

  static List<Map<String, dynamic>> getCartCopy() {
    return cartItems.map((item) {
      return {
        'name': item['name'],
        'price': item['price'],
        'icon': item['icon'],
        'quantity': item['quantity'],
        'unitPrice': item['unitPrice'],
        'totalPrice': item['totalPrice'],
      };
    }).toList();
  }

  static void clearCart() {
    cartItems.clear();
  }
}