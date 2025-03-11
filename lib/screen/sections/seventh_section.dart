
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:oavltd/constant/color.dart';
import 'package:oavltd/screen/widget/text_reveal.dart';

import '../../bloc/screen_offset.dart';

class SeventhSection extends StatefulWidget {
  const SeventhSection({super.key});

  @override
  State<SeventhSection> createState() => _SeventhSectionState();
}

class _SeventhSectionState extends State<SeventhSection>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> imageRevealAnimation;
  late Animation<double> textRevealAnimation;
  late Animation<double> subTextOpacityAnimation;
  late Animation<double> subImageRevealAnimation;
  late Animation<Offset> offsetImage;
  late Animation<Offset> transform;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1700,
      ),
      reverseDuration: const Duration(
        milliseconds: 375,
      ),
    );

    imageRevealAnimation = Tween<double>(begin: 500.0, end: 0.0).animate(
        CurvedAnimation(
            parent: controller,
            curve: const Interval(0.0, 0.40, curve: Curves.easeOut)));

    textRevealAnimation = Tween<double>(begin: 70.0, end: 0.0).animate(
        CurvedAnimation(
            parent: controller,
            curve: const Interval(0.30, 0.60, curve: Curves.easeOut)));

    subTextOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: controller,
            curve: const Interval(0.50, 0.80, curve: Curves.easeOut)));
    offsetImage =
        Tween<Offset>(begin: const Offset(-1, 0), end: const Offset(0, 0))
            .animate(CurvedAnimation(parent: controller, curve: Curves.ease));
    transform =
        Tween<Offset>(begin: const Offset(10, 0), end: const Offset(0, 0))
            .animate(CurvedAnimation(parent: controller, curve: Curves.ease));

    subImageRevealAnimation = Tween<double>(begin: 0.0, end: 90.0).animate(
        CurvedAnimation(
            parent: controller,
            curve: const Interval(0.70, 1.0, curve: Curves.easeOut)));

    super.initState();
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

    return BlocBuilder<DisplayOffset, ScrollOffset>(
      buildWhen: (previous, current) {
        if ((current.scrollOffsetValue > 3400 &&
                current.scrollOffsetValue < 4000) ||
            controller.isAnimating) {
          return true;
        } else {
          return false;
        }
      },
      builder: (context, state) {
        if (state.scrollOffsetValue >= 3550 &&
            state.scrollOffsetValue <= 4200) {
          controller.forward();
        } else {
          controller.reverse();
        }
        return AnimatedBuilder(
          animation: textRevealAnimation,
          builder: (context, child) {
            return Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 350,
                  decoration:  BoxDecoration(
                    color: Colors.blueGrey[900],
                  ),
                ),
                Positioned(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextReveal(
                          controller: controller,
                          maxHeight: 80,
                          child: const Text(
                            'Start Your Farming Journey With Us',
                            style: TextStyle(
                              fontFamily: 'CH',
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextReveal(
                          maxHeight: screenSize.width /10,
                          controller: controller,
                          child:  const Text(
                            'Onoseke-vwe Agro Ventures Ltd culture is centered on integrity, delivering exceptional quality, fostering innovation, and focusing on meeting customer needs',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'CH',
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        
                        TextReveal(
                            maxHeight: 80,
                            controller: controller,
                            child: ElevatedButton(
                              onPressed: () {
                                                                                context.go('/Our_Services');

                              },
                              style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(150, 50),
                                  backgroundColor: Colors.white,
                                  side: const BorderSide(
                                      color: AppColors.darkColor)),
                              child: const Text(
                                'Learn more',
                                style: TextStyle(
                                  fontFamily: 'CH',
                                  fontSize: 13,
                                  color: AppColors.darkColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
                AnimatedPositioned(
                  curve: Curves.easeInCubic,
                  top: (state.scrollOffsetValue > 3600) ? 10 : 300,
                  right: (state.scrollOffsetValue > 3600) ? 250 : 200,
                  duration: const Duration(milliseconds: 900),
                  child: Image.asset(
                    'assets/images/earth1.png',
                    height: 100,
                  ),
                ),
                AnimatedPositioned(
                  curve: Curves.easeInOutQuart,
                  top: (state.scrollOffsetValue > 3700) ? 200 : 10,
                  right: (state.scrollOffsetValue > 3700) ? 100 : 20,
                  duration: const Duration(milliseconds: 1300),
                  child: Image.asset(
                    'assets/images/earth2.png',
                    height: 100,
                  ),
                ),
                AnimatedPositioned(
                  curve: Curves.easeOutCirc,
                  bottom: (state.scrollOffsetValue > 3700) ? 240 : 0,
                  left: (state.scrollOffsetValue > 3700) ? 100 : 250,
                  duration: const Duration(milliseconds: 1300),
                  child: Image.asset(
                    'assets/images/earth3.png',
                    height: 100,
                  ),
                ),
                AnimatedPositioned(
                  curve: Curves.easeOutCirc,
                  bottom: (state.scrollOffsetValue > 3730) ? 0 : 0,
                  left: (state.scrollOffsetValue > 3730) ? 80 : 0,
                  duration: const Duration(milliseconds: 1600),
                  child: Image.asset(
                    'assets/images/earth4.png',
                    height: 100,
                  ),
                )
              ],
            );
          },
        );
      },
    );
  }
}
