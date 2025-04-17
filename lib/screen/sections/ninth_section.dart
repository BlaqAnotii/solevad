import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NinthSection extends StatefulWidget {
  const NinthSection({super.key});

  @override
  State<NinthSection> createState() => _NinthSectionState();
}

class _NinthSectionState extends State<NinthSection> {
  @override
  Widget build(BuildContext context) {
                    var screenSize = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(top: 70),// dark background
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
      decoration: const BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.centerLeft, // Start from the left
    end: Alignment.centerRight,  // End at the right
    colors: [
      Color(0xFF1A1A1A), // Dark gray on the left
      Color(0xFF2C2C2C), // Slightly lighter gray on the right
    ],
  ),
),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Our Core Values",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
           Text(
            "We are driven by sustainability, grounded in integrity, inspired by\ninnovation, committed to customer focus, and dedicated to excellence in all we do.",
            style: TextStyle(
              color: Colors.white,
           fontSize: screenSize.width /35,
              fontWeight: FontWeight.bold,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 32),
         ElevatedButton(
                        onPressed: () {
                          //context.go('/Our_Services');
                          context.go('/about-us/our-mission&vision&values');
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(170, 45),
                          backgroundColor: const Color(0xff4779A3),
                        ),
                        child: const Text(
                          'Learn more',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xffffffff),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
        ],
      ),
    );
  }
}