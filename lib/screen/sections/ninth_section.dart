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
            "Our Core Values",
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
               'We are driven by sustainability, grounded in integrity, inspired by innovation, committed to customer focus, and dedicated to excellence in all we do.',
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