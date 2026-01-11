import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'tournament_join_success_screen.dart';

class TournamentDetailsScreen extends StatefulWidget {
  final String title;
  final String location;
  final String date;
  final String time;
  final String entryFee;
  final String prizePool;
  final String perKill;
  final String version;
  final String imageUrl;
  final String? badge;
  final int filledSlots;
  final int totalSlots;

  const TournamentDetailsScreen({
    super.key,
    required this.title,
    required this.location,
    required this.date,
    required this.time,
    required this.entryFee,
    required this.prizePool,
    required this.perKill,
    required this.version,
    required this.imageUrl,
    this.badge,
    required this.filledSlots,
    required this.totalSlots,
  });

  @override
  State<TournamentDetailsScreen> createState() =>
      _TournamentDetailsScreenState();
}

class _TournamentDetailsScreenState extends State<TournamentDetailsScreen> {
  int selectedTab = 0; // 0: Description, 1: Joined Players

  @override
  Widget build(BuildContext context) {
    final primaryColor = const Color(0xFFFF1F1F);
    final backgroundColor = const Color(0xFF0A0505);
    final cardColor = const Color(0xFF1A0F0F);

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
                    decoration: BoxDecoration(
                      color: backgroundColor.withOpacity(0.8),
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.white.withOpacity(0.05),
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            widget.title,
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // --- TOURNAMENT IMAGE ---
              Container(
                height: 220,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    // Gradient Overlay
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            backgroundColor.withOpacity(0.3),
                            backgroundColor,
                          ],
                        ),
                      ),
                    ),
                    // Badges at bottom left
                    Positioned(
                      bottom: 16,
                      left: 16,
                      child: Row(
                        children: [
                          if (widget.badge != null)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                widget.badge!,
                                style: GoogleFonts.inter(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          if (widget.badge != null) const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'Solo',
                              style: GoogleFonts.inter(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // --- TAB NAVIGATION ---
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.white.withOpacity(0.05),
                    ),
                  ),
                  color: cardColor.withOpacity(0.3),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() => selectedTab = 0);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            border: selectedTab == 0
                                ? Border(
                                    bottom: BorderSide(
                                      color: primaryColor,
                                      width: 2,
                                    ),
                                  )
                                : null,
                          ),
                          child: Text(
                            'Description',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: selectedTab == 0
                                  ? primaryColor
                                  : Colors.white.withOpacity(0.5),
                              letterSpacing: 0.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() => selectedTab = 1);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            border: selectedTab == 1
                                ? Border(
                                    bottom: BorderSide(
                                      color: primaryColor,
                                      width: 2,
                                    ),
                                  )
                                : null,
                          ),
                          child: Text(
                            'Joined Players',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: selectedTab == 1
                                  ? primaryColor
                                  : Colors.white.withOpacity(0.5),
                              letterSpacing: 0.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // --- MAIN CONTENT ---
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      if (selectedTab == 0) ...[
                        // DESCRIPTION TAB
                        _buildSectionTitle('MATCH DETAILS', primaryColor),
                        _buildMatchDetailsCard(primaryColor, cardColor),
                        const SizedBox(height: 24),
                        _buildSectionTitle('PRIZE DISTRIBUTION', primaryColor),
                        _buildPrizeDistributionCard(primaryColor, cardColor),
                        const SizedBox(height: 24),
                        _buildSectionTitle('ABOUT MATCH', primaryColor),
                        _buildAboutMatchCard(cardColor),
                        const SizedBox(height: 24),
                        _buildSectionTitle('RULES', primaryColor),
                        _buildRulesCard(primaryColor, cardColor),
                      ] else if (selectedTab == 1) ...[
                        // JOINED PLAYERS TAB
                        _buildJoinedPlayersSection(primaryColor, cardColor),
                      ],
                      const SizedBox(height: 120),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // --- FOOTER BUTTON ---
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: backgroundColor.withOpacity(0.95),
                    border: Border(
                      top: BorderSide(
                        color: Colors.white.withOpacity(0.1),
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'BALANCE',
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white.withOpacity(0.5),
                              letterSpacing: 0.5,
                            ),
                          ),
                          Text(
                            '₹500',
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _showJoinConfirmationSheet(context, primaryColor),
                          child: Container(
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: primaryColor.withOpacity(0.3),
                                  blurRadius: 20,
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            child: Text(
                              'JOIN NOW',
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                letterSpacing: 1,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
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

  Widget _buildSectionTitle(String title, Color primaryColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: Colors.white.withOpacity(0.4),
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }

  Widget _buildMatchDetailsCard(Color primaryColor, Color cardColor) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.05),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildDetailItem(
                  'payments',
                  'ENTRY FEE',
                  '₹${widget.entryFee}',
                  primaryColor,
                ),
              ),
              Expanded(
                child: _buildDetailItem(
                  'map',
                  'MAP',
                  widget.location,
                  primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildDetailItem(
                  'layers',
                  'VERSION',
                  widget.version,
                  primaryColor,
                ),
              ),
              Expanded(
                child: _buildDetailItem(
                  'schedule',
                  'SCHEDULE',
                  '${widget.date}, ${widget.time}',
                  primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(
    String icon,
    String label,
    String value,
    Color primaryColor,
  ) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            shape: BoxShape.circle,
          ),
          child: Icon(
            _getIconData(icon),
            color: primaryColor,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  color: Colors.white.withOpacity(0.4),
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPrizeDistributionCard(Color primaryColor, Color cardColor) {
    int prizeAmount = int.tryParse(widget.prizePool) ?? 0;

    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.05),
        ),
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Prize Distribution',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'Total ₹${widget.prizePool}',
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          _buildPrizeRow('#1', 'Winner', (prizeAmount ~/ 2).toString(), primaryColor, false),
          _buildPrizeRow('#2', 'Runner Up', (prizeAmount ~/ 3).toString(), primaryColor, false),
          _buildPrizeRow(
            'military_tech',
            'Per Kill Reward',
            '₹${widget.perKill}',
            primaryColor,
            true,
          ),
        ],
      ),
    );
  }

  Widget _buildPrizeRow(
    String label1,
    String label2,
    String amount,
    Color primaryColor,
    bool isIcon,
  ) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.white.withOpacity(0.05),
          ),
        ),
        color: label1 == 'military_tech'
            ? primaryColor.withOpacity(0.05)
            : Colors.transparent,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (isIcon)
                Icon(
                  Icons.military_tech,
                  color: primaryColor,
                  size: 18,
                )
              else
                Text(
                  label1,
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white.withOpacity(0.4),
                  ),
                ),
              const SizedBox(width: 12),
              Text(
                label2,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Text(
            amount.startsWith('₹') ? amount : '₹$amount',
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w900,
              color: isIcon ? primaryColor : Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutMatchCard(Color cardColor) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.05),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Text(
        'This is a high-stakes solo survival tournament. Prove your skills in the ${widget.location} map and outlast ${widget.totalSlots - 1} other players to claim the grand prize. Every kill rewards you, so aggression and strategy are equally important.',
        style: GoogleFonts.inter(
          fontSize: 12,
          color: Colors.white.withOpacity(0.7),
          height: 1.6,
        ),
      ),
    );
  }

  Widget _buildRulesCard(Color primaryColor, Color cardColor) {
    final rules = [
      'Level 40+ account required to join the match.',
      'Emulators are strictly prohibited and will lead to disqualification.',
      'Teaming up in solo matches will result in a permanent ban.',
      'Room ID and Password will be shared 15 minutes before the start time.',
    ];

    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.05),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: List.generate(
          rules.length,
          (index) => Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '•',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      rules[index],
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Colors.white.withOpacity(0.7),
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
              if (index < rules.length - 1) const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildJoinedPlayersSection(Color primaryColor, Color cardColor) {
    // Sample joined players data
    final players = [
      {'name': 'ProGamer_99', 'badge': 'PRO', 'joinTime': '2 hours ago'},
      {'name': 'SniperKing', 'badge': 'ELITE', 'joinTime': '1 hour ago'},
      {'name': 'ShadowHunter', 'badge': 'PRO', 'joinTime': '45 min ago'},
      {'name': 'IceStorm', 'joinTime': '30 min ago'},
      {'name': 'PhantomX', 'badge': 'LEGEND', 'joinTime': '15 min ago'},
      {'name': 'GhostRider', 'joinTime': '10 min ago'},
    ];

    return Column(
      children: List.generate(
        players.length,
        (index) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Container(
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.white.withOpacity(0.05),
              ),
            ),
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        primaryColor.withOpacity(0.6),
                        primaryColor.withOpacity(0.2),
                      ],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            players[index]['name']!,
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          if (players[index]['badge'] != null) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: primaryColor.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                players[index]['badge']!,
                                style: GoogleFonts.inter(
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Joined ${players[index]['joinTime']!}',
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          color: Colors.white.withOpacity(0.4),
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
    );
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'payments':
        return Icons.payments;
      case 'map':
        return Icons.map;
      case 'layers':
        return Icons.layers;
      case 'schedule':
        return Icons.schedule;
      default:
        return Icons.info;
    }
  }

  void _showJoinConfirmationSheet(BuildContext context, Color primaryColor) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => JoinConfirmationSheet(
        title: widget.title,
        entryFee: widget.entryFee,
        date: widget.date,
        time: widget.time,
        primaryColor: primaryColor,
      ),
    );
  }
}

