import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'registration_screen.dart';
import 'home_screen.dart';
import 'services/firebase_auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuthService _authService = FirebaseAuthService();
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _handleGoogleSignIn() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Check if user is already authenticated in Firebase
      User? currentUser = _authService.currentUser;
      
      if (currentUser != null) {
        // User already authenticated, check if they exist in database
        bool userExists = await _authService.userExists(currentUser.uid);
        
        if (!mounted) return;
        setState(() {
          _isLoading = false;
        });
        
        if (userExists) {
          // Existing user, go to home
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        } else {
          // New user, go to registration
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RegistrationScreen(
                phoneNumber: currentUser.phoneNumber ?? '',
                email: currentUser.email ?? '',
              ),
            ),
          );
        }
        return;
      }

      // No current user, perform Google sign-in with account picker
      UserCredential? userCredential = await _authService.signInWithGoogle();
      
      if (userCredential == null) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Google Sign-In cancelled';
        });
        return;
      }

      // Check if user exists in database
      bool userExists = await _authService.userExists(userCredential.user!.uid);

      if (!mounted) return;
      
      setState(() {
        _isLoading = false;
      });

      if (userExists) {
        // User exists, go to home
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      } else {
        // New user, go to registration
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RegistrationScreen(
              phoneNumber: userCredential.user?.phoneNumber ?? '',
              email: userCredential.user?.email ?? '',
            ),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Sign-In Error: ${e.toString()}';
      });
      print('Google Sign-In Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Theme Colors
    final primaryColor = const Color(0xFFf42525);
    final backgroundColor = const Color(0xFF120808);

    return Scaffold(
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // ------------------------------------------------
          // LAYER 1: BACKGROUND EFFECTS
          // ------------------------------------------------
          
          // 1. Top Left Blur
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primaryColor.withOpacity(0.05),
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.05),
                    blurRadius: 100,
                    spreadRadius: 50,
                  ),
                ],
              ),
            ),
          ),

          // 2. Bottom Right Blur
          Positioned(
            bottom: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primaryColor.withOpacity(0.05),
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.05),
                    blurRadius: 100,
                    spreadRadius: 50,
                  ),
                ],
              ),
            ),
          ),

          // 3. Corner Decorative Borders
          // Top Left
          Positioned(
            top: 20,
            left: 20,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: primaryColor.withOpacity(0.2), width: 2),
                  left: BorderSide(color: primaryColor.withOpacity(0.2), width: 2),
                ),
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(24)),
              ),
            ),
          ),
          // Bottom Right
          Positioned(
            bottom: 20,
            right: 20,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: primaryColor.withOpacity(0.2), width: 2),
                  right: BorderSide(color: primaryColor.withOpacity(0.2), width: 2),
                ),
                borderRadius: const BorderRadius.only(bottomRight: Radius.circular(24)),
              ),
            ),
          ),

          // ------------------------------------------------
          // LAYER 2: CONTENT
          // ------------------------------------------------
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // --- LOGO SECTION ---
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: primaryColor.withOpacity(0.3), width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: primaryColor.withOpacity(0.4),
                            blurRadius: 20,
                            spreadRadius: -5,
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.shield_outlined,
                        size: 50,
                        color: primaryColor,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // --- HEADINGS ---
                    Text(
                      "Welcome Player",
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          BoxShadow(
                            color: primaryColor.withOpacity(0.6),
                            blurRadius: 20,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Enter the arena and start competing",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // --- GOOGLE SIGN IN BUTTON ---
                    Container(
                      width: double.infinity,
                      height: 56,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: primaryColor.withOpacity(0.4),
                            blurRadius: 15,
                            offset: const Offset(0, 0),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _handleGoogleSignIn,
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
                                children: const [
                                  Text(
                                    "CONTINUE WITH GOOGLE",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.0,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Icon(Icons.login, size: 22),
                                ],
                              ),
                      ),
                    ),

                    // Error Message
                    if (_errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                    const SizedBox(height: 40),

                    // --- FOOTER ---
                    Column(
                      children: [
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
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                "Terms of Service",
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.6),
                                  fontSize: 12,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                            Text(
                              " and ",
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.3),
                                fontSize: 12,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                "Privacy Policy",
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.6),
                                  fontSize: 12,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Guest Mode Button (Top Right)
          Positioned(
            top: 40,
            right: 24,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
              child: Text(
                "Guest Mode",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}