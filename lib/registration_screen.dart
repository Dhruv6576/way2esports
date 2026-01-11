import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'services/firebase_auth_service.dart';
import 'otp_screen.dart';

class RegistrationScreen extends StatefulWidget {
  final String phoneNumber;
  final String email;

  const RegistrationScreen({
    required this.phoneNumber,
    required this.email,
    super.key,
  });

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final FirebaseAuthService _authService = FirebaseAuthService();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final List<TextEditingController> _otpControllers = List.generate(6, (_) => TextEditingController());
  
  bool _isLoading = false;
  bool _phoneVerified = false;
  bool _showOtpInput = false;
  String? _errorMessage;
  String _verificationId = '';
  String _selectedCountryCode = '+91'; // Default to India

  // Colors from your design
  final Color primaryColor = const Color(0xFFf42525);
  final Color backgroundColor = const Color(0xFF120808);

  // Country codes list
  final List<String> _countryCodes = [
    '+1',    // USA
    '+44',   // UK
    '+91',   // India
    '+86',   // China
    '+81',   // Japan
    '+33',   // France
    '+49',   // Germany
    '+39',   // Italy
    '+34',   // Spain
    '+61',   // Australia
  ];

  @override
  void initState() {
    super.initState();
    // Initialize email controller with passed email
    _emailController.text = widget.email;
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _sendPhoneOtp() async {
    String phone = _phoneController.text.trim();

    if (phone.isEmpty || phone.length < 10) {
      setState(() => _errorMessage = 'Please enter valid phone number');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Combine country code with phone number
      String fullPhoneNumber = '$_selectedCountryCode$phone';
      
      // Check if phone number is already registered
      bool phoneExists = await _authService.phoneNumberExists(fullPhoneNumber);
      if (phoneExists) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Phone number is already registered';
        });
        return;
      }
      
