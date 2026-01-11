import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'tournament_details_screen.dart';

class FreeFireBRScreen extends StatefulWidget {
  const FreeFireBRScreen({super.key});

  @override
  State<FreeFireBRScreen> createState() => _FreeFireBRScreenState();
}

class _FreeFireBRScreenState extends State<FreeFireBRScreen> {
  int selectedTab = 0; // 0: Squad, 1: Duo, 2: Solo
  int selectedNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    final primaryColor = const Color(0xFFFF1F1F);
    final backgroundColor = const Color(0xFF120808);
    final cardColor = const Color(0xFF1E0F0F);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          Column(
            children: [
              // --- STICKY HEADER ---
              ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: backgroundColor.withOpacity(0.8),
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.white.withOpacity(0.05),
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        // Top Profile Bar
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // User Profile
                              Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: primaryColor,
                                        width: 2,
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        'https://lh3.googleusercontent.com/aida-public/AB6AXuB7feMHQKUHnrJoFVeZOFI-qzolFFCyF8nzhOxpKq59KkRKHa4SO66q09ReqaigZEjTpaS1J4dEBBpjYdI0a2_nZL8LGI0WRQE550H1hx6rz0oxrTdDAZKXkaOPKzJhdzqB7MVnol3Y-VoR6bb8DcU-gL1to5gEUG81voVgl0bSqJFpxXXOwMUcG0AfjtJHIFjUH9jBi1OpGPNwyPdUuy7PvuUPKYAEK95l-5zM3NfbcPXriYBStbXKgmIdiqoSidssmttmNjOXgg',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'GarenaKing_99',
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        'PRO PLAYER',
                                        style: GoogleFonts.inter(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF999999),
                                          letterSpacing: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              // Add Money Button
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
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
                                      '₹500',
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Icon(
                                      Icons.add_circle,
                                      color: primaryColor,
                                      size: 18,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Tab Navigation
                        SizedBox(
                          height: 50,
                          child: Row(
                            children: [
                              _buildTabButton('Squad', 0, primaryColor),
                              _buildTabButton('Duo', 1, primaryColor),
                              _buildTabButton('Solo', 2, primaryColor),
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
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      if (selectedTab == 0) ...[
                        _buildTournamentCard(
                          context,
                          'Solo Survivor #109',
                          'Bermuda',
                          '24 OCT',
                          '08:30 PM',
                          35,
                          48,
                          '30',
                          '300',
                          '5',
                          'TPP',
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuDQqR6w9tgnWXXg6PGkj84Jz3nhBA1sWPvzWXyXjZ6tQXKvXelePuqDIh-zZW6i8ehLokfQ-hOTw6QwHJbf7RQ9QXisLd44KztSPEdoL6Fux2J6f3y-12rM-YoSQnwIIydAgQJXkI0ThhXJuqGgsIfqLRhNjcB9xbjFg0DV184XL7uivYQKbpXYaulOzbofPCbuAa8rIy7La9FtVns9K-n3YXwKUhmB3dOTy-dqtEbKg3usctjf_BHYyou5J0sXeFAN7y4pmBSOTg',
                          'Filling Fast',
                          primaryColor,
                        ),
                        const SizedBox(height: 20),
                        _buildTournamentCard(
                          context,
                          'Solo Elite #110',
                          'Purgatory',
                          '25 OCT',
                          '10:00 PM',
                          12,
                          48,
                          '50',
                          '500',
                          '10',
                          'FPP',
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuAsCRezES84sDfRIe13T7-84YzlaTb7BA1WJloJ0ZSJ3mLMNiE_L0Ut8VLvsKu2nlToZd-u2TrGuasYAfX0E4arnq8ZqFaY-0I2yozu7j3pFGXiSI9piZ7khlXDaG18L8rQwGvop0sgfm8OocJVCV9y1b67iJKK1pWwBj_x8WF7b0B9luxkikEh8IH6AbxKgagBpA8NQBK3Lwo9h4PRdepPh8rxZqaacWIc-LvFzUTuiJGILFrO1M-6B1VsNO21Z4DPG42jSVReKw',
                          null,
                          primaryColor,
                        ),
                        const SizedBox(height: 20),
                        _buildTournamentCard(
                          context,
                          'Solo Warrior #111',
                          'Kalahari',
                          '26 OCT',
                          '09:15 PM',
                          42,
                          48,
                          '100',
                          '1000',
                          '20',
                          'TPP',
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuCp2ecuyj401v5-Tq9XBXeLAubfaCcmiUZVTcVsL1cecu13-dwIxv9voQnRIGIJCNhWEcSxoMqzy4BigxplxsTQSouBZq5uL-tBTSYPDLXw1Ml_ML4kKBDQt6e9HOUW5WEuUA7H2dmQr4lx2r_1LkgIVDLMw61TQW3Q4Ui3BiA_wJTs6OEAgaeNWN74ne4mBI_GMtgB1rXWxuPyrWfk3ud-W0W4N2RsW3MjeP2NogTKSjh6Xw2R31OMRdNTTCVfex6VyRvLRMViQg',
                          null,
                          primaryColor,
                        ),
                      ] else if (selectedTab == 1) ...[
                        _buildTournamentCard(
                          context,
                          'Duo Masters #105',
                          'Bermuda',
                          '24 OCT',
                          '07:00 PM',
                          28,
                          48,
                          '40',
                          '400',
                          '8',
                          'TPP',
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuDQqR6w9tgnWXXg6PGkj84Jz3nhBA1sWPvzWXyXjZ6tQXKvXelePuqDIh-zZW6i8ehLokfQ-hOTw6QwHJbf7RQ9QXisLd44KztSPEdoL6Fux2J6f3y-12rM-YoSQnwIIydAgQJXkI0ThhXJuqGgsIfqLRhNjcB9xbjFg0DV184XL7uivYQKbpXYaulOzbofPCbuAa8rIy7La9FtVns9K-n3YXwKUhmB3dOTy-dqtEbKg3usctjf_BHYyou5J0sXeFAN7y4pmBSOTg',
                          'Hot',
                          primaryColor,
                        ),
                        const SizedBox(height: 20),
                        _buildTournamentCard(
                          context,
                          'Duo Elite #106',
                          'Purgatory',
                          '25 OCT',
                          '09:00 PM',
                          18,
                          48,
                          '60',
                          '600',
                          '12',
                          'FPP',
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuAsCRezES84sDfRIe13T7-84YzlaTb7BA1WJloJ0ZSJ3mLMNiE_L0Ut8VLvsKu2nlToZd-u2TrGuasYAfX0E4arnq8ZqFaY-0I2yozu7j3pFGXiSI9piZ7khlXDaG18L8rQwGvop0sgfm8OocJVCV9y1b67iJKK1pWwBj_x8WF7b0B9luxkikEh8IH6AbxKgagBpA8NQBK3Lwo9h4PRdepPh8rxZqaacWIc-LvFzUTuiJGILFrO1M-6B1VsNO21Z4DPG42jSVReKw',
                          null,
                          primaryColor,
                        ),
                      ] else if (selectedTab == 2) ...[
                        _buildTournamentCard(
                          context,
                          'Squad Clash #120',
                          'Bermuda',
                          '24 OCT',
                          '06:30 PM',
                          32,
                          48,
                          '50',
                          '500',
                          '10',
                          'TPP',
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuDQqR6w9tgnWXXg6PGkj84Jz3nhBA1sWPvzWXyXjZ6tQXKvXelePuqDIh-zZW6i8ehLokfQ-hOTw6QwHJbf7RQ9QXisLd44KztSPEdoL6Fux2J6f3y-12rM-YoSQnwIIydAgQJXkI0ThhXJuqGgsIfqLRhNjcB9xbjFg0DV184XL7uivYQKbpXYaulOzbofPCbuAa8rIy7La9FtVns9K-n3YXwKUhmB3dOTy-dqtEbKg3usctjf_BHYyou5J0sXeFAN7y4pmBSOTg',
                          null,
                          primaryColor,
                        ),
                        const SizedBox(height: 20),
                        _buildTournamentCard(
                          context,
                          'Squad Pro #121',
                          'Purgatory',
                          '25 OCT',
                          '08:00 PM',
                          24,
                          48,
                          '75',
                          '750',
                          '15',
                          'FPP',
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuAsCRezES84sDfRIe13T7-84YzlaTb7BA1WJloJ0ZSJ3mLMNiE_L0Ut8VLvsKu2nlToZd-u2TrGuasYAfX0E4arnq8ZqFaY-0I2yozu7j3pFGXiSI9piZ7khlXDaG18L8rQwGvop0sgfm8OocJVCV9y1b67iJKK1pWwBj_x8WF7b0B9luxkikEh8IH6AbxKgagBpA8NQBK3Lwo9h4PRdepPh8rxZqaacWIc-LvFzUTuiJGILFrO1M-6B1VsNO21Z4DPG42jSVReKw',
                          null,
                          primaryColor,
                        ),
                      ],
                      const SizedBox(height: 120),
                    ],
                  ),
                ),
              ),
            ],
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
                  padding: const EdgeInsets.fromLTRB(8, 12, 8, 24),
                  decoration: BoxDecoration(
                    color: backgroundColor.withOpacity(0.95),
                    border: Border(
                      top: BorderSide(
                        color: Colors.white.withOpacity(0.05),
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildNavItem(
                        'home',
                        'Home',
                        selectedNavIndex == 0,
                        primaryColor,
                        () {
                          setState(() => selectedNavIndex = 0);
                        },
                      ),
                      _buildNavItem(
                        'share',
                        'Refer',
                        selectedNavIndex == 1,
                        primaryColor,
                        () {
                          setState(() => selectedNavIndex = 1);
                        },
                      ),
                      _buildNavItem(
                        'play_circle',
                        'Winnings',
                        selectedNavIndex == 2,
                        primaryColor,
                        () {
                          setState(() => selectedNavIndex = 2);
                        },
                      ),
                      _buildNavItem(
                        'assignment',
                        'Joined',
                        selectedNavIndex == 3,
                        primaryColor,
                        () {
                          setState(() => selectedNavIndex = 3);
                        },
                      ),
                      _buildNavItem(
                        'bar_chart',
                        'Rank',
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

  Widget _buildTabButton(String label, int index, Color primaryColor) {
    bool isActive = selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() => selectedTab = index);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isActive ? Colors.white : Colors.white.withOpacity(0.4),
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 8),
            if (isActive)
              Container(
                height: 2,
                width: 50,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTournamentCard(
    BuildContext context,
    String title,
    String location,
    String date,
    String time,
    int filledSlots,
    int totalSlots,
    String entryFee,
    String prizePool,
    String perKill,
    String version,
    String imageUrl,
    String? badge,
    Color primaryColor,
  ) {
    double fillPercentage = filledSlots / totalSlots;
    final backgroundColor = const Color(0xFF120808);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TournamentDetailsScreen(
              title: title,
              location: location,
              date: date,
              time: time,
              entryFee: entryFee,
              prizePool: prizePool,
              perKill: perKill,
              version: version,
              imageUrl: imageUrl,
              badge: badge,
              filledSlots: filledSlots,
              totalSlots: totalSlots,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          border: Border.all(
            color: Colors.white.withOpacity(0.1),
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section with Overlay
            Stack(
              children: [
                // Background Image
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Gradient Overlay
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        const Color(0xFF1E0F0F).withOpacity(0.8),
                        const Color(0xFF1E0F0F),
                      ],
                    ),
                  ),
                ),
                // Badge
                if (badge != null)
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        badge,
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                // Date and Time Box
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.1),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          date,
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                        Text(
                          time,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Title and Location at Bottom
                Positioned(
                  bottom: 12,
                  left: 16,
                  right: 16,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        location,
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white.withOpacity(0.7),
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Content Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Slots Filled Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'SLOTS FILLED',
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white.withOpacity(0.5),
                          letterSpacing: 0.5,
                        ),
                      ),
                      Text(
                        '$filledSlots/$totalSlots',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Progress Bar
                  Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: fillPercentage,
                      child: Container(
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Info Grid
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.02),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.05),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                    child: Row(
                      children: [
                        // Entry Fee
                        Expanded(
                          child: _buildInfoItem(
                            'ENTRY FEE',
                            '₹$entryFee',
                            primaryColor,
                            showDivider: true,
                          ),
                        ),
                        _buildVerticalDivider(),
                        // Prize Pool
                        Expanded(
                          child: _buildInfoItem(
                            'PRIZE POOL',
                            '₹$prizePool',
                            primaryColor,
                            showDivider: true,
                            isPrimary: true,
                          ),
                        ),
                        _buildVerticalDivider(),
                        // Per Kill
                        Expanded(
                          child: _buildInfoItem(
                            'PER KILL',
                            '₹$perKill',
                            primaryColor,
                            showDivider: true,
                          ),
                        ),
                        _buildVerticalDivider(),
                        // Version
                        Expanded(
                          child: _buildInfoItem(
                            'VERSION',
                            version,
                            primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(
    String label,
    String value,
    Color primaryColor, {
    bool showDivider = false,
    bool isPrimary = false,
  }) {
    return Column(
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 8,
            fontWeight: FontWeight.bold,
            color: Colors.white.withOpacity(0.4),
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w900,
            color: isPrimary ? primaryColor : Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      width: 1,
      height: 40,
      color: Colors.white.withOpacity(0.1),
    );
  }

  Widget _buildNavItem(
    String iconName,
    String label,
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
            _getIconData(iconName),
            color: isActive ? primaryColor : Colors.white.withOpacity(0.4),
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: isActive ? primaryColor : Colors.white.withOpacity(0.4),
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'home':
        return Icons.home;
      case 'share':
        return Icons.share;
      case 'play_circle':
        return Icons.play_circle;
      case 'assignment':
        return Icons.assignment;
      case 'bar_chart':
        return Icons.bar_chart;
      default:
        return Icons.home;
    }
  }
}
