
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:solevad/bloc/screen_offset.dart';
import 'package:solevad/model/news.dart';
import 'package:solevad/screen/widget/news_card.dart';
import 'package:solevad/screen/widget/responsive.dart';
import 'package:solevad/screen/widget/text_reveal.dart';
import 'package:animated_text_kit/animated_text_kit.dart';



class SixthSection extends StatefulWidget {
  const SixthSection({super.key});

  @override
  State<SixthSection> createState() => _SixthSectionState();
}

class _SixthSectionState extends State<SixthSection>
    {
 

  final services = [
    // {
    //   "icon": 'assets/images/vector.jpg',
    //   "title": "Sustainable Infrastructure"
    // },
    // {
    //   "icon": 'assets/images/vector2.jpg',
    //   "title": "Renewable Energy Services"
    // },
       {
      "icon": 'assets/images/serve1.png',
      "title": "Solar Development,",
      'index': "1",
    },
    {
      "icon": 'assets/images/serve2.png',
      "title": "Energy Management",
      'index': "2",
    },
    {
      "icon": 'assets/images/serve4.png',
      "title": "Operation and Maintenance",
      'index': "3",

    },
    {
      "icon": 'assets/images/serve3.png',
      "title": "Solar Financing",
      'index': "4",

    },
  ];




  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return  ResponsiveWidget.isSmallScreen(context)
          ?  Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
    decoration: const BoxDecoration(
                 color: Colors.white,
                ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
                cursor: '|'
              ),
            ],
            totalRepeatCount: 2,
            repeatForever: true,
            pause: const Duration(milliseconds: 10000),
            displayFullTextOnTap: true,
            stopPauseOnTap: true,
                    ),
          ),
      
