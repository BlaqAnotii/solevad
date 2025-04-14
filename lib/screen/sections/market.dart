import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Market extends StatefulWidget {
  const Market({super.key});

  @override
  State<Market> createState() => _MarketState();
}

class _MarketState extends State<Market> {
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
            "Market Overview",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
           Text(
            "The demand for solar energy in Nigeria is growing rapidly due to\nchallengesin the national power supply and rising fossil fuel costs",
            style: TextStyle(
              color: Colors.white,
           fontSize: screenSize.width /38,
              fontWeight: FontWeight.bold,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 32),
         ElevatedButton(
                        onPressed: () {
                          //context.go('/Our_Services');
                          //context.go('/contact_us');
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