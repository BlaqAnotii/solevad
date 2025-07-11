
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:solevad/screen/widget/responsive.dart';

class FifthSection extends StatefulWidget {
  const FifthSection({super.key});

  @override
  State<FifthSection> createState() => _FifthSectionState();
}

class _FifthSectionState extends State<FifthSection>
     {
  
   final List<Map<String, String>> testimonials = [
    {
      "quote":
          "Energy Edge helped Collin College develop a comprehensive procurement strategy consistent with our risk tolerance and business needs that resulted in a significant reduction in energy spend.",
      "name": "Cindy White",
      "position": "Director of Procurement, Collin College"
    },
    {
      "quote":
          "Energy Edge provided us with expert insights and strategies that saved our company thousands in energy costs while ensuring sustainability.",
      "name": "John Doe",
      "position": "CEO, Green Energy Inc."
    },
    {
      "quote":
          "Their expertise and guidance helped us navigate complex energy contracts with confidence, securing the best possible rates.",
      "name": "Sarah Thompson",
      "position": "Head of Operations, Bright Future Corp."
    },
  ];

  @override
  Widget build(BuildContext context) {
                var screenSize = MediaQuery.of(context).size;

      

    return ResponsiveWidget.isSmallScreen(context)
        ? Container(
            height: 600,
           decoration: const BoxDecoration(
  image: DecorationImage(
                    image: AssetImage('assets/images/black.jpg',),
                    fit: BoxFit.cover,
                   
                  ),
),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         const Text(
                    'TESTIMONIALS',
                    style: TextStyle(
                      fontSize: 22,
              color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),

                        Column(
                        children: [
                         
                           CarouselSlider(
                                  options: CarouselOptions(
                                    height: 250, // Adjust height as needed
                                    autoPlay: true,
                                    enlargeCenterPage: true,
                                    viewportFraction: 0.9,
                                    autoPlayInterval: const Duration(seconds: 3),
                                  ),
                                  items: testimonials.map((testimonial) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            '"${testimonial["quote"]}"',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontStyle: FontStyle.italic,
                                              color: Colors.white,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            '- ${testimonial["name"]}',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
              color: Colors.white70,
                                            ),
                                          ),
                                          Text(
                                            testimonial["position"]!,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Color(0xff32CD32),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                        ],
                                                  ),
                      ],
                    ),
            
          )
        : Container(
            height: 400,
            decoration: const BoxDecoration(
  image: DecorationImage(
                    image: AssetImage('assets/images/black.jpg',),
                    fit: BoxFit.cover,
                   
                  ),
),
                  child:   Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         const Text(
                    'TESTIMONIALS',
                    style: TextStyle(
                      fontSize: 30,
              color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),

                        Column(
                          children: [
                           
                             CarouselSlider(
                                  options: CarouselOptions(
                                    height: 250, // Adjust height as needed
                                    autoPlay: true,
                                    enlargeCenterPage: true,
                                    viewportFraction: 0.9,
                                    autoPlayInterval: const Duration(seconds: 3),
                                  ),
                                  items: testimonials.map((testimonial) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            '"${testimonial["quote"]}"',
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontStyle: FontStyle.italic,
                                              color: Colors.white,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            '- ${testimonial["name"]}',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
              color: Colors.white70,
                                            ),
                                          ),
                                          Text(
                                            testimonial["position"]!,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Color(0xff32CD32),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                          ],
                        ),
                      ],
                    ),
           );
    
    
  }
}