// const SizedBox(height: 30),
//                 Center(
//   child: Container(
//     padding: const EdgeInsets.symmetric(horizontal: 24.0),
//     constraints: const BoxConstraints(maxWidth: 900), // Constrain width for better block layout
//     child: Text(
//       'At Solevad Consulting, we are dedicated to forging meaningful connections that not only drive growth but also promote sustainability across all facets of business and community life. We understand that true impact comes from collaboration and innovation, which is why we prioritize human-centered designs in our approach. By aligning our strategies with the unique needs of our clients and the communities they serve, we empower organizations to thrive while fostering a positive social and environmental footprint. Our commitment to creating these impactful connections ensures that every project contributes to a more sustainable future, benefiting both businesses and the communities they engage with.\n\nWe offer a diverse range of services across three core areas:',
//       textAlign: TextAlign.justify, // This aligns both edges
//       style: TextStyle(
//         fontSize: screenSize.width * 0.028, // Adjusted for readability
//         color: Colors.white,
//         fontWeight: FontWeight.w500,
//         height: 1.8,
//       ),
//     ),
//   ),
// ),
                const SizedBox(height: 40),          // Icons row
         Padding(
           padding: EdgeInsets.only(
            left: screenSize.width /25,
            right: screenSize.width /25,
           ),
           child: Column(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [
               Stack(
                   children: [
                     // Background image container
                     InkWell(
                      onTap: () {
                                                                       context.go('/services/energy-consulting');

                      },
                       child: Container(
                         height: 250,
                         width: screenSize.width *0.75,
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(1),
                           image:  const DecorationImage(
                                   image: AssetImage("assets/images/serve1.png"),
                                   fit: BoxFit.cover,
                           ),
                         ),
                       ),
                     ),
                                 
                     // Blurred bottom overlay
                     Positioned(
                       bottom: 0,
                       left: 0,
                       right: 0,
                       child: InkWell(
                        onTap: () {
                                                                         context.go('/services/energy-consulting');

                        },
                         child: ClipRRect(
                           borderRadius: const BorderRadius.only(
                                   bottomLeft: Radius.circular(1),
                                   bottomRight: Radius.circular(1),
                           ),
                           child: BackdropFilter(
                                   filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                   child: Container(
                                        height: 210 * 0.38, // 10% of height
                                        color: Colors.black.withOpacity(0.1),
                                         child:  Padding(
                                           padding: const EdgeInsets.only(
                                            left: 10,
                                           ),
                                           child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                     const SizedBox(height: 20),          // Icons row
                         Padding(
                           padding: const EdgeInsets.only(
                             right: 10,
                           ),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                                const Text(
                                              'Solar Developmet',
                                 style: TextStyle(
                                   color: Colors.white,
                                   fontWeight: FontWeight.bold,
                                   fontSize: 20,
                                 ),
                               ),
                                InkWell(
                                  onTap: () {
                                            //   context.go('/services/energy-consulting');
                         
                                  },
                                  child: Container(
                                   padding: const EdgeInsets.all(7),
                                   decoration: const BoxDecoration(
                                     color: Color(0xff8B4513),
                                     shape: BoxShape.circle
                                   ),
                                    child: const Center(
                                      child: Icon(
                                       Icons.arrow_forward_ios_sharp,
                                       color: Colors.white,
                                       size: 20,),
                                    ),
                                  ),
                                ),
                           
                             ],
                           ),
                         ),
                                           
                                              ],
                                            ),
                                         ), // transparent but blurred
                                   ),
                           ),
                         ),
                       ),
                     ),
                   ],
                 ),
            const SizedBox(height: 20),          // Icons row
                   Stack(
                   children: [
                     // Background image container
                     InkWell(
                      onTap: () {
                     context.go('/services/community-development');

                      },
                       child: Container(
                         height: 250,
                         width: screenSize.width *0.75,
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(1),
                           image:  const DecorationImage(
                                   image: AssetImage("assets/images/serve2.png"),
                                   fit: BoxFit.cover,
                           ),
                         ),
                       ),
                     ),
                                 
                     // Blurred bottom overlay
                     Positioned(
                       bottom: 0,
                       left: 0,
                       right: 0,
                       child: InkWell(
                        onTap: () {
                           context.go('/services/community-development');
                        },
                         child: ClipRRect(
                           borderRadius: const BorderRadius.only(
                                   bottomLeft: Radius.circular(1),
                                   bottomRight: Radius.circular(1),
                           ),
                           child: BackdropFilter(
                                   filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                   child: Container(
                                        height: 210 * 0.38, // 10% of height
                                        color: Colors.black.withOpacity(0.1),
                                         child:  Padding(
                                           padding: const EdgeInsets.only(
                                            left: 10,
                                           ),
                                           child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                     const SizedBox(height: 20),          // Icons row
                         Padding(
                           padding: const EdgeInsets.only(
                             right: 10,
                           ),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                                const Text(
                                              'Energy Management',
                                 style: TextStyle(
                                   color: Colors.white,
                                   fontWeight: FontWeight.bold,
                                   fontSize: 16,
                                 ),
                               ),
                                InkWell(
                                  onTap: () {
                                context.go('/services/community-development');
                         
                                  },
                                  child: Container(
                                   padding: const EdgeInsets.all(7),
                                   decoration: const BoxDecoration(
                                     color: Color(0xff8B4513),
                                     shape: BoxShape.circle
                                   ),
                                    child: const Center(
                                      child: Icon(
                                       Icons.arrow_forward_ios_sharp,
                                       color: Colors.white,
                                       size: 20,),
                                    ),
                                  ),
                                ),
                           
                             ],
                           ),
                         ),
                                           
                                              ],
                                            ),
                                         ), // transparent but blurred
                                   ),
                           ),
                         ),
                       ),
                     ),
                   ],
                 ),
                             const SizedBox(height: 20),          // Icons row

                   Stack(
                   children: [
                     // Background image container
                     InkWell(
                      onTap: () {
                                      context.go('/services/business-consulting');

                      },
                       child: Container(
                         height: 250,
                         width: screenSize.width *0.75,
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(1),
                           image:  const DecorationImage(
                                   image: AssetImage("assets/images/serve4.png"),
                                   fit: BoxFit.cover,
                           ),
                         ),
                       ),
                     ),
                                 
                     // Blurred bottom overlay
                     Positioned(
                       bottom: 0,
                       left: 0,
                       right: 0,
                       child: InkWell(
                        onTap: () {
                              
              context.go('/services/business-consulting');
               
                        },
                         child: ClipRRect(
                           borderRadius: const BorderRadius.only(
                                   bottomLeft: Radius.circular(1),
                                   bottomRight: Radius.circular(1),
                           ),
                           child: BackdropFilter(
                                   filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                   child: Container(
                                        height: 210 * 0.38, // 10% of height
                                        color: Colors.black.withOpacity(0.1),
                                         child:  Padding(
                                           padding: const EdgeInsets.only(
                                            left: 10,
                                           ),
                                           child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                         const SizedBox(height: 20),
                         Padding(
                           padding: const EdgeInsets.only(
                             right: 10,
                           ),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                                const Text(
                                              'Operation & Maintenance',
                                 style: TextStyle(
                                   color: Colors.white,
                                   fontWeight: FontWeight.bold,
                                   fontSize: 16,
                                 ),
                               ),
                                InkWell(
                                  onTap: () {
                                               context.go('/services/business-consulting');
                         
                                  },
                                  child: Container(
                                   padding: const EdgeInsets.all(7),
                                   decoration: const BoxDecoration(
                                     color: Color(0xff8B4513),
                                     shape: BoxShape.circle
                                   ),
                                    child: const Center(
                                      child: Icon(
                                       Icons.arrow_forward_ios_sharp,
                                       color: Colors.white,
                                       size: 20,),
                                    ),
                                  ),
                                ),
                           
                             ],
                           ),
                         ),
                                           
                                              ],
                                            ),
                                         ), // transparent but blurred
                                   ),
                           ),
                         ),
                       ),
                     ),
                   ],
                 ),
                 
                   Stack(
                   children: [
                     // Background image container
                     InkWell(
                      onTap: () {
                                      context.go('/services/business-consulting');

                      },
                       child: Container(
                         height: 250,
                         width: screenSize.width *0.75,
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(1),
                           image:  const DecorationImage(
                                   image: AssetImage("assets/images/serve3.png"),
                                   fit: BoxFit.cover,
                           ),
                         ),
                       ),
                     ),
                                 
                     // Blurred bottom overlay
                     Positioned(
                       bottom: 0,
                       left: 0,
                       right: 0,
                       child: InkWell(
                        onTap: () {
                              
              context.go('/services/business-consulting');
               
                        },
                         child: ClipRRect(
                           borderRadius: const BorderRadius.only(
                                   bottomLeft: Radius.circular(1),
                                   bottomRight: Radius.circular(1),
                           ),
                           child: BackdropFilter(
                                   filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                   child: Container(
                                        height: 210 * 0.38, // 10% of height
                                        color: Colors.black.withOpacity(0.1),
                                         child:  Padding(
                                           padding: const EdgeInsets.only(
                                            left: 10,
                                           ),
                                           child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                         const SizedBox(height: 20),
                         Padding(
                           padding: const EdgeInsets.only(
                             right: 10,
                           ),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                                const Text(
                                              'Solar Financing',
                                 style: TextStyle(
                                   color: Colors.white,
                                   fontWeight: FontWeight.bold,
                                   fontSize: 20,
                                 ),
                               ),
                                InkWell(
                                  onTap: () {
                                               context.go('/services/business-consulting');
                         
                                  },
                                  child: Container(
                                   padding: const EdgeInsets.all(7),
                                   decoration: const BoxDecoration(
                                     color: Color(0xff8B4513),
                                     shape: BoxShape.circle
                                   ),
                                    child: const Center(
                                      child: Icon(
                                       Icons.arrow_forward_ios_sharp,
                                       color: Colors.white,
                                       size: 20,),
                                    ),
                                  ),
                                ),
                           
                             ],
                           ),
                         ),
                                           
                                              ],
                                            ),
                                         ), // transparent but blurred
                                   ),
                           ),
                         ),
                       ),
                     ),
                   ],
                 ),
             ],
           ),
         ),
        
        ],
      ),
    ):
    
     Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
    decoration: const BoxDecoration(
                color: Colors.white,
                ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
                cursor: '|'
              ),
            ],
            totalRepeatCount: 2,
            repeatForever: true,
            pause: const Duration(milliseconds: 10000),
            displayFullTextOnTap: true,
            stopPauseOnTap: true,
                    ),
          ),
      
