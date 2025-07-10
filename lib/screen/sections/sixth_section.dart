import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SixthSection extends StatefulWidget {
  const SixthSection({super.key});

  @override
  State<SixthSection> createState() => _SixthSectionState();
}

class _SixthSectionState extends State<SixthSection> {
  final List<Map<String, String>> services = [
    {
      "icon": 'assets/images/serve1.png',
      "title": "Solar Development",
      "index": "1",
    },
    {
      "icon": 'assets/images/serve2.png',
      "title": "Energy Management",
      "index": "2",
    },
    {
      "icon": 'assets/images/serve4.png',
      "title": "Operation and Maintenance",
      "index": "3",
    },
    {
      "icon": 'assets/images/serve3.png',
      "title": "Solar Financing",
      "index": "4",
    },
  ];

  bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 800;
  }

  void _navigateToPage(String? index) {
    switch (index) {
      case '1':
        context.go('/products&services/solar-development');
        break;
      case '2':
        context.go('/products&services/energy-management');
        break;
      case '3':
        context.go('/products&services/operation&maintenance');
        break;
      case '4':
        context.go('/products&services/solar-financing');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final smallScreen = isSmallScreen(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Animated Title
          DefaultTextStyle(
            style: const TextStyle(
              fontFamily: 'Mulish',
              fontSize: 45,
              color: Color(0xff32CD32),
              fontWeight: FontWeight.w800,
            ),
            child: AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'Our Services',
                  speed: const Duration(milliseconds: 100),
                  cursor: '|',
                ),
              ],
              totalRepeatCount: 2,
              repeatForever: true,
              pause: const Duration(milliseconds: 10000),
              displayFullTextOnTap: true,
              stopPauseOnTap: true,
            ),
          ),
          const SizedBox(height: 30),

          // Description
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              constraints: const BoxConstraints(maxWidth: 1100),
              child: Text(
                'At Solevad Energy, we offer a comprehensive suite of services designed to meet the energy needs of residential, commercial, and industrial clients, ensuring optimal efficiency and sustainability.',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: smallScreen ? screenSize.width * 0.028 : screenSize.width * 0.018,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  height: 1.8,
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),

          // Services
          smallScreen
              ? Column(
                  children: services.map((service) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: AnimatedServiceCard(
                        icon: service["icon"]!,
                        title: service["title"]!,
                        onTap: () => _navigateToPage(service["index"]),
                      ),
                    );
                  }).toList(),
                )
              : Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  alignment: WrapAlignment.center,
                  children: services.map((service) {
                    return SizedBox(
                      width: 500,
                      child: AnimatedServiceCard(
                        icon: service["icon"]!,
                        title: service["title"]!,
                        onTap: () => _navigateToPage(service["index"]),
                      ),
                    );
                  }).toList(),
                ),
        ],
      ),
    );
  }
}

// 🔥 Reusable Card Widget with Hover Effect
class AnimatedServiceCard extends StatefulWidget {
  final String icon;
  final String title;
  final VoidCallback onTap;

  const AnimatedServiceCard({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  State<AnimatedServiceCard> createState() => _AnimatedServiceCardState();
}

class _AnimatedServiceCardState extends State<AnimatedServiceCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedScale(
        scale: isHovered ? 1.02 : 1.0,
        duration: const Duration(milliseconds: 300),
        child: GestureDetector(
          onTap: widget.onTap,
          child: Stack(
            children: [
              // Background Image
              Container(
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1),
                  image: DecorationImage(
                    image: AssetImage(widget.icon),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Blur Overlay with Text
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(1),
                    bottomRight: Radius.circular(1),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      height: 90,
                      color: Colors.black.withOpacity(0.1),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                widget.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(7),
                              decoration: const BoxDecoration(
                                color: Color(0xff8B4513),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.arrow_forward_ios_sharp,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
