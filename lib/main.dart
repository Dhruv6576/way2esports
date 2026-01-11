import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'login_screen.dart';
import 'home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const TournamentApp());
}

class TournamentApp extends StatelessWidget {
  const TournamentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tournament App',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(
          0xFF140505,
        ), // Your background-dark
        primaryColor: const Color(0xFFff2b2b), // Your primary red
        textTheme: GoogleFonts.spaceGroteskTextTheme(
          Theme.of(context).textTheme.apply(bodyColor: Colors.white),
        ),
      ),
      home: const OnboardingScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // We get the screen size to make it responsive
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // 1. Background Image
          Positioned.fill(
            child: Image.network(
              // Placeholder gaming image. Replace with local asset when ready.
              'https://images.unsplash.com/photo-1542751371-adc38448a05e?q=80&w=2670&auto=format&fit=crop',
              fit: BoxFit.cover,
              color: const Color(0xFF140505).withOpacity(0.3), // Slight tint
              colorBlendMode: BlendMode.darken,
            ),
          ),

          // 2. Gradient Overlay (Top to Bottom fade)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.0, 0.4, 1.0],
                  colors: [
                    const Color(0xFF140505).withOpacity(0.3),
                    const Color(0xFF140505).withOpacity(0.6),
                    const Color(0xFF140505), // Solid background at bottom
                  ],
                ),
              ),
            ),
          ),

          // 3. The Red "Glow" Blur Effect
          Positioned(
            top: size.height * 0.25,
            left: size.width * 0.1,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFff2b2b).withOpacity(0.25),
                    blurRadius: 100,
                    spreadRadius: 20,
                  ),
                ],
              ),
            ),
          ),

          // 4. Content (Text and Buttons)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Title
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        height: 1.1,
                        color: Colors.white,
                      ),
                      children: [
                        const TextSpan(text: 'Join Daily \n'),
                        TextSpan(
                          text: 'Tournaments',
                          style: TextStyle(
                            color: const Color(0xFFff2b2b),
                            shadows: [
                              BoxShadow(
                                color: const Color(0xFFff2b2b).withOpacity(0.5),
                                blurRadius: 20,
                                offset: const Offset(0, 0),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Description
                  const Text(
                    'Compete in high-stakes Battle Royale events every day. Prove your skills and climb the global leaderboards.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Pagination Dots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Active Dot (Long)
                      Container(
                        width: 32,
                        height: 8,
                        decoration: BoxDecoration(
                          color: const Color(0xFFff2b2b),
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFff2b2b).withOpacity(0.6),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Inactive Dot 1
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Inactive Dot 2
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),

                  // Next Button
                  Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFff2b2b).withOpacity(0.4),
                          blurRadius: 20,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        // THIS IS THE NEW CODE TO NAVIGATE:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFff2b2b),
                        foregroundColor: const Color(0xFF140505), // Text color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "Next",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward_rounded, size: 24),
                        ],
                      ),
                    ),
                  ),

                  // Skip button section removed from here
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