// const SizedBox(height: 30),
//                Center(
//   child: Container(
//     padding: const EdgeInsets.symmetric(horizontal: 24.0),
//     constraints: const BoxConstraints(maxWidth: 1300), // Constrain width for better block layout
//     child: Text(
//       'At Solevad Consulting, we are dedicated to forging meaningful connections that not only drive growth but also promote sustainability across all facets of business and community life. We understand that true impact comes from collaboration and innovation, which is why we prioritize human-centered designs in our approach. By aligning our strategies with the unique needs of our clients and the communities they serve, we empower organizations to thrive while fostering a positive social and environmental footprint. Our commitment to creating these impactful connections ensures that every project contributes to a more sustainable future, benefiting both businesses and the communities they engage with.\n\nWe offer a diverse range of services across three core areas:',
//       textAlign: TextAlign.justify, // This aligns both edges
//       style: TextStyle(
//         fontSize: screenSize.width * 0.018, // Adjusted for readability
//         color: Colors.white,
//         fontWeight: FontWeight.w500,
//         height: 1.8,
//       ),
//     ),
//   ),
// ),
                const SizedBox(height: 40),          // Icons row
         SizedBox(
          height: 320,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: services.length,
            separatorBuilder: (_, __) => const SizedBox(width: 1),
            itemBuilder: (context, index) {
              final service = services[index];
              return Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                ),
                child:    Stack(
      children: [
        // Background image container
        InkWell(
          onTap: () {
                if (service["index"]=='1') {
                        context.go('/services/energy-consulting');
                  } else if (service["index"]=='2') {
             context.go('/services/community-development');
                  } else if(service["index"]=='3') {
              context.go('/services/business-consulting');
                  }else {
                    return;
                  }
          },
          child: Container(
            height: 250,
            width: 330,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1),
              image:  DecorationImage(
                image: AssetImage(service["icon"]!),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),

        // Blurred bottom overlay
        Positioned(
          bottom: 50,
          left: 0,
          right: 0,
          child: InkWell(
            onTap: () {
                  if (service["index"]=='1') {
                        context.go('/services/energy-consulting');
                  } else if (service["index"]=='2') {
             context.go('/services/community-development');
                  } else if(service["index"]=='3') {
              context.go('/services/business-consulting');
                  }else {
                    return;
                  }
            },
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(1),
                bottomRight: Radius.circular(1),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  height: 210 * 0.38, // 10% of height
                  color: Colors.black.withOpacity(0.1),
                   child:  Padding(
                     padding: const EdgeInsets.only(
                      left: 10,
                     ),
                     child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 12),
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                 Text(
                        service["title"]!,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                 InkWell(
                                  onTap: () {
                                                 if (service["index"]=='1') {
                        context.go('/services/energy-consulting');
                  } else if (service["index"]=='2') {
             context.go('/services/community-development');
                  } else if(service["index"]=='3') {
              context.go('/services/business-consulting');
                  }else {
                    return;
                  }
                                  },
                                   child: Container(
                                    padding: const EdgeInsets.all(7),
                                    decoration: const BoxDecoration(
                                      color: Color(0xff8B4513),
                                      shape: BoxShape.circle
                                    ),
                                     child: const Center(
                                       child: Icon(
                                        Icons.arrow_forward_ios_sharp,
                                        color: Colors.white,
                                        size: 20,),
                                     ),
                                   ),
                                 ),
                            
                              ],
                            ),
                          ),
                     
                        ],
                      ),
                   ), // transparent but blurred
                ),
              ),
            ),
          ),
        ),
      ],
    ),
                
                
                // Column(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                // CircleAvatar(
                //   backgroundImage:  AssetImage(service["icon"]!),
                // radius: 70,
                // ),
                //                         const SizedBox(height: 12),
                //     Text(
                //       service["title"]!,
                //       textAlign: TextAlign.center,
                //       style:  const TextStyle(
                //               color: Colors.white,
                //            fontSize: 16,
                //               fontWeight: FontWeight.w500,
                //               height: 1.4,
                //             ),
                //     ),
                //   ],
                // ),
              );
            },
          ),
        ),
        //   const SizedBox(height: 32),
        //  ElevatedButton(
        //                 onPressed: () {
        //                   //context.go('/Our_Services');
        //                   context.go('/services');
        //                 },
        //                 style: ElevatedButton.styleFrom(
        //                    shape: RoundedRectangleBorder(
        //                     borderRadius: BorderRadius.circular(1),
        //                   ),
        //                   fixedSize: const Size(170, 45),
        //                   backgroundColor: const Color(0xff4779A3),
        //                 ),
        //                 child: const Text(
        //                   'Learn more',
        //                   style: TextStyle(
        //                     fontSize: 13,
        //                     color: Color(0xffffffff),
        //                     fontWeight: FontWeight.bold,
        //                   ),
        //                 ),
        //               ),
        ],
      ),
    );
  }
}