      await _authService.verifyPhoneNumber(
        fullPhoneNumber,
        onCodeSent: (verificationId) {
          setState(() {
            _isLoading = false;
          });
          
          // Navigate to OTP screen with verification details
          if (mounted) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OtpScreen(
                  verificationId: verificationId,
                  phoneNumber: phone,
                  username: _usernameController.text,
                  email: _emailController.text,
                  countryCode: _selectedCountryCode,
                ),
              ),
            );
          }
        },
        onError: (error) {
          setState(() {
            _isLoading = false;
            _errorMessage = 'Error: ${error.message}';
          });
        },
        onCodeAutoRetrievalTimeout: (verificationId) {
          // Auto-retrieve timeout - user needs to manually enter OTP
          print('Auto-retrieval timeout: $verificationId');
        },
      );
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Error: ${e.toString()}';
      });
    }
  }

  Future<void> _verifyOtp() async {
    String otp = _otpControllers.map((c) => c.text).join();

    if (otp.length < 6) {
      setState(() => _errorMessage = 'Please enter complete OTP');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await _authService.verifyOTP(_verificationId, otp);
      setState(() {
        _isLoading = false;
        _phoneVerified = true;
        _showOtpInput = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Invalid OTP: ${e.toString()}';
      });
    }
  }

  Future<void> _completeRegistration() async {
    String username = _usernameController.text.trim();
    String email = _emailController.text.trim();
    String phone = _phoneController.text.trim();

    if (username.isEmpty) {
      setState(() => _errorMessage = 'Please enter username');
      return;
    }

    if (email.isEmpty || !email.contains('@')) {
      setState(() => _errorMessage = 'Please enter valid email');
      return;
    }

    if (!_phoneVerified) {
      setState(() => _errorMessage = 'Please verify your phone number');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      User? user = _authService.currentUser;
      if (user != null) {
        // Save user data with complete phone number (including country code)
        await _authService.saveUserData(
          uid: user.uid,
          username: username,
          phoneNumber: '$_selectedCountryCode$phone',
          email: email,
        );

        if (!mounted) return;
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Error: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Screen size for responsive background
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          // ------------------------------------------------
          // LAYER 1: BACKGROUND EFFECTS (The "Cyber Smoke")
          // ------------------------------------------------
          
          // 1. Center Red Glow (Radial Gradient simulation)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.0,
                  colors: [
                    primaryColor.withOpacity(0.1),
                    backgroundColor.withOpacity(0.0),
                  ],
                  stops: const [0.0, 0.7],
                ),
              ),
            ),
          ),

          // 2. Top-Left Blur Blob
          Positioned(
            top: -size.height * 0.1,
            left: -size.width * 0.1,
            child: Container(
              width: size.width * 0.4,
              height: size.width * 0.4,
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.05),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.05),
                    blurRadius: 100,
                    spreadRadius: 20,
                  ),
                ],
              ),
            ),
          ),

          // 3. Bottom-Right Blur Blob
          Positioned(
            bottom: -size.height * 0.1,
            right: -size.width * 0.1,
            child: Container(
              width: size.width * 0.4,
              height: size.width * 0.4,
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.05),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.05),
                    blurRadius: 100,
                    spreadRadius: 20,
                  ),
                ],
              ),
            ),
          ),

          // 4. Decorative Corner Accents
          // Top-Left Corner
          Positioned(
            top: 20,
            left: 20,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(24)),
                border: Border(
                  top: BorderSide(color: primaryColor.withOpacity(0.2), width: 2),
                  left: BorderSide(color: primaryColor.withOpacity(0.2), width: 2),
                ),
              ),
            ),
          ),
          // Bottom-Right Corner
          Positioned(
            bottom: 20,
            right: 20,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(bottomRight: Radius.circular(24)),
                border: Border(
                  bottom: BorderSide(color: primaryColor.withOpacity(0.2), width: 2),
                  right: BorderSide(color: primaryColor.withOpacity(0.2), width: 2),
                ),
              ),
            ),
          ),

          // ------------------------------------------------
          // LAYER 2: CONTENT
          // ------------------------------------------------
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                children: [
                  // Guest Mode Button (Top Right)
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // Navigate to Home as Guest
                        print("Guest Mode Clicked");
                      },
                      child: Text(
                        "Guest Mode",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // App Logo Section
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: primaryColor.withOpacity(0.3),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: primaryColor.withOpacity(0.5),
                          blurRadius: 15,
                          spreadRadius: 0,
                        ),
                        BoxShadow(
                          color: primaryColor.withOpacity(0.3),
                          blurRadius: 5,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Center(
                      // Using 'swords' icon alternative since standard Material doesn't have exact 'swords'
                      // You can use a custom asset image here if you prefer
                      child: Icon(
                        Icons.shield, // Changed to Shield/Arena theme
                        size: 50,
                        color: primaryColor,
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Heading
                  Text(
                    "Welcome Player",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.1,
                      shadows: [
                        BoxShadow(
                          color: primaryColor.withOpacity(0.6),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Enter the arena and start competing",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 40),

                  // --- FORM CONTAINER ---
                  
                  // Username Field
                  _buildLabel("Username"),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white.withOpacity(0.1)),
                    ),
                    child: TextField(
                      controller: _usernameController,
                      style: const TextStyle(color: Colors.white),
                      cursorColor: primaryColor,
                      decoration: InputDecoration(
                        hintText: "Ghost_Warrior_07",
                        hintStyle: TextStyle(color: Colors.white.withOpacity(0.2)),
                        prefixIcon: Icon(Icons.person_outline, color: Colors.white.withOpacity(0.4)),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Email Field (Read-only from Google account)
                  _buildLabel("Email Address"),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white.withOpacity(0.1)),
                    ),
                    child: TextField(
                      controller: _emailController,
                      enabled: false,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "player@example.com",
                        hintStyle: TextStyle(color: Colors.white.withOpacity(0.2)),
                        prefixIcon: Icon(Icons.email_outlined, color: Colors.white.withOpacity(0.4)),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Phone Number Field with Country Code (Editable with OTP Verification)
                  _buildLabel("Phone Number"),
                  Row(
                    children: [
                        // Country Code Dropdown
                        Expanded(
                          flex: 2,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.white.withOpacity(0.1)),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _selectedCountryCode,
                                isExpanded: true,
                                dropdownColor: backgroundColor,
                                items: _countryCodes.map((code) {
                                  return DropdownMenuItem(
                                    value: code,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 12),
                                      child: Text(
                                        code,
                                        style: const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value != null && !_showOtpInput && !_phoneVerified) {
                                  setState(() => _selectedCountryCode = value);
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Phone Number Input
                      Expanded(
                        flex: 3,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: _phoneVerified 
                                ? const Color(0xFF00FF00).withOpacity(0.5)
                                : Colors.white.withOpacity(0.1),
                            ),
                          ),
                          child: TextField(
                            controller: _phoneController,
                            enabled: !_phoneVerified && !_showOtpInput,
                            style: const TextStyle(color: Colors.white),
                            cursorColor: primaryColor,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              hintText: "98765 43210",
                              hintStyle: TextStyle(color: Colors.white.withOpacity(0.2)),
                              prefixIcon: Icon(Icons.phone_outlined, color: Colors.white.withOpacity(0.4)),
                              suffixIcon: _phoneVerified 
                                ? Icon(Icons.check_circle, color: const Color(0xFF00FF00))
                                : null,
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // OTP Input Fields
                  if (_showOtpInput)
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel("Enter OTP"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(
                              6,
                              (index) => Container(
                                width: 50,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.white.withOpacity(0.1)),
                                ),
                                child: TextField(
                                  controller: _otpControllers[index],
                                  onChanged: (value) {
                                    if (value.length == 1 && index < 5) {
                                      FocusScope.of(context).nextFocus();
                                    } else if (value.isEmpty && index > 0) {
                                      FocusScope.of(context).previousFocus();
                                    }
                                  },
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  maxLength: 1,
                                  style: const TextStyle(color: Colors.white, fontSize: 20),
                                  decoration: const InputDecoration(
                                    counterText: '',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: SizedBox(
                              width: double.infinity,
                              height: 44,
                              child: ElevatedButton(
                                onPressed: _isLoading ? null : _verifyOtp,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: _isLoading
                                    ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : const Text('Verify OTP'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  if (_errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),

                  const SizedBox(height: 32),

                  // Main Action Button (SEND OTP or COMPLETE REGISTRATION)
                  Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: primaryColor.withOpacity(0.5),
                          blurRadius: 15,
                          spreadRadius: 0,
                        ),
                        BoxShadow(
                          color: primaryColor.withOpacity(0.3),
                          blurRadius: 5,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: _isLoading 
                          ? null 
                          : (_phoneVerified ? _completeRegistration : _sendPhoneOtp),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _phoneVerified ? "COMPLETE REGISTRATION" : "SEND OTP",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Icon(
                                  _phoneVerified ? Icons.arrow_forward : Icons.send,
                                  size: 20,
                                ),
                              ],
                            ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Footer Terms
                  Text(
                    "By signing up, you agree to our",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.3),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildLinkText("Terms of Service"),
                      Text(
                        " and ",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.3),
                          fontSize: 12,
                        ),
                      ),
                      _buildLinkText("Privacy Policy"),
                    ],
                  ),
                  const SizedBox(height: 20), // Bottom spacing
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget for form labels
  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 4, bottom: 8),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  // Helper widget for footer links
  Widget _buildLinkText(String text) {
    return GestureDetector(
      onTap: () {},
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white.withOpacity(0.6),
          fontSize: 12,
          decoration: TextDecoration.underline,
          decorationColor: const Color(0xFFf42525).withOpacity(0.3),
        ),
      ),
    );
  }
}