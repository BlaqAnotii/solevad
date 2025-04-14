import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:solevad/model/bottom_bar_column.dart';
import 'package:solevad/model/info_text.dart';

import 'package:solevad/screen/widget/responsive.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    ResponsiveWidget.isSmallScreen(context)
          ?

          Container(
      height: 600,
  padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
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
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      // Top row
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left: Stay Connected
          const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Stay Connected",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 18),
              Text(
                "Stay updated on new developments and progress with Solevad Energy.",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 22,
                ),
              ),
            ],
          ),
              SizedBox(height: 18),

          // Right: Newsletter input
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Join our bi-monthly newsletter!",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 30),
              Container(
                height: 45,
                width: 270,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 15),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Enter your email here",
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.grey[500]),
                        ),
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: const Color(0xff4779A3),// Purple button
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () {
                          // Send logic
                        },
                        icon: const Icon(Icons.arrow_forward, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Social icons
              Padding(
                padding: const EdgeInsets.only(
                  right: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Brand(Brands.facebook, size: 25),),
                                    const SizedBox(width: 5),

Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Brand(Brands.linkedin, size: 25),), 
                                    const SizedBox(width: 5),

Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Brand(Brands.instagram, size: 25),), 
                                                          const SizedBox(width: 5),
   
Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Brand(Brands.tiktok, size: 25),),
                                                          const SizedBox(width: 5),

Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Brand(Brands.twitterx, size: 25),) ,
 
                                  ],
                ),
              ),
            ],
          ),
        ],
      ),

      const SizedBox(height: 80),
      const Divider(color: Colors.white30),
      const SizedBox(height: 10),

      // Bottom bar
      const Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "© 2025 Solevad Energy. Copyright and rights reserved",
            style: TextStyle(color: Colors.white70, fontSize: 15),
          ),
                 SizedBox(height: 10),

          Text(
            "Terms and Conditions . Privacy Policy",
            style: TextStyle(color: Colors.white70, fontSize: 15),
          ),
        ],
      )
    ],
  ),
)
          :
    Container(
      height: 400,
  padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
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
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      // Top row
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left: Stay Connected
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Stay Connected",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 18),
                Text(
                  "Stay updated on new developments and progress\nwith Solevad Energy.",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
          ),

          // Right: Newsletter input
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                "Join our bi-monthly newsletter!",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 30),
              Container(
                height: 45,
                width: 270,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 15),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Enter your email here",
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.grey[500]),
                        ),
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: const Color(0xff4779A3),// Purple button
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () {
                          // Send logic
                        },
                        icon: const Icon(Icons.arrow_forward, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Social icons
              Padding(
                padding: const EdgeInsets.only(
                  right: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Brand(Brands.facebook, size: 25),),
                                    const SizedBox(width: 5),

Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Brand(Brands.linkedin, size: 25),), 
                                    const SizedBox(width: 5),

Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Brand(Brands.instagram, size: 25),), 
                                                          const SizedBox(width: 5),
   
Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Brand(Brands.tiktok, size: 25),),
                                                          const SizedBox(width: 5),

Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Brand(Brands.twitterx, size: 25),) ,
 
                                  ],
                ),
              ),
            ],
          ),
        ],
      ),

      const SizedBox(height: 80),
      const Divider(color: Colors.white30),
      const SizedBox(height: 10),

      // Bottom bar
      const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "© 2025 Solevad Energy. Copyright and rights reserved",
            style: TextStyle(color: Colors.white70, fontSize: 15),
          ),
          Text(
            "Terms and Conditions . Privacy Policy",
            style: TextStyle(color: Colors.white70, fontSize: 15),
          ),
        ],
      )
    ],
  ),
);
 
  }
}
