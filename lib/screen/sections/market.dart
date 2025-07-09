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

    return 
    Container(
  width: double.infinity,
  margin: const EdgeInsets.only(top: 70),
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
    decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/black.jpg',),
                    fit: BoxFit.cover,
                   
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
 
           Container(
           //  padding: const EdgeInsets.symmetric(horizontal: 24.0),
             constraints: const BoxConstraints(maxWidth: 1200), // Constrain width for better block layout
             child: Text(
               'The demand for solar energy in Nigeria is growing rapidly due to challenges in the national power supply and rising fossil fuel costs.',
               textAlign: TextAlign.justify, // This aligns both edges
               style: TextStyle(
                 fontSize: screenSize.width * 0.028, // Adjusted for readability
                 color: Colors.white,
                 fontWeight: FontWeight.w500,
                 height: 1.3,
               ),
             ),
           ),
          const SizedBox(height: 32),
         ElevatedButton(
                        onPressed: () {
                          //context.go('/Our_Services');
                                context.go('/about-us');
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