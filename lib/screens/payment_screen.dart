import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/app_colors.dart';
import 'success_screen.dart';

class PaymentScreen extends StatefulWidget {
  final String totalAmount;

  const PaymentScreen({
    super.key,
    required this.totalAmount,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen>
    with TickerProviderStateMixin {
  String _selectedCard = 'visa';
  String _selectedMonth = '';
  String _selectedYear = '';
  bool _isLoading = false;

  late AnimationController _fadeCtrl;
  late AnimationController _slideCtrl;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  final _cardNumberCtrl = TextEditingController();
  final _cvnCtrl = TextEditingController();
  final _nameCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fadeCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _slideCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _fadeAnim = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideCtrl, curve: Curves.easeOutCubic));

    _fadeCtrl.forward();
    _slideCtrl.forward();
  }

  @override
  void dispose() {
    _fadeCtrl.dispose();
    _slideCtrl.dispose();
    _cardNumberCtrl.dispose();
    _cvnCtrl.dispose();
    _nameCtrl.dispose();
    super.dispose();
  }

  Future<void> _placeOrder() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isLoading = false);
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const SuccessScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreen,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 430),
          child: SafeArea(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFE0F2FE), // AppColors.lightGreen
                    Color(0xFFD0F0E2),
                    Color(0xFF38BDF8), // AppColors.primaryGreen
                    Color(0xFF0284C7), // AppColors.darkGreen
                  ],
                  stops: [0.0, 0.28, 0.68, 1.0],
                ),
              ),
              child: FadeTransition(
                opacity: _fadeAnim,
                child: SlideTransition(
                  position: _slideAnim,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader(context),
                        const SizedBox(height: 20),
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                _buildCardSelector(),
                                const SizedBox(height: 16),
                                _buildCardForm(),
                                const SizedBox(height: 16),
                                _buildTotalRow(),
                                const SizedBox(height: 20),
                                _buildPlaceOrderButton(),
                                const SizedBox(height: 24),
                                _buildDots(),
                                const SizedBox(height: 8),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ── Header ──────────────────────────────────────────────────────────────────
  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.maybePop(context),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.35),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.arrow_back_ios_new,
                size: 18, color: AppColors.textDark),
          ),
        ),
        const Expanded(
          child: Center(
            child: Text(
              'Payment',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppColors.textDark,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.35),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.lock_outline,
              size: 18, color: AppColors.textDark),
        ),
      ],
    );
  }

  // ── Card Selector ────────────────────────────────────────────────────────────
  Widget _buildCardSelector() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.88),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkGreen.withOpacity(0.10),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'SELECT CARD TYPE',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppColors.textGrey,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _CardTypeOption(
                  isSelected: _selectedCard == 'visa',
                  onTap: () => setState(() => _selectedCard = 'visa'),
                  logo: const _VisaLogo(),
                  label: 'Visa',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _CardTypeOption(
                  isSelected: _selectedCard == 'mastercard',
                  onTap: () => setState(() => _selectedCard = 'mastercard'),
                  logo: const _MastercardLogo(),
                  label: 'Mastercard',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Card Form ────────────────────────────────────────────────────────────────
  Widget _buildCardForm() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.92),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkGreen.withOpacity(0.10),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMiniCard(),
          const SizedBox(height: 20),
          const Divider(height: 1, color: Color(0xFFEEF8F3)),
          const SizedBox(height: 18),

          _label('Card Number'),
          const SizedBox(height: 8),
          _buildCardNumberField(),

          const SizedBox(height: 14),

          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _label('Expiry Month'),
                    const SizedBox(height: 8),
                    _buildDropdown(
                      value: _selectedMonth,
                      hint: 'Month',
                      items: List.generate(
                          12, (i) => (i + 1).toString().padLeft(2, '0')),
                      onChanged: (v) => setState(() => _selectedMonth = v!),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _label('Expiry Year'),
                    const SizedBox(height: 8),
                    _buildDropdown(
                      value: _selectedYear,
                      hint: 'Year',
                      items: List.generate(
                          10, (i) => (DateTime.now().year + i).toString()),
                      onChanged: (v) => setState(() => _selectedYear = v!),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _label('CVN / CVV'),
                    const SizedBox(height: 8),
                    _buildTextField(
                      controller: _cvnCtrl,
                      hint: '• • •',
                      icon: Icons.security_outlined,
                      inputType: TextInputType.number,
                      obscure: true,
                      maxLength: 3,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _label('Cardholder Name'),
                    const SizedBox(height: 8),
                    _buildTextField(
                      controller: _nameCtrl,
                      hint: 'Full Name',
                      icon: Icons.person_outline,
                      inputType: TextInputType.name,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Mini Card Preview ────────────────────────────────────────────────────────
  Widget _buildMiniCard() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: double.infinity,
      height: 82,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(
          colors: _selectedCard == 'visa'
              ? [const Color(0xFF1A1F71), const Color(0xFF2E3BA8)]
              : [const Color(0xFF1D1D1B), const Color(0xFF3A3A3A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: (_selectedCard == 'visa'
                ? const Color(0xFF1A1F71)
                : const Color(0xFF1D1D1B))
                .withOpacity(0.45),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                    () {
                  final raw = _cardNumberCtrl.text.replaceAll(' ', '');
                  final last4 = raw.length >= 4
                      ? raw.substring(raw.length - 4)
                      : raw.padLeft(4, '0');
                  return '**** **** **** $last4';
                }(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(height: 6),
              Text(
                _selectedMonth.isNotEmpty && _selectedYear.isNotEmpty
                    ? '$_selectedMonth / ${_selectedYear.substring(2)}'
                    : 'MM / YY',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.65),
                  fontSize: 11,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          _selectedCard == 'visa'
              ? const _VisaLogo(onDark: true)
              : const _MastercardLogo(),
        ],
      ),
    );
  }

  // ── Total Row ────────────────────────────────────────────────────────────────
  Widget _buildTotalRow() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.92),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primaryGreen.withOpacity(0.45),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryGreen.withOpacity(0.14),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.lightGreen,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.receipt_long_outlined,
                    size: 18, color: AppColors.darkGreen),
              ),
              const SizedBox(width: 10),
              const Text(
                'Total Order',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
          Text(
            widget.totalAmount,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: AppColors.darkGreen,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }

  // ── Place Order Button ────────────────────────────────────────────────────────
  Widget _buildPlaceOrderButton() {
    return GestureDetector(
      onTap: _isLoading ? null : _placeOrder,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _isLoading
                ? [const Color(0xFFF59050), AppColors.orange]
                : [const Color(0xFFFF7A35), AppColors.orange],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.orange.withOpacity(0.40),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Center(
          child: _isLoading
              ? const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2.5,
            ),
          )
              : const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.lock_open_outlined,
                  color: Colors.white, size: 18),
              SizedBox(width: 8),
              Text(
                'Place Order',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Progress Dots ────────────────────────────────────────────────────────────
  Widget _buildDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(8, (i) {
        final isActive = i == 5;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: isActive ? 22 : 6,
          height: 6,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
            color: isActive
                ? AppColors.primaryGreen
                : Colors.white.withOpacity(0.55),
            borderRadius: BorderRadius.circular(3),
          ),
        );
      }),
    );
  }

  // ── Helpers ──────────────────────────────────────────────────────────────────
  Widget _label(String text) => Text(
    text,
    style: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w700,
      color: AppColors.textGrey,
      letterSpacing: 0.4,
    ),
  );

  // ── Card Number Field (4-4-4-4 format, digits only) ─────────────────────────
  Widget _buildCardNumberField() {
    return TextField(
      controller: _cardNumberCtrl,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        _CardNumberFormatter(),
      ],
      onChanged: (_) => setState(() {}),
      style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.textDark,
          letterSpacing: 2),
      decoration: InputDecoration(
        hintText: '**** **** **** 0000',
        hintStyle: const TextStyle(color: Color(0xFFAAAAAA), fontSize: 13),
        prefixIcon:
        const Icon(Icons.credit_card_outlined, size: 18, color: AppColors.primaryGreen),
        filled: true,
        fillColor: AppColors.lightGreen,
        counterText: '',
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
          BorderSide(color: AppColors.primaryGreen.withOpacity(0.25)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
          BorderSide(color: AppColors.primaryGreen.withOpacity(0.25)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
          const BorderSide(color: AppColors.primaryGreen, width: 1.8),
        ),
      ),
    );
  }

  Widget _buildTextField({
    TextEditingController? controller,
    required String hint,
    required IconData icon,
    TextInputType inputType = TextInputType.text,
    bool obscure = false,
    int? maxLength,
  }) {
    return TextField(
      controller: controller,
      keyboardType: inputType,
      obscureText: obscure,
      maxLength: maxLength,
      style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AppColors.textDark),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle:
        const TextStyle(color: Color(0xFFAAAAAA), fontSize: 13),
        prefixIcon: Icon(icon, size: 18, color: AppColors.primaryGreen),
        filled: true,
        fillColor: AppColors.lightGreen,
        counterText: '',
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
              color: AppColors.primaryGreen.withOpacity(0.25)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
              color: AppColors.primaryGreen.withOpacity(0.25)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
              color: AppColors.primaryGreen, width: 1.8),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String value,
    required String hint,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      height: 46,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.lightGreen,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            color: AppColors.primaryGreen.withOpacity(0.25), width: 1),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value.isEmpty ? null : value,
          hint: Text(hint,
              style: const TextStyle(
                  color: Color(0xFFAAAAAA),
                  fontSize: 13,
                  fontWeight: FontWeight.w500)),
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down,
              size: 20, color: AppColors.primaryGreen),
          style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark),
          items: items
              .map((v) => DropdownMenuItem(value: v, child: Text(v)))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

