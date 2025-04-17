
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:solevad/screen/widget/responsive.dart';

class SeventhSection extends StatefulWidget {
  const SeventhSection({super.key});

  @override
  State<SeventhSection> createState() => _SeventhSectionState();
}

class _SeventhSectionState extends State<SeventhSection> {
  @override
  Widget build(BuildContext context) {
   return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 100,
          ),
          ResponsiveWidget.isSmallScreen(context)
          ? 
          Column(
            children: [
             
          AboutCard(
            imagePath: 'assets/images/management.png',
            title: 'Leadership',
            description:
                'Solevad Energy’s team is built on a foundation of technical excellence, industry expertise, and a shared vision for a sustainable future.',
            linkText: 'Learn More', index: 1,
          ),
              const SizedBox(height: 30),
              AboutCard(
                imagePath: 'assets/images/aboutus3.png',
                title: 'Our Vision',
                description:
                    'To become the foremost partner for solar energy solutions across Sub-Saharan Africa. , driven by strategic alliances with global leaders in technology',
                linkText: 'Learn More', index: 2,
              ),
              const SizedBox(height: 30),
              AboutCard(
                imagePath: 'assets/images/aboutus4.png',
                title: 'Our Mission',
                description:
                    'To revolutionize energy accessibility by delivering innovative, sustainable solar solutions that exceed client expectations.',
                linkText: 'Learn More', index: 3,
              ),
      
          ],)
          // Row of Cards
        
        :
           Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: AboutCard(
                  imagePath: 'assets/images/management.png',
                  title: 'Leadership',
                  description:
                      'Solevad Energy’s team is built on a foundation of technical excellence, industry expertise, and a shared vision for a sustainable future.',
                  linkText: 'Learn More',
                  index: 1,
                ),
              ),
              const SizedBox(width: 30),
              Expanded(
                child: AboutCard(
                  imagePath: 'assets/images/aboutus3.png',
                  title: 'Our Vision',
                  description:
                      'To become the foremost partner for solar energy solutions across Sub-Saharan Africa. , driven by strategic alliances with global leaders in technology',
                  linkText: 'Learn More', index: 2,
                ),
              ),
              const SizedBox(width: 30),
              Expanded(
                child: AboutCard(
                  imagePath: 'assets/images/aboutus4.png',
                  title: 'Our Mission',
                  description:
                      'To revolutionize energy accessibility by delivering innovative, sustainable solar solutions that exceed client expectations.',
                  linkText: 'Learn More', index: 3,
                ),
              ),
            ],
          )
        ]
      ),
    );
  }
}


class AboutCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final String linkText;
    int index;


   AboutCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.linkText,
        required this.index,

  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with overlay title
          Stack(
            children: [
              ColorFiltered(
                colorFilter: ColorFilter.mode(
        Colors.black.withOpacity(0.4), // Adjust opacity
        BlendMode.darken,
      ),
                child: Image.asset(
                  imagePath,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                
                  
                ),
              ),
              Positioned(
                bottom: 12,
                left: 12,
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                        color:Colors.white,
                    shadows: [
                      Shadow(blurRadius: 4, color: Colors.black45),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Description and link
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () {
                      if (index == 1) {
        context.go('/about-us/our-team');
      } else if (index == 2) {
        context.go('/about-us/our-mission&vision&values');
      } else if(index == 3) {
        context.go('/about-us/our-mission&vision&values');
      }else {
        return;
      }
                    },
                    child: Text(
                      linkText,
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}