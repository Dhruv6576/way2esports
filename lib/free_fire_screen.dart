import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'free_fire_br_screen.dart';

class FreeFireScreen extends StatefulWidget {
  const FreeFireScreen({super.key});

  @override
  State<FreeFireScreen> createState() => _FreeFireScreenState();
}

class _FreeFireScreenState extends State<FreeFireScreen> {
  int selectedNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    final primaryColor = const Color(0xFFf20d0d);
    final backgroundColor = const Color(0xFF1a0b0b);
    final surfaceColor = Colors.white.withOpacity(0.05);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          Column(
            children: [
              // --- HEADER ---
              ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                    decoration: BoxDecoration(
                      color: backgroundColor.withOpacity(0.8),
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.white.withOpacity(0.05),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // User Profile
                        GestureDetector(
                          onTap: () {},
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      primaryColor,
                                      Colors.red.shade700,
                                    ],
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: backgroundColor,
                                    ),
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.white.withOpacity(0.8),
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "GarenaKing_99",
                                    style: GoogleFonts.splineSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    "EDIT PROFILE",
                                    style: GoogleFonts.splineSans(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white.withOpacity(0.5),
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // Wallet
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.1),
                            ),
                          ),
                          child: Row(
                            children: [
                              Text(
                                "₹500",
                                style: GoogleFonts.splineSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  width: 28,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: primaryColor,
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 18,
                                  ),
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
              // --- MAIN CONTENT ---
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Select Game Mode Header
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 32, 16, 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "SELECT GAME MODE",
                              style: GoogleFonts.splineSans(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white.withOpacity(0.8),
                                letterSpacing: 2.4,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              width: 48,
                              height: 4,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Game Mode Cards
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const FreeFireBRScreen(),
                                  ),
                                );
                              },
                              child: _buildGameModeCard(
                                context,
                                "BATTLE ROYALE (BR)",
                                "The classic survival experience. 50 players, 1 champion.",
                                "https://lh3.googleusercontent.com/aida-public/AB6AXuBXsYiKExAVVGl6TOz4dYdlAjb8g8SuqPf8NCs2x_IYdN7P45qfjM-LhhETXbfPEJAgnJGxk0mSwYGhp0HIxQzsiSNT41W9x0xQ-tpmg3vApMFJgyfboEBZY3plhx3_S1aRLeYgApGfbG7jEMOtRXXDssAfqNhR7Amcfh7K9zYhqkObGhEiWyHBLcIa_UxKZYSZaYxk2hCgBNkd9WBX5rHEjpHEQMBq94onC1uApTjwx2-oKLvxCc1tRJHcGoJ6ze9gBTNE7MPu1jn8",
                                "RECOMMENDED",
                                primaryColor,
                                true,
                              ),
                            ),
                            const SizedBox(height: 20),
                            _buildGameModeCard(
                              context,
                              "CLASH SQUAD (CS)",
                              "4v4 fast-paced tactical team combat in smaller zones.",
                              "https://lh3.googleusercontent.com/aida-public/AB6AXuB5CJdwltUHSYwBVRo9GPug3pud4WSMh-ww84tsrptC-h1qZLzVDen9dJ3-WHLbQ5i_MLY1MeCbysOEZKxlSScDzVZ6ht3GWC5g2o6nGJLWEqE7LwckIuhOBlEUMNwlJEnyEzay0JVodD229huFe9ElrvzhymfgA-Ffn9N-KcAdUU-TiCGIdk_5KtiVusTVR31u6W_6Y7G5PRBKWm9SHfGl-gQDoEBiSvDJas_hU_YeIKKPYD28Xrtr6E_raH699VpJduLi6LdwjH5L",
                              "FAST COMBAT",
                              Colors.white.withOpacity(0.2),
                              false,
                            ),
                            const SizedBox(height: 20),
                            _buildGameModeCard(
                              context,
                              "LONE WOLF",
                              "Prove your individual skill in intense 1v1 showdowns.",
                              "https://lh3.googleusercontent.com/aida-public/AB6AXuCQoL3dyVYPnMz5X7yplMxqq2Jkx06B1LnnjTiDbfnEU4WP3LFclzZSM1IhZqQgBMgyDe08Hu-byyVszyOPTAoeT37mzOUiC7KqXn_zEGTiyIgDjDGQ1mU2cZyF_98I-E8mfas_vvKqmemV_PW0-FKhBWTDkRyzRaCxx12tCfahpF8zdlRR-ODLd76etdF0C-TADfy4jqQzi4g6xWX_x_xHp6Db03XEVQgLRYqrWoSFS2Bpl5iC-U782UH-aSL9XScEC4wn8hTL30ZM",
                              "1V1 DUEL",
                              Colors.white.withOpacity(0.2),
                              false,
                            ),
                            const SizedBox(height: 20),
                            _buildGameModeCard(
                              context,
                              "FREE MATCHES",
                              "Zero entry fee. Practice your strategies and aim.",
                              "https://lh3.googleusercontent.com/aida-public/AB6AXuBLZ3nTziM2jnyuYM-eEyneJi8WtD1AuLNOj8DPdIGMuT62g-FUUJz6zmdkFfcu278_03WKPzNts6vij3AoAKUilamffMcimRnhdn6iyTs0rlDrzp9yFCDbz7UwDYGgNe0cg2hK1IAuiax3oBuprT9MPPEisvG5z4_vuF9-Wg2mS5aYpeZYVFhqN4GrhVKL65-_6hb7VXF4qmjheKq_ZIC-e-u8v3s5w8IrXL7jZ4cFkMj430EszmJNI8KJQQNNsc_9_J6ADf2Wo_Ms",
                              "PRACTICE",
                              Colors.white.withOpacity(0.2),
                              false,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 120),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // --- BOTTOM NAVIGATION ---
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

  Widget _buildGameModeCard(
    BuildContext context,
    String title,
    String description,
    String imageUrl,
    String badge,
    Color badgeColor,
    bool isRecommended,
  ) {
    final primaryColor = const Color(0xFFf20d0d);

    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 16,
          ),
        ],
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
        ),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
          children: [
            // Glass Overlay Gradient
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    const Color(0xFF1a0b0b).withOpacity(0.95),
                    const Color(0xFF1a0b0b).withOpacity(0.6),
                    const Color(0xFF1a0b0b).withOpacity(0),
                  ],
                ),
              ),
            ),
            // Play Button (Top Right)
            Positioned(
              top: 16,
              right: 16,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isRecommended
                      ? primaryColor.withOpacity(0.2)
                      : Colors.black.withOpacity(0.4),
                  border: Border.all(
                    color: isRecommended
                        ? primaryColor.withOpacity(0.3)
                        : Colors.white.withOpacity(0.1),
                  ),
                ),
                child: Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            // Content (Bottom)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: badgeColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        badge,
                        style: GoogleFonts.splineSans(
                          fontSize: 8,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Title
                    Text(
                      title,
                      style: GoogleFonts.splineSans(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Description
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Text(
                        description,
                        style: GoogleFonts.splineSans(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
  }

  Widget _buildNavItem(
    String label,
    IconData icon,
    bool isActive,
    Color primaryColor,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive ? primaryColor : Colors.white.withOpacity(0.5),
            size: 24,
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: GoogleFonts.splineSans(
              fontSize: 8,
              fontWeight: FontWeight.bold,
              color: isActive ? primaryColor : Colors.white.withOpacity(0.5),
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}
