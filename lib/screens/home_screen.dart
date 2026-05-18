import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/app_colors.dart';
import '../services/notification_session.dart';
import '../services/user_session.dart';
import 'product_details_screen.dart';
import 'tips_screen.dart';
import 'goals_screen.dart';
import 'cart_screen.dart';
import 'profile_screen.dart';
import 'all_products_screen.dart';
import 'notification_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  String searchQuery = '';
  String selectedDistrict = 'Colombo';
  String selectedCategory = 'All';

  final List<String> districts = const [
    'Colombo',
    'Gampaha',
    'Kalutara',
    'Kandy',
    'Matale',
    'Nuwara Eliya',
    'Galle',
    'Matara',
    'Hambantota',
    'Jaffna',
    'Kilinochchi',
    'Mannar',
    'Vavuniya',
    'Mullaitivu',
    'Batticaloa',
    'Ampara',
    'Trincomalee',
    'Kurunegala',
    'Puttalam',
    'Anuradhapura',
    'Polonnaruwa',
    'Badulla',
    'Monaragala',
    'Ratnapura',
    'Kegalle',
  ];

  final List<Map<String, String>> categories = const [
    {
      'name': 'Vegetables',
      'icon': '🥦',
      'image': 'assets/images/vegetables.png',
    },
    {
      'name': 'Fruits',
      'icon': '🍎',
      'image': 'assets/images/fruits.png',
    },
    {
      'name': 'Bakery',
      'icon': '🍞',
      'image': 'assets/images/bakery.png',
    },
    {
      'name': 'Snacks',
      'icon': '🍿',
      'image': 'assets/images/snacks.png',
    },
    {
      'name': 'Personal Care',
      'icon': '🧴',
      'image': 'assets/images/personal-care.png',
    },
    {
      'name': 'Health Care',
      'icon': '💊',
      'image': 'assets/images/health-care.png',
    },
    {
      'name': 'Baby Items',
      'icon': '🍼',
      'image': 'assets/images/baby-items.png',
    },
    {
      'name': 'Meat',
      'icon': '🥩',
      'image': 'assets/images/meat.png',
    },
    {
      'name': 'Fish and Shellfish',
      'icon': '🐟',
      'image': 'assets/images/fish.png',
    },
    {
      'name': 'Household Supplies',
      'icon': '🧽',
      'image': 'assets/images/household.png',
    },
    {
      'name': 'Cooking Essentials',
      'icon': '🧂',
      'image': 'assets/images/cooking-essentials.png',
    },
  ];

  final List<Map<String, String>> products = const [
    // Vegetables
    {
      'name': 'Broccoli',
      'price': 'Rs. 380',
      'icon': '🥦',
      'image': 'assets/images/broccoli.png',
      'unit': '1 Kg',
      'category': 'Vegetables',
    },
    {
      'name': 'Carrot',
      'price': 'Rs. 250',
      'icon': '🥕',
      'image': 'assets/images/carrot.png',
      'unit': '1 Kg',
      'category': 'Vegetables',
    },
    {
      'name': 'Tomato',
      'price': 'Rs. 300',
      'icon': '🍅',
      'image': 'assets/images/tomato.png',
      'unit': '1 Kg',
      'category': 'Vegetables',
    },
    {
      'name': 'Potato',
      'price': 'Rs. 280',
      'icon': '🥔',
      'image': 'assets/images/potato.png',
      'unit': '1 Kg',
      'category': 'Vegetables',
    },
    {
      'name': 'Onion',
      'price': 'Rs. 350',
      'icon': '🧅',
      'image': 'assets/images/onion.png',
      'unit': '1 Kg',
      'category': 'Vegetables',
    },
    {
      'name': 'Cabbage',
      'price': 'Rs. 260',
      'icon': '🥬',
      'image': 'assets/images/cabbage.png',
      'unit': '1 Kg',
      'category': 'Vegetables',
    },
    {
      'name': 'Pumpkin',
      'price': 'Rs. 240',
      'icon': '🎃',
      'image': 'assets/images/pumpkin.png',
      'unit': '1 Kg',
      'category': 'Vegetables',
    },
    {
      'name': 'Cucumber',
      'price': 'Rs. 220',
      'icon': '🥒',
      'image': 'assets/images/cucumber.png',
      'unit': '1 Kg',
      'category': 'Vegetables',
    },

    // Fruits
    {
      'name': 'Fresh Apple',
      'price': 'Rs. 450',
      'icon': '🍎',
      'image': 'assets/images/apple.png',
      'unit': '1 Kg',
      'category': 'Fruits',
    },
    {
      'name': 'Banana',
      'price': 'Rs. 320',
      'icon': '🍌',
      'image': 'assets/images/banana.png',
      'unit': '1 Kg',
      'category': 'Fruits',
    },
    {
      'name': 'Orange',
      'price': 'Rs. 480',
      'icon': '🍊',
      'image': 'assets/images/orange.png',
      'unit': '1 Kg',
      'category': 'Fruits',
    },
    {
      'name': 'Grapes',
      'price': 'Rs. 950',
      'icon': '🍇',
      'image': 'assets/images/grapes.png',
      'unit': '1 Kg',
      'category': 'Fruits',
    },
    {
      'name': 'Mango',
      'price': 'Rs. 600',
      'icon': '🥭',
      'image': 'assets/images/mango.png',
      'unit': '1 Kg',
      'category': 'Fruits',
    },
    {
      'name': 'Pineapple',
      'price': 'Rs. 420',
      'icon': '🍍',
      'image': 'assets/images/pineapple.png',
      'unit': '1 Pc',
      'category': 'Fruits',
    },
    {
      'name': 'Watermelon',
      'price': 'Rs. 500',
      'icon': '🍉',
      'image': 'assets/images/watermelon.png',
      'unit': '1 Pc',
      'category': 'Fruits',
    },
    {
      'name': 'Strawberry',
      'price': 'Rs. 1200',
      'icon': '🍓',
      'image': 'assets/images/strawberry.png',
      'unit': '1 Box',
      'category': 'Fruits',
    },

    // Bakery
    {
      'name': 'White Bread',
      'price': 'Rs. 220',
      'icon': '🍞',
      'image': 'assets/images/white-bread.png',
      'unit': '1 Pack',
      'category': 'Bakery',
    },
    {
      'name': 'Rusk',
      'price': 'Rs. 200',
      'icon': '🥖',
      'image': 'assets/images/rusk.png',
      'unit': '1 Pack',
      'category': 'Bakery',
    },
    {
      'name': 'Croissant',
      'price': 'Rs. 280',
      'icon': '🥐',
      'image': 'assets/images/croissant.png',
      'unit': '1 Pc',
      'category': 'Bakery',
    },
    {
      'name': 'Bun',
      'price': 'Rs. 120',
      'icon': '🥯',
      'image': 'assets/images/bun.png',
      'unit': '1 Pc',
      'category': 'Bakery',
    },
    {
      'name': 'Cake Slice',
      'price': 'Rs. 350',
      'icon': '🍰',
      'image': 'assets/images/cake-slice.png',
      'unit': '1 Pc',
      'category': 'Bakery',
    },
    {
      'name': 'Muffin',
      'price': 'Rs. 220',
      'icon': '🧁',
      'image': 'assets/images/muffin.png',
      'unit': '1 Pc',
      'category': 'Bakery',
    },
    {
      'name': 'Brown Bread',
      'price': 'Rs. 260',
      'icon': '🍞',
      'image': 'assets/images/brown-bread.png',
      'unit': '1 Pack',
      'category': 'Bakery',
    },
    {
      'name': 'Garlic Bread',
      'price': 'Rs. 380',
      'icon': '🥖',
      'image': 'assets/images/garlic-bread.png',
      'unit': '1 Pack',
      'category': 'Bakery',
    },

    // Snacks
    {
      'name': 'Potato Chips',
      'price': 'Rs. 250',
      'icon': '🍟',
      'image': 'assets/images/potato-chips.png',
      'unit': '1 Pack',
      'category': 'Snacks',
    },
    {
      'name': 'Chocolate',
      'price': 'Rs. 300',
      'icon': '🍫',
      'image': 'assets/images/chocolate.png',
      'unit': '1 Pc',
      'category': 'Snacks',
    },
    {
      'name': 'Popcorn',
      'price': 'Rs. 220',
      'icon': '🍿',
      'image': 'assets/images/popcorn.png',
      'unit': '1 Pack',
      'category': 'Snacks',
    },
    {
      'name': 'Cookies',
      'price': 'Rs. 180',
      'icon': '🍪',
      'image': 'assets/images/cookies.png',
      'unit': '1 Pack',
      'category': 'Snacks',
    },
    {
      'name': 'Crackers',
      'price': 'Rs. 200',
      'icon': '🥨',
      'image': 'assets/images/crackers.png',
      'unit': '1 Pack',
      'category': 'Snacks',
    },
    {
      'name': 'Mixed Nuts',
      'price': 'Rs. 650',
      'icon': '🥜',
      'image': 'assets/images/nuts.png',
      'unit': '1 Pack',
      'category': 'Snacks',
    },
    {
      'name': 'Cupcake',
      'price': 'Rs. 160',
      'icon': '🧁',
      'image': 'assets/images/cupcake.png',
      'unit': '1 Pc',
      'category': 'Snacks',
    },
    {
      'name': 'Donuts',
      'price': 'Rs. 190',
      'icon': '🍩',
      'image': 'assets/images/donuts.png',
      'unit': '1 Pc',
      'category': 'Snacks',
    },

    // Personal Care
    {
      'name': 'Shampoo',
      'price': 'Rs. 750',
      'icon': '🧴',
      'image': 'assets/images/shampoo.png',
      'unit': '1 Bottle',
      'category': 'Personal Care',
    },
    {
      'name': 'Bath Soap',
      'price': 'Rs. 180',
      'icon': '🧼',
      'image': 'assets/images/soap.png',
      'unit': '1 Pc',
      'category': 'Personal Care',
    },
    {
      'name': 'Toothpaste',
      'price': 'Rs. 320',
      'icon': '🪥',
      'image': 'assets/images/toothpaste.png',
      'unit': '1 Pc',
      'category': 'Personal Care',
    },
    {
      'name': 'Toothbrush',
      'price': 'Rs. 250',
      'icon': '🪥',
      'image': 'assets/images/toothbrush.png',
      'unit': '1 Pc',
      'category': 'Personal Care',
    },
    {
      'name': 'Body Lotion',
      'price': 'Rs. 950',
      'icon': '🧴',
      'image': 'assets/images/body-lotion.png',
      'unit': '1 Bottle',
      'category': 'Personal Care',
    },
    {
      'name': 'Face Wash',
      'price': 'Rs. 850',
      'icon': '🧴',
      'image': 'assets/images/face-wash.png',
      'unit': '1 Tube',
      'category': 'Personal Care',
    },
    {
      'name': 'Hand Wash',
      'price': 'Rs. 420',
      'icon': '🧴',
      'image': 'assets/images/hand-wash.png',
      'unit': '1 Bottle',
      'category': 'Personal Care',
    },
    {
      'name': 'Deodorant',
      'price': 'Rs. 900',
      'icon': '🧴',
      'image': 'assets/images/deodorant.png',
      'unit': '1 Bottle',
      'category': 'Personal Care',
    },

    // Health Care
    {
      'name': 'Vitamin C',
      'price': 'Rs. 1200',
      'icon': '💊',
      'image': 'assets/images/vitamin-c.png',
      'unit': '1 Bottle',
      'category': 'Health Care',
    },
    {
      'name': 'First Aid Kit',
      'price': 'Rs. 1500',
      'icon': '🧰',
      'image': 'assets/images/first-aid-kit.png',
      'unit': '1 Box',
      'category': 'Health Care',
    },
    {
      'name': 'Thermometer',
      'price': 'Rs. 950',
      'icon': '🌡️',
      'image': 'assets/images/thermometer.png',
      'unit': '1 Pc',
      'category': 'Health Care',
    },
    {
      'name': 'Bandage Pack',
      'price': 'Rs. 250',
      'icon': '🩹',
      'image': 'assets/images/bandage.png',
      'unit': '1 Pack',
      'category': 'Health Care',
    },
    {
      'name': 'Pain Relief Balm',
      'price': 'Rs. 480',
      'icon': '🧴',
      'image': 'assets/images/pain-relief-balm.png',
      'unit': '1 Pc',
      'category': 'Health Care',
    },
    {
      'name': 'Hand Sanitizer',
      'price': 'Rs. 350',
      'icon': '🧴',
      'image': 'assets/images/sanitizer.png',
      'unit': '1 Bottle',
      'category': 'Health Care',
    },
    {
      'name': 'Face Mask Pack',
      'price': 'Rs. 300',
      'icon': '😷',
      'image': 'assets/images/face-mask.png',
      'unit': '1 Pack',
      'category': 'Health Care',
    },
    {
      'name': 'Glucose Pack',
      'price': 'Rs. 400',
      'icon': '🥤',
      'image': 'assets/images/glucose.png',
      'unit': '1 Pack',
      'category': 'Health Care',
    },

    // Baby Items
    {
      'name': 'Baby Diapers',
      'price': 'Rs. 1850',
      'icon': '🍼',
      'image': 'assets/images/baby-diapers.png',
      'unit': '1 Pack',
      'category': 'Baby Items',
    },
    {
      'name': 'Baby Wipes',
      'price': 'Rs. 650',
      'icon': '🧻',
      'image': 'assets/images/baby-wipes.png',
      'unit': '1 Pack',
      'category': 'Baby Items',
    },
    {
      'name': 'Baby Shampoo',
      'price': 'Rs. 780',
      'icon': '🧴',
      'image': 'assets/images/baby-shampoo.png',
      'unit': '1 Bottle',
      'category': 'Baby Items',
    },
    {
      'name': 'Baby Lotion',
      'price': 'Rs. 850',
      'icon': '🧴',
      'image': 'assets/images/baby-lotion.png',
      'unit': '1 Bottle',
      'category': 'Baby Items',
    },
    {
      'name': 'Feeding Bottle',
      'price': 'Rs. 700',
      'icon': '🍼',
      'image': 'assets/images/feeding-bottle.png',
      'unit': '1 Pc',
      'category': 'Baby Items',
    },
    {
      'name': 'Baby Powder',
      'price': 'Rs. 520',
      'icon': '🧴',
      'image': 'assets/images/baby-powder.png',
      'unit': '1 Pc',
      'category': 'Baby Items',
    },
    {
      'name': 'Baby Soap',
      'price': 'Rs. 280',
      'icon': '🧼',
      'image': 'assets/images/baby-soap.png',
      'unit': '1 Pc',
      'category': 'Baby Items',
    },
    {
      'name': 'Baby Food',
      'price': 'Rs. 950',
      'icon': '🥣',
      'image': 'assets/images/baby-food.png',
      'unit': '1 Pack',
      'category': 'Baby Items',
    },

    // Meat
    {
      'name': 'Chicken',
      'price': 'Rs. 1450',
      'icon': '🍗',
      'image': 'assets/images/chicken.png',
      'unit': '1 Kg',
      'category': 'Meat',
    },
    {
      'name': 'Beef',
      'price': 'Rs. 2200',
      'icon': '🥩',
      'image': 'assets/images/beef.png',
      'unit': '1 Kg',
      'category': 'Meat',
    },
    {
      'name': 'Mutton',
      'price': 'Rs. 2800',
      'icon': '🥩',
      'image': 'assets/images/mutton.png',
      'unit': '1 Kg',
      'category': 'Meat',
    },
    {
      'name': 'Sausages',
      'price': 'Rs. 950',
      'icon': '🌭',
      'image': 'assets/images/sausages.png',
      'unit': '1 Pack',
      'category': 'Meat',
    },
    {
      'name': 'Chicken Breast',
      'price': 'Rs. 1650',
      'icon': '🍗',
      'image': 'assets/images/chicken-breast.png',
      'unit': '1 Kg',
      'category': 'Meat',
    },
    {
      'name': 'Chicken Wings',
      'price': 'Rs. 1350',
      'icon': '🍗',
      'image': 'assets/images/chicken-wings.png',
      'unit': '1 Kg',
      'category': 'Meat',
    },
    {
      'name': 'Minced Meat',
      'price': 'Rs. 1800',
      'icon': '🥩',
      'image': 'assets/images/minced-meat.png',
      'unit': '1 Kg',
      'category': 'Meat',
    },
    {
      'name': 'Meatballs',
      'price': 'Rs. 1200',
      'icon': '🍖',
      'image': 'assets/images/meatballs.png',
      'unit': '1 Pack',
      'category': 'Meat',
    },

    // Fish and Shellfish
    {
      'name': 'Tuna Fish',
      'price': 'Rs. 1600',
      'icon': '🐟',
      'image': 'assets/images/tuna.png',
      'unit': '1 Kg',
      'category': 'Fish and Shellfish',
    },
    {
      'name': 'Salmon',
      'price': 'Rs. 3500',
      'icon': '🐟',
      'image': 'assets/images/salmon.png',
      'unit': '1 Kg',
      'category': 'Fish and Shellfish',
    },
    {
      'name': 'Prawns',
      'price': 'Rs. 2200',
      'icon': '🦐',
      'image': 'assets/images/prawns.png',
      'unit': '1 Kg',
      'category': 'Fish and Shellfish',
    },
    {
      'name': 'Crab',
      'price': 'Rs. 1800',
      'icon': '🦀',
      'image': 'assets/images/crab.png',
      'unit': '1 Kg',
      'category': 'Fish and Shellfish',
    },
    {
      'name': 'Squid',
      'price': 'Rs. 1700',
      'icon': '🦑',
      'image': 'assets/images/squid.png',
      'unit': '1 Kg',
      'category': 'Fish and Shellfish',
    },
    {
      'name': 'Seer Fish',
      'price': 'Rs. 2400',
      'icon': '🐟',
      'image': 'assets/images/seer-fish.png',
      'unit': '1 Kg',
      'category': 'Fish and Shellfish',
    },
    {
      'name': 'Sardines',
      'price': 'Rs. 900',
      'icon': '🐟',
      'image': 'assets/images/sardines.png',
      'unit': '1 Kg',
      'category': 'Fish and Shellfish',
    },
    {
      'name': 'Lobster',
      'price': 'Rs. 4200',
      'icon': '🦞',
      'image': 'assets/images/lobster.png',
      'unit': '1 Kg',
      'category': 'Fish and Shellfish',
    },

    // Household Supplies
    {
      'name': 'Dishwash Liquid',
      'price': 'Rs. 550',
      'icon': '🧴',
      'image': 'assets/images/dishwash-liquid.png',
      'unit': '1 Bottle',
      'category': 'Household Supplies',
    },
    {
      'name': 'Laundry Powder',
      'price': 'Rs. 950',
      'icon': '🧼',
      'image': 'assets/images/laundry-powder.png',
      'unit': '1 Pack',
      'category': 'Household Supplies',
    },
    {
      'name': 'Floor Cleaner',
      'price': 'Rs. 780',
      'icon': '🧴',
      'image': 'assets/images/floor-cleaner.png',
      'unit': '1 Bottle',
      'category': 'Household Supplies',
    },
    {
      'name': 'Toilet Cleaner',
      'price': 'Rs. 650',
      'icon': '🧴',
      'image': 'assets/images/toilet-cleaner.png',
      'unit': '1 Bottle',
      'category': 'Household Supplies',
    },
    {
      'name': 'Tissue Roll',
      'price': 'Rs. 480',
      'icon': '🧻',
      'image': 'assets/images/tissue-roll.png',
      'unit': '1 Pack',
      'category': 'Household Supplies',
    },
    {
      'name': 'Garbage Bags',
      'price': 'Rs. 400',
      'icon': '🗑️',
      'image': 'assets/images/garbage-bags.png',
      'unit': '1 Pack',
      'category': 'Household Supplies',
    },
    {
      'name': 'Cleaning Sponge',
      'price': 'Rs. 180',
      'icon': '🧽',
      'image': 'assets/images/sponge.png',
      'unit': '1 Pc',
      'category': 'Household Supplies',
    },
    {
      'name': 'Air Freshener',
      'price': 'Rs. 720',
      'icon': '🌸',
      'image': 'assets/images/air-freshener.png',
      'unit': '1 Bottle',
      'category': 'Household Supplies',
    },

    // Cooking Essentials
    {
      'name': 'Cooking Oil',
      'price': 'Rs. 950',
      'icon': '🛢️',
      'image': 'assets/images/cooking oil.png',
      'unit': '1 Bottle',
      'category': 'Cooking Essentials',
    },
    {
      'name': 'Vinegar',
      'price': 'Rs. 280',
      'icon': '🍾',
      'image': 'assets/images/vinegar.png',
      'unit': '1 Bottle',
      'category': 'Cooking Essentials',
    },
    {
      'name': 'Salt',
      'price': 'Rs. 120',
      'icon': '🧂',
      'image': 'assets/images/salt.png',
      'unit': '1 Pack',
      'category': 'Cooking Essentials',
    },
    {
      'name': 'Sugar',
      'price': 'Rs. 350',
      'icon': '🍚',
      'image': 'assets/images/sugar.png',
      'unit': '1 Kg',
      'category': 'Cooking Essentials',
    },
    {
      'name': 'Flour',
      'price': 'Rs. 420',
      'icon': '🌾',
      'image': 'assets/images/flour.png',
      'unit': '1 Kg',
      'category': 'Cooking Essentials',
    },
    {
      'name': 'Rice',
      'price': 'Rs. 1200',
      'icon': '🍚',
      'image': 'assets/images/rice.png',
      'unit': '5 Kg',
      'category': 'Cooking Essentials',
    },
    {
      'name': 'Mixed Spices',
      'price': 'Rs. 550',
      'icon': '🌶️',
      'image': 'assets/images/spices.png',
      'unit': '1 Pack',
      'category': 'Cooking Essentials',
    },
    {
      'name': 'Soy Sauce',
      'price': 'Rs. 480',
      'icon': '🍾',
      'image': 'assets/images/soy-sauce.png',
      'unit': '1 Bottle',
      'category': 'Cooking Essentials',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, String>> get filteredProducts {
    List<Map<String, String>> result = products;

    if (selectedCategory != 'All') {
      result = result.where((product) {
        return product['category'] == selectedCategory;
      }).toList();
    }

    if (searchQuery.trim().isNotEmpty) {
      final query = searchQuery.toLowerCase().trim();

      result = result.where((product) {
        final name = product['name']!.toLowerCase();
        final category = product['category']!.toLowerCase();

        return name.contains(query) || category.contains(query);
      }).toList();
    }

    if (selectedCategory == 'All' && searchQuery.trim().isEmpty) {
      return result.take(4).toList();
    }

    return result;
  }

  String get productsTitle {
    if (searchQuery.trim().isNotEmpty) return 'Search Results';
    if (selectedCategory != 'All') return selectedCategory;
    return 'Best Deal 🔥';
  }

  void _openScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  Future<void> _openNotificationScreen() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NotificationScreen(),
      ),
    );

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _openProductDetails(
      BuildContext context,
      Map<String, String> product,
      ) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailsScreen(
          name: product['name']!,
          price: product['price']!,
          icon: product['icon']!,
        ),
      ),
    );

    if (mounted) {
      setState(() {});
    }
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      searchQuery = '';
    });
  }

  void _selectCategory(String categoryName) {
    setState(() {
      selectedCategory = categoryName;
      searchQuery = '';
      _searchController.clear();
    });
  }

  void _clearCategory() {
    setState(() {
      selectedCategory = 'All';
    });
  }

  void _showAddressDialog(String district) {
    final TextEditingController addressController = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.35),
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Center(
            child: Container(
              width: 330,
              padding: const EdgeInsets.fromLTRB(22, 24, 22, 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(26),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.darkGreen.withOpacity(0.18),
                    blurRadius: 32,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          color: AppColors.lightGreen,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.location_on_outlined,
                          color: AppColors.darkGreen,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Enter Delivery Address',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w900,
                                color: AppColors.textDark,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              district,
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.textGrey,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  TextField(
                    controller: addressController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText:
                      'Example: No 92, Methaipalli Road, Kattankudy 02',
                      hintStyle: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textGrey,
                      ),
                      filled: true,
                      fillColor: const Color(0xFFF7FBF8),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Color(0xFFE2E2E2),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Color(0xFFE2E2E2),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: AppColors.darkGreen,
                          width: 1.4,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(dialogContext);
                          },
                          child: Container(
                            height: 48,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF7FBF8),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: const Color(0xFFE2E2E2),
                              ),
                            ),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                color: AppColors.textGrey,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            final typedAddress = addressController.text.trim();

                            if (typedAddress.isEmpty) {
                              ScaffoldMessenger.of(context).hideCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text(
                                    'Please enter your delivery address',
                                    textAlign: TextAlign.center,
                                  ),
                                  backgroundColor: AppColors.darkGreen,
                                  duration: const Duration(seconds: 2),
                                  behavior: SnackBarBehavior.floating,
                                  margin:
                                  const EdgeInsets.fromLTRB(55, 0, 55, 95),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              );
                              return;
                            }

                            setState(() {
                              selectedDistrict = district;
                              UserSession.address = '$typedAddress, $district';
                            });

                            Navigator.pop(dialogContext);

                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text(
                                  'Address saved successfully',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                backgroundColor: AppColors.darkGreen,
                                duration: const Duration(seconds: 2),
                                behavior: SnackBarBehavior.floating,
                                margin:
                                const EdgeInsets.fromLTRB(55, 0, 55, 95),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: 48,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColors.darkGreen,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Text(
                              'Save',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showAllCategoriesSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheetContext) {
        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.72,
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
              decoration: const BoxDecoration(
                color: Color(0xFFF7FBF8),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(26),
                  topRight: Radius.circular(26),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 46,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'All Categories',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: AppColors.textDark,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(sheetContext);
                        },
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: categories.length,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 1.45,
                      ),
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        final isSelected =
                            selectedCategory == category['name'];

                        return GestureDetector(
                          onTap: () {
                            Navigator.pop(sheetContext);
                            _selectCategory(category['name']!);
                          },
                          child: _CategoryGridCard(
                            category: category,
                            isSelected: isSelected,
                          ),
                        );
                      },
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

  void _showDistrictBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (bottomSheetContext) {
        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.72,
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
              decoration: const BoxDecoration(
                color: Color(0xFFF7FBF8),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(26),
                  topRight: Radius.circular(26),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 46,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Select District',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textDark,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(bottomSheetContext);
                        },
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemCount: districts.length,
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 8);
                      },
                      itemBuilder: (context, index) {
                        final district = districts[index];
                        final isSelected = district == selectedDistrict;

                        return GestureDetector(
                          onTap: () {
                            Navigator.pop(bottomSheetContext);

                            Future.delayed(
                              const Duration(milliseconds: 250),
                                  () {
                                if (mounted) {
                                  _showAddressDialog(district);
                                }
                              },
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 13,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.lightGreen
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.primaryGreen
                                    : const Color(0xFFE8E8E8),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  color: isSelected
                                      ? AppColors.darkGreen
                                      : AppColors.textGrey,
                                  size: 20,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    district,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: isSelected
                                          ? FontWeight.w800
                                          : FontWeight.w600,
                                      color: isSelected
                                          ? AppColors.darkGreen
                                          : AppColors.textDark,
                                    ),
                                  ),
                                ),
                                if (isSelected)
                                  const Icon(
                                    Icons.check_circle,
                                    color: AppColors.darkGreen,
                                    size: 20,
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
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final visibleProducts = filteredProducts;

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor =
    isDark ? AppColors.darkBackground : const Color(0xFFF7FBF8);
    final cardColor = isDark ? AppColors.darkCard : Colors.white;
    final textColor = isDark ? AppColors.darkText : AppColors.textDark;
    final subTextColor = isDark ? AppColors.darkSubText : AppColors.textGrey;
    final borderColor = isDark ? AppColors.darkBorder : const Color(0xFFE2E2E2);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 430),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Location',
                            style: TextStyle(
                              fontSize: 13,
                              color: subTextColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: _showDistrictBottomSheet,
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    color: AppColors.darkGreen,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    selectedDistrict,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: textColor,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 18,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: _openNotificationScreen,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                width: 42,
                                height: 42,
                                decoration: BoxDecoration(
                                  color: AppColors.lightGreen,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: const Icon(
                                  Icons.notifications_none_rounded,
                                  color: AppColors.darkGreen,
                                ),
                              ),
                              if (NotificationSession.hasUnreadNotifications)
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
                                        color: Colors.white,
                                        width: 1.5,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Search bar
                  Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: borderColor),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.search,
                          color: AppColors.textGrey,
                          size: 20,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            onChanged: (value) {
                              setState(() {
                                searchQuery = value;
                              });
                            },
                            style: TextStyle(color: textColor),
                            cursorColor: AppColors.darkGreen,
                            decoration: InputDecoration(
                              hintText: 'Search product name',
                              hintStyle: TextStyle(
                                color: subTextColor,
                                fontSize: 13,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        if (searchQuery.isNotEmpty)
                          GestureDetector(
                            onTap: _clearSearch,
                            child: const Icon(
                              Icons.close,
                              color: AppColors.textGrey,
                              size: 20,
                            ),
                          )
                        else
                          const Icon(
                            Icons.tune,
                            color: AppColors.darkGreen,
                            size: 20,
                          ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),

                  // Discount banner
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.lightGreen,
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Up to 25% Discount',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.darkGreen,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Fresh groceries available\nnear $selectedDistrict',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: textColor,
                                  height: 1.3,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 7,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.darkGreen,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text(
                                  'Shop Now',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Image.asset(
                          'assets/images/vegetables.png',
                          width: 95,
                          height: 95,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return const Text(
                              '🥬',
                              style: TextStyle(fontSize: 70),
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Category title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Category',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: textColor,
                        ),
                      ),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: _showAllCategoriesSheet,
                          child: const Text(
                            'View All',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.darkGreen,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  // Categories horizontal scroll
                  SizedBox(
                    height: 105,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: categories.length,
                      separatorBuilder: (context, index) =>
                      const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        final isSelected =
                            selectedCategory == category['name'];

                        return GestureDetector(
                          onTap: () {
                            _selectCategory(category['name']!);
                          },
                          child: _CategoryCard(
                            category: category,
                            isSelected: isSelected,
                          ),
                        );
                      },
                    ),
                  ),

                  if (selectedCategory != 'All') ...[
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: _clearCategory,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.lightGreen,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColors.primaryGreen.withOpacity(0.35),
                          ),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.close,
                              size: 15,
                              color: AppColors.darkGreen,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Clear Category',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.darkGreen,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],

                  const SizedBox(height: 24),

                  // Products title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        productsTitle,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: textColor,
                        ),
                      ),
                      if (selectedCategory == 'All' &&
                          searchQuery.trim().isEmpty)
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              _openScreen(
                                context,
                                AllProductsScreen(products: products),
                              );
                            },
                            child: const Text(
                              'View All',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.darkGreen,
                                fontWeight: FontWeight.w700,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  if (visibleProducts.isEmpty)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 36),
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: borderColor),
                      ),
                      child: Center(
                        child: Text(
                          'No products found',
                          style: TextStyle(
                            fontSize: 15,
                            color: subTextColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                  else
                    GridView.builder(
                      itemCount: visibleProducts.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 14,
                        crossAxisSpacing: 14,
                        childAspectRatio: 0.78,
                      ),
                      itemBuilder: (context, index) {
                        final product = visibleProducts[index];

                        return GestureDetector(
                          onTap: () {
                            _openProductDetails(context, product);
                          },
                          child: _ProductCard(product: product),
                        );
                      },
                    ),

                  const SizedBox(height: 90),
                ],
              ),
            ),
          ),
        ),
      ),

      // Bottom navigation
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 0, 18, 12),
          child: Center(
            heightFactor: 1,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: Container(
                height: 68,
                decoration: BoxDecoration(
                  color: AppColors.primaryGreen,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const _BottomNavItem(
                      icon: Icons.home_rounded,
                      label: 'Home',
                      active: true,
                    ),
                    _BottomNavItem(
                      icon: Icons.lightbulb_outline,
                      label: 'Tips',
                      onTap: () {
                        _openScreen(context, const TipsScreen());
                      },
                    ),
                    _BottomNavItem(
                      icon: Icons.track_changes,
                      label: 'Goal',
                      onTap: () {
                        _openScreen(context, const GoalsScreen());
                      },
                    ),
                    _BottomNavItem(
                      icon: Icons.shopping_cart_outlined,
                      label: 'Cart',
                      onTap: () {
                        _openScreen(context, const CartScreen());
                      },
                    ),
                    _BottomNavItem(
                      icon: Icons.person_outline,
                      label: 'Profile',
                      onTap: () {
                        _openScreen(context, const ProfileScreen());
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final Map<String, String> category;
  final bool isSelected;

  const _CategoryCard({
    required this.category,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? AppColors.darkCard : Colors.white;
    final textColor = isDark ? AppColors.darkText : AppColors.textDark;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.primaryGreen.withOpacity(0.35);

    return Container(
      width: 92,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.lightGreen
            : cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isSelected ? AppColors.darkGreen : borderColor,
          width: isSelected ? 1.4 : 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            category['image']!,
            width: 35,
            height: 35,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Text(
                category['icon']!,
                style: const TextStyle(fontSize: 28),
              );
            },
          ),
          const SizedBox(height: 8),
          Text(
            category['name']!,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 10.5,
              fontWeight: isSelected ? FontWeight.w900 : FontWeight.w600,
              color: isSelected ? AppColors.darkGreen : textColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryGridCard extends StatelessWidget {
  final Map<String, String> category;
  final bool isSelected;

  const _CategoryGridCard({
    required this.category,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? AppColors.darkCard : Colors.white;
    final textColor = isDark ? AppColors.darkText : AppColors.textDark;
    final borderColor = isDark ? AppColors.darkBorder : const Color(0xFFE8E8E8);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.lightGreen : cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isSelected ? AppColors.darkGreen : borderColor,
          width: isSelected ? 1.4 : 1,
        ),
      ),
      child: Row(
        children: [
          Image.asset(
            category['image']!,
            width: 38,
            height: 38,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Text(
                category['icon']!,
                style: const TextStyle(fontSize: 30),
              );
            },
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              category['name']!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w900 : FontWeight.w700,
                color: isSelected ? AppColors.darkGreen : textColor,
              ),
            ),
          ),
          if (isSelected)
            const Icon(
              Icons.check_circle,
              color: AppColors.darkGreen,
              size: 18,
            ),
        ],
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final Map<String, String> product;

  const _ProductCard({
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? AppColors.darkCard : Colors.white;
    final textColor = isDark ? AppColors.darkText : AppColors.textDark;
    final subTextColor = isDark ? AppColors.darkSubText : AppColors.textGrey;
    final borderColor = isDark ? AppColors.darkBorder : const Color(0xFFE8E8E8);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: borderColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 7,
                vertical: 3,
              ),
              decoration: BoxDecoration(
                color: AppColors.primaryGreen,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'Best',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Image.asset(
                product['image']!,
                width: 115,
                height: 115,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Text(
                    product['icon']!,
                    style: const TextStyle(fontSize: 75),
                  );
                },
              ),
            ),
          ),
          Text(
            product['name']!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: textColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            product['price']!,
            style: TextStyle(
              fontSize: 12,
              color: subTextColor,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                product['unit'] ?? '1 Kg',
                style: TextStyle(
                  fontSize: 11,
                  color: subTextColor,
                ),
              ),
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: AppColors.darkGreen,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback? onTap;

  const _BottomNavItem({
    required this.icon,
    required this.label,
    this.active = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: SizedBox(
        width: 58,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: active ? Colors.white : Colors.white70,
              size: 22,
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                color: active ? Colors.white : Colors.white70,
                fontSize: 10,
                fontWeight: active ? FontWeight.w700 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}