class JoinConfirmationSheet extends StatefulWidget {
  final String title;
  final String entryFee;
  final String date;
  final String time;
  final Color primaryColor;

  const JoinConfirmationSheet({
    super.key,
    required this.title,
    required this.entryFee,
    required this.date,
    required this.time,
    required this.primaryColor,
  });

  @override
  State<JoinConfirmationSheet> createState() => _JoinConfirmationSheetState();
}

class _JoinConfirmationSheetState extends State<JoinConfirmationSheet> {
  @override
  Widget build(BuildContext context) {
    final backgroundColor = const Color(0xFF0A0505);
    final cardColor = const Color(0xFF1A0F0F);
    int entryFeeInt = int.tryParse(widget.entryFee) ?? 50;
    int walletBalance = 500;
    int balanceAfter = walletBalance - entryFeeInt;

    final rules = [
      'Level 40+ account required to join the match.',
      'Emulators are strictly prohibited and will lead to disqualification.',
      'Teaming up in solo matches will result in a permanent ban.',
      'Room ID and Password will be shared 15 minutes before the start time.',
    ];

    return Stack(
      children: [
        // Dark overlay
        Positioned.fill(
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              color: Colors.black.withOpacity(0.7),
            ),
          ),
        ),
        // Bottom sheet - Fixed at 80% height
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.8,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              border: Border(
                top: BorderSide(
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
            ),
            child: Column(
              children: [
                // Fixed Header
                Container(
                  padding: const EdgeInsets.only(top: 8, bottom: 12),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.white.withOpacity(0.05),
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Handle Bar
                      Container(
                        width: 48,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(2.5),
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Header with close button
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox.shrink(),
                            Text(
                              'CONFIRM PARTICIPATION',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                letterSpacing: 1,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Icon(
                                Icons.close,
                                color: Colors.white.withOpacity(0.5),
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Scrollable Rules Section
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.gavel,
                              color: widget.primaryColor,
                              size: 16,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'RULES & TERMS',
                              style: GoogleFonts.inter(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white.withOpacity(0.4),
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.02),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.05),
                            ),
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: List.generate(
                              rules.length,
                              (index) => Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '•',
                                        style: GoogleFonts.inter(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: widget.primaryColor,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          rules[index],
                                          style: GoogleFonts.inter(
                                            fontSize: 11,
                                            color: Colors.white
                                                .withOpacity(0.7),
                                            height: 1.4,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (index < rules.length - 1)
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
                // Fixed Footer Section
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.white.withOpacity(0.05),
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      // Tournament Info Card
                      Container(
                        decoration: BoxDecoration(
                          color: widget.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: widget.primaryColor.withOpacity(0.2),
                          ),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.1),
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  'https://lh3.googleusercontent.com/aida-public/AB6AXuApOYzgXLQKX0Lfvkhar4wZZs0eAHxvip7QRII3PmvNCis4aKi0DgoVVCuFXwKddlV2J83DvOM69NlqbfZNq39-aE2nylTydj2B_NxUQfEtetf02KcPqW5hZd5uY-wc9EkyASgMd0q4QKeFb51SvAVOjnFgRiluyYGb6YvUPAIQ7rhRlxLN5QCnoDJVh-JzQ97nzLF0-iUnB53eYP3X9fZJIlxTqWrpdcEmnlBgLIqsZWgw153NgKmrI_hvgBh-7jFjHqLihmDRp_oI',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.title,
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Entry Fee: ₹${widget.entryFee}',
                                    style: GoogleFonts.inter(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: widget.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Wallet Details
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.account_balance_wallet,
                                    color: Colors.white.withOpacity(0.5),
                                    size: 14,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Current Wallet Balance',
                                    style: GoogleFonts.inter(
                                      fontSize: 11,
                                      color: Colors.white.withOpacity(0.6),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                '₹$walletBalance',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Container(
                            height: 1,
                            color: Colors.white.withOpacity(0.05),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.payments,
                                    color: widget.primaryColor,
                                    size: 14,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Joining Fee',
                                    style: GoogleFonts.inter(
                                      fontSize: 11,
                                      color: Colors.white.withOpacity(0.6),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                '- ₹$entryFeeInt',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: widget.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Balance Info Box
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.02),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.05),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: Colors.white.withOpacity(0.4),
                              size: 14,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  text:
                                      'Available Balance after Join: ',
                                  style: GoogleFonts.inter(
                                    fontSize: 9,
                                    color: Colors.white.withOpacity(0.5),
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '₹$balanceAfter',
                                      style: GoogleFonts.inter(
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),
                      // PAY & JOIN NOW Button
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          // Generate random slot number
                          int slotNumber =
                              DateTime.now().millisecond % 48 + 1;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  TournamentJoinSuccessScreen(
                                tournamentTitle: widget.title,
                                date: widget.date,
                                time: widget.time,
                                slotNumber: slotNumber,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: widget.primaryColor,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: widget.primaryColor.withOpacity(0.3),
                                blurRadius: 12,
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.bolt,
                                color: Colors.white,
                                size: 18,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'PAY & JOIN NOW',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                  letterSpacing: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'By clicking Pay & Join, you agree to the Tournament Rules and Terms of Service.',
                        style: GoogleFonts.inter(
                          fontSize: 8,
                          color: Colors.white.withOpacity(0.4),
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
