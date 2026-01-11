import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'services/firebase_auth_service.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;
  final String username;
  final String email;
  final String countryCode;

  const OtpScreen({
    required this.verificationId,
    required this.phoneNumber,
    required this.username,
    required this.email,
    required this.countryCode,
    super.key,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final FirebaseAuthService _authService = FirebaseAuthService();
  final List<TextEditingController> _otpControllers = List.generate(6, (_) => TextEditingController());
  
  bool _isLoading = false;
  String? _errorMessage;

  final Color primaryColor = const Color(0xFFf42525);
  final Color backgroundColor = const Color(0xFF120808);

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    super.dispose();
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
      print('=== OTP VERIFICATION DEBUG ===');
      print('Verification ID: ${widget.verificationId}');
      print('OTP Entered: $otp');
      print('Phone: ${widget.countryCode}${widget.phoneNumber}');
      print('==============================');
      
      // Verify OTP with Firebase
      await _authService.verifyOTP(widget.verificationId, otp);
      
      print('OTP Verification SUCCESS!');
      
      // Get current user
      var user = _authService.currentUser;
      if (user != null) {
        print('User authenticated: ${user.uid}');
        
        // Save user data
        await _authService.saveUserData(
          uid: user.uid,
          username: widget.username,
          phoneNumber: '${widget.countryCode}${widget.phoneNumber}',
          email: widget.email,
        );

        print('User data saved to Firestore');

        if (!mounted) return;
        
        // Navigate to home
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Error: ${e.code} - ${e.message}';
      });
      print('Firebase Auth Error Code: ${e.code}');
      print('Firebase Auth Error Message: ${e.message}');
      print('Firebase Auth Error Details: ${e.toString()}');
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Error: ${e.toString()}';
      });
      print('OTP Verification Error: $e');
      print('Error Type: ${e.runtimeType}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          // Background effects
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

          // Top-Left Blur
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

          // Bottom-Right Blur
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

          // Content
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo
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
                          ),
                        ],
                      ),
                      child: Center(
                        child: Icon(
                          Icons.lock_outline,
                          size: 50,
                          color: primaryColor,
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Heading
                    Text(
                      "Verify Phone",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          BoxShadow(
                            color: primaryColor.withOpacity(0.6),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Subheading
                    Text(
                      'Enter the 6-digit OTP sent to\n${widget.countryCode}${widget.phoneNumber}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 40),

                    // OTP Input Fields
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
                            border: Border.all(
                              color: Colors.white.withOpacity(0.1),
                            ),
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
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: const InputDecoration(
                              counterText: '',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Error Message
                    if (_errorMessage != null)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          border: Border.all(
                            color: Colors.red.withOpacity(0.5),
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _errorMessage!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      ),

                    const SizedBox(height: 32),

                    // Verify Button
                    Container(
                      width: double.infinity,
                      height: 56,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: primaryColor.withOpacity(0.5),
                            blurRadius: 15,
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _verifyOtp,
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
                            : const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'VERIFY OTP',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Icon(Icons.check_circle_outline, size: 20),
                                ],
                              ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Resend OTP
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Didn't receive OTP? ",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 12,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // TODO: Implement resend OTP
                            print("Resend OTP");
                          },
                          child: Text(
                            "Resend",
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}