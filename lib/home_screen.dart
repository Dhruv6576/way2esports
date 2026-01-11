import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'services/firebase_auth_service.dart';
import 'free_fire_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuthService _authService = FirebaseAuthService();
  int selectedNavIndex = 0;

  Future<void> _signOut() async {
    try {
      await _authService.signOut();
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error signing out: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Theme Colors
    final primaryColor = const Color(0xFFff1f1f);
    final backgroundColor = const Color(0xFF0a0a0a);
    final surfaceDark = const Color(0xFF161616);
    final cardDark = const Color(0xFF1c1c1c);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          // Main Scrollable Content
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Placeholder (Spacing for the fixed header)
                const SizedBox(height: 100),

                // --- SECTION 1: MEGA ROYALE BANNER ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    height: 192,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.grey.withOpacity(0.2)),
                      image: const DecorationImage(
                        image: NetworkImage(
                          "https://lh3.googleusercontent.com/aida-public/AB6AXuDLWeGtu2P4iB45udcMw0hapc5rzpFRnasnI4ciS1JpiHzb6Fh_2v75lkNA2Eb5SMQyfWhI5dfI3YnSk8vux23zlAYTQ65oq3jyc-VL2NGkHRIii06HYxL541fXhZ2H1GzvPiaH_7kb5vqCjP0BYtkkXnxv1h3HYJk5RCVwxTfkZkqlj1LmA0q2VxzoDk9Ec3rN21TfsST6HkieQ5ln-8u7YdijfcTHwy3uKrJarGbac1i82J6WKcFM06PwSO4Ow_tD2z0alpQbIGk4",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [
                        // Gradient Overlay
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            gradient: LinearGradient(
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft,
                              colors: [
                                Colors.transparent,
                                backgroundColor.withOpacity(0.4),
                                backgroundColor.withOpacity(0.95),
                              ],
                            ),
                          ),
                        ),
                        // LIVE Badge
                        Positioned(
                          top: 16,
                          right: 16,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              "LIVE",
                              style: GoogleFonts.orbitron(
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        // Content
                        Positioned(
                          bottom: 24,
                          left: 24,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Mega Royale ₹1,00,000",
                                style: GoogleFonts.orbitron(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Text(
                                    "Join Now",
                                    style: GoogleFonts.orbitron(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w900,
                                      color: primaryColor,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Icon(
                                    Icons.chevron_right,
                                    color: primaryColor,
                                    size: 18,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // Carousel Indicators
                        Positioned(
                          bottom: 16,
                          right: 24,
                          child: Row(
                            children: [
                              Container(
                                width: 16,
                                height: 4,
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                width: 6,
                                height: 4,
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                width: 6,
                                height: 4,
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // --- SECTION 2: SELECT GAME HEADER ---
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(color: primaryColor, width: 4),
                          ),
                        ),
                        padding: const EdgeInsets.only(left: 12),
                        child: Text(
                          "SELECT GAME",
                          style: GoogleFonts.orbitron(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                      Text(
                        "VIEW ALL",
                        style: GoogleFonts.orbitron(
                          fontSize: 10,
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),

                // --- SECTION 3: GAME GRID ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      // Row with 2 vertical cards
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const FreeFireScreen(),
                                  ),
                                );
                              },
                              child: _buildGameCard(
                                primaryColor,
                                "Free Fire",
                                "12 TOURNAMENTS",
                                "https://lh3.googleusercontent.com/aida-public/AB6AXuD24_THd1tropOYaVLiCVRpDVoW0AQqkwQtmxbmdjlBObts7XCrkat9XyUMmnMW-_YozunQHazoNSc1dGMHznsTZ9lEluX3LLuYVCRlwazW7QWJCabPsMvwQF0USW3p3g_R0jezsV8FyL3uN6NKIBYIlVrBSU15AG-qIZdzCArCwKYvvEe64orE9fj3dCQBmpMCGqqqZqvxHZaDfflJj474J1Zo5qTHcF94Yb4XKrF6EiEhGFqr1YMSoOl6d4tTbdW6B5wnJNhT52Ej",
                                aspectRatio: 3 / 4,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildGameCard(
                              primaryColor,
                              "BGMI",
                              "8 TOURNAMENTS",
                              "https://lh3.googleusercontent.com/aida-public/AB6AXuDsCtp8RAkADucAONjYp3N1hG4FfbjEmGpV_gDQf9x-LfHPDBQnz4p8I6cbVp1dscGSNpFXZ6w7XT8Q5hJsyXXIWLl4451yRRcIX5cfa4Llr36xSwGV9ZnnVD6bC4oy20rYiWz2VDQgDVxXvyNCRRX0r3BeV_qztr709TvOAotSRBB6TXLNlFxiRUQVpxMci1E-eyZeVz3H3mr34RbD8Dhx1xy6TEdnfmQ3kzazSMicUFRYSjW3w1u5i0TchYxNuJfe5tV8eaMORfkY",
                              aspectRatio: 3 / 4,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Full width card
                      _buildGameCard(
                        primaryColor,
                        "Call of Duty Mobile",
                        "ACTIVE NOW • 5K PLAYERS",
                        "https://lh3.googleusercontent.com/aida-public/AB6AXuB3-RB0KB2jRLCIMtIzdxskXnPECwtgc8EfPmI8bbGQBM4vTl9kCUZff7wSetfKGSqIT1EHazoNSc1dGMHznsTZ9lEluX3LLuYVCRlwazW7QWJCabPsMvwQF0USW3p3g_R0jezsV8FyL3uN6NKIBYIlVrBSU15AG-qIZdzCArCwKYvvEe64orE9fj3dCQBmpMCGqqqZqvxHZaDfflJj474J1Zo5qTHcF94Yb4XKrF6EiEhGFqr1YMSoOl6d4tTbdW6B5wnJNhT52Ej",
                        aspectRatio: 21 / 9,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // --- FIXED TOP HEADER (GLASS) ---
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(16, 50, 16, 16),
                  decoration: BoxDecoration(
                    color: backgroundColor.withOpacity(0.8),
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // User Info
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: primaryColor, width: 2),
                              boxShadow: [
                                BoxShadow(
                                  color: primaryColor.withOpacity(0.4),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: const CircleAvatar(
                              radius: 18,
                              backgroundImage: NetworkImage(
                                "https://lh3.googleusercontent.com/aida-public/AB6AXuB94ZrvtYu3zRCozn-qx7cPVpHZadGm6w_tpjSKLCKuD466pflM3UYJq-BO3bG1V3tb8Iu9022I5SLeQxiVxQZy0OQX3K4Fxw6OAmjM0LS0zbPy_7WxhXAMKYBXre4QZyWfeiKNwVm2lKvboqh8_h1RWesbu_470GGUTzu3oxuIxnFhQY-kj93V91XgngP5S7N1TCdVODpn6HrGAodGIj6HafCgQzOAqXgZxE8MHi8Fs1fjSPelKoPBT-DQoEz3M1QEdier7k0LcxPH",
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "PLAYER ONE",
                                style: GoogleFonts.orbitron(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  letterSpacing: 1.2,
                                ),
                              ),
                              const SizedBox(height: 2),
                              // Green online indicator
                              Row(
                                children: [
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    "Online",
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.6),
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      // Wallet
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: primaryColor.withOpacity(0.3),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: primaryColor.withOpacity(0.2),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Text(
                              "₹",
                              style: GoogleFonts.orbitron(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "500",
                              style: GoogleFonts.orbitron(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // --- BOTTOM NAVIGATION BAR ---
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(8, 12, 8, 32),
                  decoration: BoxDecoration(
                    color: backgroundColor.withOpacity(0.95),
                    border: Border(
                      top: BorderSide(
                        color: Colors.white.withOpacity(0.05),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildNavItem(
                        "Home",
                        Icons.home,
                        selectedNavIndex == 0,
                        primaryColor,
                        () {
                          setState(() => selectedNavIndex = 0);
                        },
                      ),
                      _buildNavItem(
                        "Participated",
                        Icons.assignment_turned_in,
                        selectedNavIndex == 1,
                        primaryColor,
                        () {
                          setState(() => selectedNavIndex = 1);
                        },
                      ),
                      _buildNavItem(
                        "Wallet",
                        Icons.payments,
                        selectedNavIndex == 2,
                        primaryColor,
                        () {
                          setState(() => selectedNavIndex = 2);
                        },
                      ),
                      _buildNavItem(
                        "Refer",
                        Icons.share,
                        selectedNavIndex == 3,
                        primaryColor,
                        () {
                          setState(() => selectedNavIndex = 3);
                        },
                      ),
                      _buildNavItem(
                        "Leaderboard",
                        Icons.leaderboard,
                        selectedNavIndex == 4,
                        primaryColor,
                        () {
                          setState(() => selectedNavIndex = 4);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGET BUILDERS (Helper Functions) ---

  Widget _buildGameCard(
    Color primary,
    String title,
    String subtitle,
    String imgUrl, {
    required double aspectRatio,
  }) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.withOpacity(0.15)),
          image: DecorationImage(
            image: NetworkImage(imgUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.black.withOpacity(0.9),
                Colors.black.withOpacity(0.3),
                Colors.black.withOpacity(0.1),
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
          padding: const EdgeInsets.all(16),
          alignment: Alignment.bottomLeft,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.orbitron(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  color: primary,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    String label,
    IconData icon,
    bool isActive,
    Color primary,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive ? primary : Colors.white.withOpacity(0.5),
            size: 24,
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: GoogleFonts.orbitron(
              fontSize: 8,
              fontWeight: FontWeight.bold,
              color: isActive ? primary : Colors.white.withOpacity(0.5),
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}