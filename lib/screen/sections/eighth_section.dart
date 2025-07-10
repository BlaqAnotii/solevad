
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:solevad/bloc/screen_offset.dart';
import 'package:solevad/screen/widget/responsive.dart';
import 'package:solevad/screen/widget/text_reveal.dart';

class EighthSection extends StatefulWidget {
  const EighthSection({super.key});

  @override
  State<EighthSection> createState() => _EighthSectionState();
}

class _EighthSectionState extends State<EighthSection>
     {
  // late AnimationController controller;
  // late Animation<double> imageRevealAnimation;
  // late Animation<double> textRevealAnimation;
  // late Animation<double> textRevealEndAnimation;
  // late Animation<double> subTextOpacityAnimation;
  // late Animation<double> subImageRevealAnimation;
  // late Animation<Offset> offsetImage;
  // late Animation<Offset> transform;

  // @override
  // void initState() {
  //   controller = AnimationController(
  //     vsync: this,
  //     duration: const Duration(
  //       milliseconds: 1700,
  //     ),
  //     reverseDuration: const Duration(
  //       milliseconds: 375,
  //     ),
  //   );

  //   imageRevealAnimation = Tween<double>(begin: 500.0, end: 1.0).animate(
  //       CurvedAnimation(
  //           parent: controller,
  //           curve: const Interval(0.30, 0.40, curve: Curves.easeOut)));

  //   textRevealAnimation = Tween<double>(begin: 70.0, end: 1.0).animate(
  //       CurvedAnimation(
  //           parent: controller,
  //           curve: const Interval(0.30, 0.60, curve: Curves.easeOut)));

  //   textRevealEndAnimation = Tween<double>(begin: 1.0, end: 100.0).animate(
  //       CurvedAnimation(
  //           parent: controller,
  //           curve: const Interval(0.30, 0.60, curve: Curves.easeOut)));
  //   subTextOpacityAnimation = Tween<double>(begin: 1.0, end: 1.0).animate(
  //       CurvedAnimation(
  //           parent: controller,
  //           curve: const Interval(0.50, 0.80, curve: Curves.easeOut)));
  //   offsetImage =
  //       Tween<Offset>(begin: const Offset(-1, 0), end: const Offset(0, 0))
  //           .animate(CurvedAnimation(parent: controller, curve: Curves.ease));
  //   transform =
  //       Tween<Offset>(begin: const Offset(10, 0), end: const Offset(0, 0))
  //           .animate(CurvedAnimation(parent: controller, curve: Curves.ease));

  //   subImageRevealAnimation = Tween<double>(begin: 0.0, end: 90.0).animate(
  //       CurvedAnimation(
  //           parent: controller,
  //           curve: const Interval(0.70, 1.0, curve: Curves.easeOut)));

  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
               var screenSize = MediaQuery.of(context).size;

    return  ResponsiveWidget.isSmallScreen(context)
          ? 
              Padding(
       padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   const Center(
                     child: Text(
                       'Message from the Group CEO',
                       style: TextStyle(
                         fontSize: 26,
                         fontWeight: FontWeight.w700,
                       ),
                     ),
                   ),
                   const SizedBox(height: 20),
                    Center(
                     child: Container(
                                   constraints: const BoxConstraints(maxWidth: 1000), // Constrain width for better block layout

                       child: const Text(
                         "Our organization is composed of highly competent engineers, experienced project managers, and experts in renewable energy, all of whom share a fervent commitment to sustainability  and innovation. We collaborate effectively to deliver optimal solutions tailored to our clients' needs.",
                                        textAlign: TextAlign.justify, // This aligns both edges

                         style: TextStyle(
                           fontSize: 16,
                           height: 1.6,
                         ),
                       ),
                     ),
                   ),
                                      const SizedBox(height: 30),
 Center(
   child: ClipRRect(
                       borderRadius: BorderRadius.circular(5),
                       child: Image.asset(
                         'assets/images/leroy.jpg', // Replace with your image path
                         width: 350,
                         height: 350,
                         fit: BoxFit.cover,
                       ),
                     ),
 ),
                   const SizedBox(height: 15),
                   const Center(
                     child: Text(
                       'Mr. Leroy Ahwinahwi (CEO)',
                       style: TextStyle(
                         fontSize: 17,
                         fontWeight: FontWeight.w700,
                         color: Colors.black87,
                       ),
                     ),
                   ),
                 ],
               ),
             )
             :
       Padding(
       padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 50),
         child: Row(
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             // Left: Text Content
             const Expanded(
              flex: 3,
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text(
                     'Message from the Group CEO',
                     style: TextStyle(
                       fontSize: 26,
                       fontWeight: FontWeight.w700,
                     ),
                   ),
                   SizedBox(height: 20),
                        
                     Text(
                       'Our organization is composed of highly competent engineers, experienced project managers, and experts in renewable energy, all of whom share a fervent commitment to sustainability and innovation. We collaborate effectively to deliver optimal solutions tailored to our clients needs.',
                       textAlign: TextAlign.justify, // This aligns both edges
                       style: TextStyle(
                         fontSize: 20, // Adjusted for readability
                         color: Colors.black,
                         fontWeight: FontWeight.w500,
                         height: 1.3,
                       ),
                     ),
                 ],
               ),
             ),
         
             const SizedBox(width: 40),
         
             // Right: CEO Image and Name
             Expanded(
               flex: 1,
               child: Column(
                 children: [
                   ClipRRect(
                     borderRadius: BorderRadius.circular(5),
                     child: Image.asset(
                       'assets/images/leroy.jpg', // Replace with your image path
                       width: 450,
                       height: 350,
                       fit: BoxFit.contain,
                     ),
                   ),
                   const SizedBox(height: 15),
                   const Text(
                     'Mr. Leroy Ahwinahwi (CEO)',
                     style: TextStyle(
                       fontSize: 17,
                       fontWeight: FontWeight.w700,
                       color: Colors.black87,
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