// ── Card Type Option ──────────────────────────────────────────────────────────
class _CardTypeOption extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;
  final Widget logo;
  final String label;

  const _CardTypeOption({
    required this.isSelected,
    required this.onTap,
    required this.logo,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        padding:
        const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.lightGreen
              : const Color(0xFFF8F8F8),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryGreen
                : const Color(0xFFE0E0E0),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: AppColors.primaryGreen.withOpacity(0.18),
              blurRadius: 12,
              offset: const Offset(0, 4),
            )
          ]
              : [],
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? AppColors.primaryGreen
                      : Colors.grey.shade400,
                  width: 2,
                ),
                color: isSelected
                    ? AppColors.primaryGreen
                    : Colors.transparent,
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 11, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 8),
            logo,
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: isSelected
                    ? AppColors.darkGreen
                    : AppColors.textDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Visa Logo ─────────────────────────────────────────────────────────────────
class _VisaLogo extends StatelessWidget {
  final bool onDark;
  const _VisaLogo({this.onDark = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 24,
      decoration: BoxDecoration(
        color: onDark
            ? Colors.white.withOpacity(0.15)
            : const Color(0xFF1A1F71),
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Center(
        child: Text(
          'VISA',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            fontStyle: FontStyle.italic,
            letterSpacing: 1.5,
          ),
        ),
      ),
    );
  }
}

// ── Mastercard Logo ───────────────────────────────────────────────────────────
class _MastercardLogo extends StatelessWidget {
  const _MastercardLogo();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 36,
      height: 22,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 0,
            child: Container(
              width: 22,
              height: 22,
              decoration: const BoxDecoration(
                color: Color(0xFFEB001B),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: const Color(0xFFF79E1B).withOpacity(0.92),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Card Number Formatter (1234 5678 9012 3456) ───────────────────────────────
class _CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Only digits, max 16
    final digits = newValue.text.replaceAll(' ', '');
    if (digits.length > 16) return oldValue;

    // Insert space every 4 digits
    final buffer = StringBuffer();
    for (int i = 0; i < digits.length; i++) {
      if (i > 0 && i % 4 == 0) buffer.write(' ');
      buffer.write(digits[i]);
    }

    final formatted = buffer.toString();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}