import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../services/user_session.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmPasswordCtrl = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _isLoading = false;

  String? _nameError;
  String? _emailError;
  String? _phoneError;
  String? _passwordError;
  String? _confirmError;

  late AnimationController _animCtrl;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();

    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fadeAnim = CurvedAnimation(
      parent: _animCtrl,
      curve: Curves.easeOut,
    );

    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.10),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animCtrl,
        curve: Curves.easeOutCubic,
      ),
    );

    _animCtrl.forward();
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmPasswordCtrl.dispose();
    super.dispose();
  }

  bool _validate() {
    setState(() {
      final name = _nameCtrl.text.trim();
      final email = _emailCtrl.text.trim();
      final phone = _phoneCtrl.text.trim();
      final password = _passwordCtrl.text;
      final confirmPassword = _confirmPasswordCtrl.text;

      _nameError = name.isEmpty ? 'Please enter your full name' : null;

      if (email.isEmpty) {
        _emailError = 'Please enter your email';
      } else if (!RegExp(r'^[\w\.\-]+@[\w\-]+\.\w{2,}$').hasMatch(email)) {
        _emailError = 'Enter a valid email address';
      } else {
        _emailError = null;
      }

      if (phone.isEmpty) {
        _phoneError = 'Please enter your phone number';
      } else if (!RegExp(r'^\+?[\d\s\-]{7,15}$').hasMatch(phone)) {
        _phoneError = 'Enter a valid phone number';
      } else {
        _phoneError = null;
      }

      if (password.isEmpty) {
        _passwordError = 'Please enter a password';
      } else if (password.length < 6) {
        _passwordError = 'Password must be at least 6 characters';
      } else {
        _passwordError = null;
      }

      if (confirmPassword.isEmpty) {
        _confirmError = 'Please confirm your password';
      } else if (confirmPassword != password) {
        _confirmError = 'Passwords do not match';
      } else {
        _confirmError = null;
      }
    });

    return _nameError == null &&
        _emailError == null &&
        _phoneError == null &&
        _passwordError == null &&
        _confirmError == null;
  }

  Future<void> _onSignUp() async {
    if (!_validate()) return;

    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    await UserSession.registerUser(
      name: _nameCtrl.text.trim(),
      email: _emailCtrl.text.trim(),
      phone: _phoneCtrl.text.trim(),
      password: _passwordCtrl.text,
    );

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Account created successfully. Please login.'),
        backgroundColor: AppColors.darkGreen,
      ),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  void _goToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  void _goBack() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      _goToLogin();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5FBFF),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnim,
          child: SlideTransition(
            position: _slideAnim,
            child: Column(
              children: [
                const SizedBox(height: 16),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: _goBack,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFE8E8E8)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.06),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          size: 17,
                          color: AppColors.textDark,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Container(
                  height: 70,
                  width: 170,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFE0F2FE),
                        Color(0xFF38BDF8),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryGreen.withOpacity(0.35),
                        blurRadius: 14,
                        offset: const Offset(0, 7),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFDFDFD),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(26),
                        topRight: Radius.circular(26),
                      ),
                      border: Border(
                        top: BorderSide(
                          color: AppColors.primaryGreen,
                          width: 1.3,
                        ),
                      ),
                    ),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _AuthTextField(
                            controller: _nameCtrl,
                            hintText: 'Full Name',
                            icon: Icons.person_outline,
                            errorText: _nameError,
                            inputType: TextInputType.name,
                            onChanged: (_) {
                              setState(() {
                                _nameError = null;
                              });
                            },
                          ),

                          const SizedBox(height: 16),

                          _AuthTextField(
                            controller: _emailCtrl,
                            hintText: 'Email',
                            icon: Icons.email_outlined,
                            errorText: _emailError,
                            inputType: TextInputType.emailAddress,
                            onChanged: (_) {
                              setState(() {
                                _emailError = null;
                              });
                            },
                          ),

                          const SizedBox(height: 16),

                          _AuthTextField(
                            controller: _phoneCtrl,
                            hintText: 'Phone Number',
                            icon: Icons.phone_outlined,
                            errorText: _phoneError,
                            inputType: TextInputType.phone,
                            onChanged: (_) {
                              setState(() {
                                _phoneError = null;
                              });
                            },
                          ),

                          const SizedBox(height: 16),

                          _AuthTextField(
                            controller: _passwordCtrl,
                            hintText: 'Password',
                            icon: Icons.lock_outline,
                            errorText: _passwordError,
                            isPassword: true,
                            obscure: _obscurePassword,
                            onToggleObscure: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                            onChanged: (_) {
                              setState(() {
                                _passwordError = null;
                              });
                            },
                          ),

                          const SizedBox(height: 16),

                          _AuthTextField(
                            controller: _confirmPasswordCtrl,
                            hintText: 'Confirm Password',
                            icon: Icons.lock_outline,
                            errorText: _confirmError,
                            isPassword: true,
                            obscure: _obscureConfirm,
                            onToggleObscure: () {
                              setState(() {
                                _obscureConfirm = !_obscureConfirm;
                              });
                            },
                            onChanged: (_) {
                              setState(() {
                                _confirmError = null;
                              });
                            },
                          ),

                          const SizedBox(height: 28),

                          SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.darkGreen,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: _isLoading ? null : _onSignUp,
                              child: _isLoading
                                  ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.5,
                                ),
                              )
                                  : const Text(
                                'Create Account',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              _Dot(),
                              _Dot(),
                              _Dot(isActive: true),
                              _Dot(),
                            ],
                          ),

                          const SizedBox(height: 14),

                          Center(
                            child: TextButton(
                              onPressed: _goToLogin,
                              child: RichText(
                                text: const TextSpan(
                                  text: 'Already have an account? ',
                                  style: TextStyle(
                                    color: AppColors.textGrey,
                                    fontSize: 13,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'Log In',
                                      style: TextStyle(
                                        color: AppColors.darkGreen,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
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

class _AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final String? errorText;
  final bool isPassword;
  final bool obscure;
  final VoidCallback? onToggleObscure;
  final TextInputType inputType;
  final ValueChanged<String>? onChanged;

  const _AuthTextField({
    required this.controller,
    required this.hintText,
    required this.icon,
    this.errorText,
    this.isPassword = false,
    this.obscure = false,
    this.onToggleObscure,
    this.inputType = TextInputType.text,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          obscureText: isPassword ? obscure : false,
          keyboardType: inputType,
          onChanged: onChanged,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.textDark,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              color: Color(0xFFBBBBBB),
              fontSize: 14,
            ),
            prefixIcon: Icon(
              icon,
              size: 20,
              color: errorText != null
                  ? Colors.red.shade400
                  : AppColors.primaryGreen,
            ),
            suffixIcon: isPassword
                ? IconButton(
              icon: Icon(
                obscure
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                size: 20,
                color: AppColors.textGrey,
              ),
              onPressed: onToggleObscure,
            )
                : null,
            filled: true,
            fillColor: errorText != null ? Colors.red.shade50 : Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFFD8D8D8)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: errorText != null
                    ? Colors.red.shade300
                    : const Color(0xFFD8D8D8),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: errorText != null
                    ? Colors.red.shade400
                    : AppColors.primaryGreen,
                width: 1.6,
              ),
            ),
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              errorText!,
              style: TextStyle(
                fontSize: 11,
                color: Colors.red.shade500,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _Dot extends StatelessWidget {
  final bool isActive;

  const _Dot({this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isActive ? 20 : 6,
      height: 6,
      margin: const EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primaryGreen : Colors.black12,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}