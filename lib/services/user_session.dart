import 'package:shared_preferences/shared_preferences.dart';

class UserSession {
  static String registeredName = '';
  static String registeredEmail = '';
  static String registeredPhone = '';
  static String registeredPassword = '';

  // Default address removed
  static String registeredAddress = '';

  static bool isLoggedIn = false;

  static Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();

    registeredName = prefs.getString('name') ?? '';
    registeredEmail = prefs.getString('email') ?? '';
    registeredPhone = prefs.getString('phone') ?? '';
    registeredPassword = prefs.getString('password') ?? '';

    // Default Main Street address removed
    registeredAddress = prefs.getString('address') ?? '';

    isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  }

  static Future<void> registerUser({
    required String name,
    required String email,
    required String phone,
    required String password,
    String address = '',
  }) async {
    registeredName = name;
    registeredEmail = email;
    registeredPhone = phone;
    registeredPassword = password;
    registeredAddress = address;
    isLoggedIn = false;

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('name', name);
    await prefs.setString('email', email);
    await prefs.setString('phone', phone);
    await prefs.setString('password', password);
    await prefs.setString('address', address);
    await prefs.setBool('isLoggedIn', false);
  }

  static Future<bool> login({
    required String email,
    required String password,
  }) async {
    await loadUser();

    if (registeredEmail.isEmpty || registeredPassword.isEmpty) {
      return false;
    }

    if (email.trim().toLowerCase() == registeredEmail.trim().toLowerCase() &&
        password == registeredPassword) {
      isLoggedIn = true;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      return true;
    }

    return false;
  }

  static Future<void> logout() async {
    isLoggedIn = false;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
  }

  static Future<void> updateAddress(String newAddress) async {
    registeredAddress = newAddress;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('address', newAddress);
  }

  static Future<void> clearAddress() async {
    registeredAddress = '';

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('address');
  }

  static String get name => registeredName;
  static String get email => registeredEmail;
  static String get phone => registeredPhone;
  static String get address => registeredAddress;

  // HomeScreen-la UserSession.address = '...' nu use pannina error varaama irukka
  static set address(String newAddress) {
    registeredAddress = newAddress;
    _saveAddress(newAddress);
  }

  static Future<void> _saveAddress(String newAddress) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('address', newAddress);
  }
}