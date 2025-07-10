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
          const SizedBox(height: 100),
          ResponsiveWidget.isSmallScreen(context)
              ? Column(
                  children: [
                    AboutCard(
                      imagePath: 'assets/images/management.png',
                      title: 'Leadership',
                      description:
                          'Solevad Energy’s team is built on a foundation of technical excellence, industry expertise, and a shared vision for a sustainable future.',
                      linkText: 'Learn More',
                      index: 1,
                    ),
                    const SizedBox(height: 30),
                    AboutCard(
                      imagePath: 'assets/images/aboutus3.png',
                      title: 'Our Vision',
                      description:
                          'To become the foremost partner for solar energy solutions across Sub-Saharan Africa., driven by strategic alliances with global leaders in technology',
                      linkText: 'Learn More',
                      index: 2,
                    ),
                    const SizedBox(height: 30),
                    AboutCard(
                      imagePath: 'assets/images/aboutus4.png',
                      title: 'Our Mission',
                      description:
                          'To revolutionize energy accessibility by delivering innovative, sustainable solar solutions that exceed client expectations.',
                      linkText: 'Learn More',
                      index: 3,
                    ),
                  ],
                )
              : const IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      SizedBox(width: 30),
                      Expanded(
                        child: AboutCard(
                          imagePath: 'assets/images/aboutus3.png',
                          title: 'Our Vision',
                          description:
                              'To become the foremost partner for solar energy solutions across Sub-Saharan Africa., driven by strategic alliances with global leaders in technology',
                          linkText: 'Learn More',
                          index: 2,
                        ),
                      ),
                      SizedBox(width: 30),
                      Expanded(
                        child: AboutCard(
                          imagePath: 'assets/images/aboutus4.png',
                          title: 'Our Mission',
                          description:
                              'To revolutionize energy accessibility by delivering innovative, sustainable solar solutions that exceed client expectations.',
                          linkText: 'Learn More',
                          index: 3,
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}

class AboutCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final String linkText;
  final int index;

  const AboutCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.linkText,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.go('/about-us');
      },
      child: Card(
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.4),
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
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(blurRadius: 4, color: Colors.black45),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      constraints: const BoxConstraints(maxWidth: 800),
                      child: Text(
                        description,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontSize: 14,
                          height: 1.5,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
