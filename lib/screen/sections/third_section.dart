
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:oavltd/bloc/screen_offset.dart';
import 'package:oavltd/screen/widget/text_reveal.dart';

class ThirdSection extends StatefulWidget {
  const ThirdSection({super.key});

  @override
  State<ThirdSection> createState() => _ThirdSectionState();
}

class _ThirdSectionState extends State<ThirdSection>
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
        if (current.scrollOffsetValue > 1200 || controller.isAnimating) {
          return true;
        } else {
          return false;
        }
      },
      builder: (context, state) {
        if (state.scrollOffsetValue > 1200) {
          controller.forward();
        } else {
          controller.reverse();
        }
        return Row(
          children: [
            Flexible(
              flex: 1,
              child: SlideTransition(
                position: offsetImage,
                child: Image.asset(
                  'assets/images/Frame 29.png',
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.1,
            ),
            Flexible(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: screenSize.width /30,
                      ),
                      TextReveal(
                        maxHeight: 50,
                        controller: controller,
                        child: Text(
                          'About us',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'CH',
                            fontWeight: FontWeight.w500,
                            color: Colors.blueGrey[900],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextReveal(
                        maxHeight: 50,
                        controller: controller,
                        child:  Text(
                          'Major Player',
                          style: TextStyle(
                            fontSize: screenSize.width /30,
                            fontFamily: 'CH',
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextReveal(
                        maxHeight: screenSize.width /10,
                        controller: controller,
                        child:  Text(
                          'player in Nigeria’s livestock sector',
                          style: TextStyle(
                            fontSize: screenSize.width /30,
                            fontFamily: 'CH',
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SlideTransition(
                        position: transform,
                        // opacity: subTextOpacityAnimation,
                        child: Text(
                          'Committed to providing high-quality agro-inputs and innovative solutions to boost productivity and food security.',
                          style: TextStyle(
                            fontFamily: 'CH',
                            fontSize: screenSize.width /60,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextReveal(
                        maxHeight: 50,
                        controller: controller,
                        child:  ElevatedButton(
                        onPressed: () {
                                                                          context.go('/Our_Services');

                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                            fixedSize: const Size(150, 50),
                            backgroundColor:  Colors.blueGrey[900],),
                        child: const Text(
                          'Learn more  >>',
                          style: TextStyle(
                            fontFamily: 'CH',
                            fontSize: 13,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
