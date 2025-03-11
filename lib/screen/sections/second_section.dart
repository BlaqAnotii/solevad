
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oavltd/constant/color.dart';
import 'package:oavltd/screen/widget/responsive.dart';
import 'package:oavltd/screen/widget/text_transform.dart';


class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen>
    with SingleTickerProviderStateMixin {
   late AnimationController controller;
  late Animation<double> textRevealAnimation;
  late Animation<double> textOpacityAnimation;
  late Animation<double> descriptionAnimation;
  
  @override
  void initState() {
    // TODO: implement initState
    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1700,
      ),
      reverseDuration: const Duration(
        milliseconds: 375,
      ),
    );

    textRevealAnimation = Tween<double>(begin: 60.0, end: 0.0).animate(
        CurvedAnimation(
            parent: controller,
            curve: const Interval(0.0, 0.2, curve: Curves.easeOut)));

    textOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: controller,
            curve: const Interval(0.0, 0.3, curve: Curves.easeOut)));
    Future.delayed(const Duration(milliseconds: 1000), () {
      controller.forward();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
                var screenSize = MediaQuery.of(context).size;

    return ResponsiveWidget.isSmallScreen(context)
          ? 
   const  SizedBox()
   : Column(
      children: [
         const SizedBox(
                    height: 40,
                  ),
        Container(
          color: AppColors.scaffoldColor,
          // decoration: BoxDecoration(),
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: screenSize.width/30),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              decoration:  BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                shape: BoxShape.rectangle,
                color: Colors.blueGrey[900],
              ),
              child:  
                           Center(
                             child: TextTransform(
                                                 controller: controller,
                                                 textOpacityAnimation: textOpacityAnimation,
                                                 //textRevealAnimation: textRevealAnimation,
                                                 maxHeight: 100,
                                                 child:  Text(
                                                   'Serviced Over 10,000+ Farmers',
                                                   style: TextStyle(
                                                       fontFamily: 'CH',
                                                       fontSize: screenSize.width/60,
                                                       color: Colors.white,
                                                       fontWeight: FontWeight.w500),
                                                 ),
                                               ),
                           ),              
              
            ),
          ),
        ),
      ],
    );
  }
}
