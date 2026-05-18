import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/app_colors.dart';
import 'product_details_screen.dart';

class AllProductsScreen extends StatefulWidget {
  final List<Map<String, String>> products;

  const AllProductsScreen({
    super.key,
    required this.products,
  });

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  final TextEditingController _searchController = TextEditingController();

  String searchQuery = '';
  String selectedCategory = 'All';

  final List<Map<String, String>> categories = const [
    {
      'name': 'All',
      'icon': '🛒',
      'image': 'assets/images/grocery.png',
    },
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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, String>> get filteredProducts {
    List<Map<String, String>> result = widget.products;

    if (selectedCategory != 'All') {
      result = result.where((product) {
        return product['category'] == selectedCategory;
      }).toList();
    }

    if (searchQuery.trim().isNotEmpty) {
      final query = searchQuery.toLowerCase().trim();

      result = result.where((product) {
        final name = (product['name'] ?? '').toLowerCase();
        final category = (product['category'] ?? '').toLowerCase();

        return name.contains(query) || category.contains(query);
      }).toList();
    }

    return result;
  }

  String get titleText {
    if (searchQuery.trim().isNotEmpty) {
      return 'Search Results';
    }

    if (selectedCategory != 'All') {
      return selectedCategory;
    }

    return 'All Products';
  }

  void _openProductDetails(BuildContext context, Map<String, String> product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailsScreen(
          name: product['name']!,
          price: product['price']!,
          icon: product['icon']!,
        ),
      ),
    );
  }

  void _selectCategory(String categoryName) {
    setState(() {
      selectedCategory = categoryName;
      searchQuery = '';
      _searchController.clear();
    });
  }

  void _clearSearch() {
    setState(() {
      searchQuery = '';
      _searchController.clear();
    });
  }

  void _showAllCategoriesSheet() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor =
    isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final cardColor = isDark ? AppColors.darkCard : Colors.white;
    final textColor = isDark ? AppColors.darkText : AppColors.textDark;
    final subTextColor = isDark ? AppColors.darkSubText : AppColors.textGrey;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;

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
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: const BorderRadius.only(
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
                      color: isDark ? Colors.white24 : Colors.black12,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                  const SizedBox(height: 18),

                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'All Categories',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: textColor,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(sheetContext);
                        },
                        icon: Icon(
                          Icons.close,
                          color: textColor,
                        ),
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
                            cardColor: cardColor,
                            textColor: textColor,
                            subTextColor: subTextColor,
                            borderColor: borderColor,
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
    final products = filteredProducts;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final backgroundColor =
    isDark ? AppColors.darkBackground : AppColors.lightBackground;

    final cardColor = isDark ? AppColors.darkCard : Colors.white;

    final secondCardColor =
    isDark ? AppColors.darkCardLight : const Color(0xFFF7FBF8);

    final textColor = isDark ? AppColors.darkText : AppColors.textDark;

    final subTextColor = isDark ? AppColors.darkSubText : AppColors.textGrey;

    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 430),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
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
                            titleText,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              color: textColor,
                            ),
                          ),
                        ),
                      ),

                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: _showAllCategoriesSheet,
                          child: Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              color: isDark
                                  ? AppColors.darkGreen.withOpacity(0.18)
                                  : AppColors.lightGreen,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: isDark
                                    ? AppColors.darkGreen.withOpacity(0.28)
                                    : Colors.transparent,
                              ),
                            ),
                            child: const Icon(
                              Icons.grid_view_rounded,
                              color: AppColors.darkGreen,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: borderColor,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          color: subTextColor,
                          size: 20,
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            style: TextStyle(
                              color: textColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            onChanged: (value) {
                              setState(() {
                                searchQuery = value;
                              });
                            },
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
                            child: Icon(
                              Icons.close,
                              color: subTextColor,
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

                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Categories',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
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
                              fontWeight: FontWeight.w800,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  SizedBox(
                    height: 105,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: categories.length,
                      separatorBuilder: (context, index) {
                        return const SizedBox(width: 12);
                      },
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
                            cardColor: cardColor,
                            textColor: textColor,
                            subTextColor: subTextColor,
                            borderColor: borderColor,
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          selectedCategory == 'All'
                              ? 'Showing ${products.length} products'
                              : '$selectedCategory (${products.length})',
                          style: TextStyle(
                            fontSize: 13,
                            color: subTextColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),

                      if (selectedCategory != 'All')
                        GestureDetector(
                          onTap: () {
                            _selectCategory('All');
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? AppColors.darkGreen.withOpacity(0.18)
                                  : AppColors.lightGreen,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isDark
                                    ? AppColors.darkGreen.withOpacity(0.35)
                                    : Colors.transparent,
                              ),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.close,
                                  size: 14,
                                  color: AppColors.darkGreen,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'Clear',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: AppColors.darkGreen,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Expanded(
                    child: products.isEmpty
                        ? _EmptyProductsView(
                      cardColor: cardColor,
                      textColor: textColor,
                      subTextColor: subTextColor,
                      borderColor: borderColor,
                    )
                        : GridView.builder(
                      itemCount: products.length,
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 14,
                        crossAxisSpacing: 14,
                        childAspectRatio: 0.78,
                      ),
                      itemBuilder: (context, index) {
                        final product = products[index];

                        return GestureDetector(
                          onTap: () {
                            _openProductDetails(context, product);
                          },
                          child: _ProductCard(
                            product: product,
                            cardColor: cardColor,
                            secondCardColor: secondCardColor,
                            textColor: textColor,
                            subTextColor: subTextColor,
                            borderColor: borderColor,
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

class _CategoryCard extends StatelessWidget {
  final Map<String, String> category;
  final bool isSelected;
  final Color cardColor;
  final Color textColor;
  final Color subTextColor;
  final Color borderColor;

  const _CategoryCard({
    required this.category,
    required this.isSelected,
    required this.cardColor,
    required this.textColor,
    required this.subTextColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 92,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.darkGreen.withOpacity(isDark ? 0.22 : 0.12)
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
  final Color cardColor;
  final Color textColor;
  final Color subTextColor;
  final Color borderColor;

  const _CategoryGridCard({
    required this.category,
    required this.isSelected,
    required this.cardColor,
    required this.textColor,
    required this.subTextColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.darkGreen.withOpacity(isDark ? 0.22 : 0.12)
            : cardColor,
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
  final Color cardColor;
  final Color secondCardColor;
  final Color textColor;
  final Color subTextColor;
  final Color borderColor;

  const _ProductCard({
    required this.product,
    required this.cardColor,
    required this.secondCardColor,
    required this.textColor,
    required this.subTextColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: borderColor,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              Theme.of(context).brightness == Brightness.dark ? 0.16 : 0.03,
            ),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
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

class _EmptyProductsView extends StatelessWidget {
  final Color cardColor;
  final Color textColor;
  final Color subTextColor;
  final Color borderColor;

  const _EmptyProductsView({
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
              Icons.search_off_rounded,
              size: 65,
              color: AppColors.darkGreen,
            ),
            const SizedBox(height: 14),
            Text(
              'No products found',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: textColor,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Try another category or search keyword.',
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