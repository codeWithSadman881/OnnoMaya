import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'home_screen.dart';
import 'volunteer_dashboard_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  
  // Donor specific controllers
  final _orgNameController = TextEditingController();
  final _addressController = TextEditingController();
  
  // Volunteer specific controller
  final _prefAreaController = TextEditingController();

  String _selectedRole = 'donor'; // 'donor' or 'volunteer'
  String _selectedDonorType = 'Individual'; // 'Individual', 'Restaurant / Hotel', 'Event Organizer'
  
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _orgNameController.dispose();
    _addressController.dispose();
    _prefAreaController.dispose();
    super.dispose();
  }

  Future<void> _handleSignup() async {
    if (_nameController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty ||
        _phoneController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("অনুগ্রহ করে সকল প্রয়োজনীয় তথ্য সঠিকভাবে দিন!"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      String displayName = _nameController.text.trim();
      if (_selectedRole == 'donor' && _selectedDonorType != 'Individual' && _orgNameController.text.trim().isNotEmpty) {
        displayName = "${_nameController.text.trim()} (${_orgNameController.text.trim()})";
      }

      // Firebase-এর মাধ্যমে সাইন-আপ এবং ডেটাবেজে সেভ করা
      await _authService.signUpWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        name: displayName,
        phone: _phoneController.text.trim(),
        role: _selectedRole,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("একাউন্ট সফলভাবে তৈরি হয়েছে! 🎉"),
          backgroundColor: Colors.green,
        ),
      );

      Widget destination = _selectedRole == 'volunteer'
          ? const VolunteerDashboardScreen()
          : const HomeScreen();

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => destination),
        (route) => false,
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("সাইন-আপ ব্যর্থ হয়েছে: ${e.toString()}"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.person_add_alt_1_rounded,
                size: 70,
                color: Colors.orange,
              ),
              const SizedBox(height: 12),
              const Text(
                "Create an Account",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                "Join OnnoMaya community today",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 24),

              // Register As Chips
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Register As:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: ChoiceChip(
                      label: const Text("Donor"),
                      selected: _selectedRole == 'donor',
                      selectedColor: Colors.orange.shade100,
                      onSelected: (selected) {
                        setState(() => _selectedRole = 'donor');
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ChoiceChip(
                      label: const Text("Volunteer"),
                      selected: _selectedRole == 'volunteer',
                      selectedColor: Colors.green.shade100,
                      onSelected: (selected) {
                        setState(() => _selectedRole = 'volunteer');
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Common Fields
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Full Name *",
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: "Phone Number *",
                  prefixIcon: Icon(Icons.phone_outlined),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "Email Address *",
                  prefixIcon: Icon(Icons.email_outlined),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password *",
                  prefixIcon: Icon(Icons.lock_outline),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Donor Conditional Fields
              if (_selectedRole == 'donor') ...[
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Donor Type:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: _selectedDonorType,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.category_outlined),
                    border: OutlineInputBorder(),
                  ),
                  items: ['Individual', 'Restaurant / Hotel', 'Event Organizer']
                      .map((type) => DropdownMenuItem(
                            value: type,
                            child: Text(type),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _selectedDonorType = value);
                    }
                  },
                ),
                const SizedBox(height: 12),

                if (_selectedDonorType != 'Individual') ...[
                  TextField(
                    controller: _orgNameController,
                    decoration: const InputDecoration(
                      labelText: "Organization / Restaurant Name",
                      prefixIcon: Icon(Icons.storefront_outlined),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],

                TextField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                    labelText: "Primary Pickup Area / Address",
                    prefixIcon: Icon(Icons.location_on_outlined),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // Volunteer Conditional Fields
              if (_selectedRole == 'volunteer') ...[
                TextField(
                  controller: _prefAreaController,
                  decoration: const InputDecoration(
                    labelText: "Preferred Delivery Area (e.g. Uttara, Dhanmondi)",
                    prefixIcon: Icon(Icons.map_outlined),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // Sign Up Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: _isLoading ? null : _handleSignup,
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "Sign Up",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                ),
              ),
              const SizedBox(height: 12),

              // Login Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
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
  }
}