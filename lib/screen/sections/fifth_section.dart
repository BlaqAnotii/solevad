
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:oavltd/bloc/screen_offset.dart';
import 'package:oavltd/constant/color.dart';
import 'package:oavltd/screen/widget/plan_item.dart';
import 'package:oavltd/screen/widget/text_reveal.dart';

class FifthSection extends StatefulWidget {
  const FifthSection({super.key});

  @override
  State<FifthSection> createState() => _FifthSectionState();
}

class _FifthSectionState extends State<FifthSection>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> imageRevealAnimation;
  late Animation<double> textRevealAnimation;
  late Animation<double> planAnimation;
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

    imageRevealAnimation = Tween<double>(begin: 500.0, end: 1.0).animate(
        CurvedAnimation(
            parent: controller,
            curve: const Interval(1.0, 0.40, curve: Curves.easeOut)));

    textRevealAnimation = Tween<double>(begin: 70.0, end: 1.0).animate(
        CurvedAnimation(
            parent: controller,
            curve: const Interval(0.30, 0.60, curve: Curves.easeOut)));

    planAnimation = Tween<double>(begin: 1.0, end: 1.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
    offsetImage =
        Tween<Offset>(begin: const Offset(-1, 0), end: const Offset(0, 0))
            .animate(CurvedAnimation(parent: controller, curve: Curves.ease));
    transform =
        Tween<Offset>(begin: const Offset(10, 0), end: const Offset(0, 0))
            .animate(CurvedAnimation(parent: controller, curve: Curves.ease));

    subImageRevealAnimation = Tween<double>(begin: 1.0, end: 90.0).animate(
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
        if ((current.scrollOffsetValue >= 1200 &&
                current.scrollOffsetValue <= 2600) ||
            controller.isAnimating) {
          return true;
        } else {
          return false;
        }
      },
      builder: (context, state) {
        //print(state.scrollOffsetValue);
        if (state.scrollOffsetValue > 1200.0) {
          //print(state.scrollOffsetValue);
          controller.forward();
        } else {
          controller.reverse();
        }
        return 
        
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: AnimatedBuilder(
                animation: textRevealAnimation,
                builder: (context, child) {
                  return Padding(
                    padding: EdgeInsets.only(left: screenSize.width /50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextReveal(
                          maxHeight:  screenSize.width /10,
                          controller: controller,
                          child:  Text(
                            'PRICE',
                            style: TextStyle(
                              fontSize:  screenSize.width /30,
                              fontFamily: 'CH',
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        TextReveal(
                          maxHeight:  screenSize.width /10,
                          controller: controller,
                          child:  Text(
                            'Flexible Pricing ',
                            style: TextStyle(
                              fontSize:  screenSize.width /30,
                              fontFamily: 'CH',
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        TextReveal(
                          maxHeight:  screenSize.width /10,
                          controller: controller,
                          child:  Text(
                            'for Every Product and Service',
                            style: TextStyle(
                              fontSize:  screenSize.width /30,
                              fontFamily: 'CH',
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        TextReveal(
                          maxHeight:  screenSize.width /10,
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
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    planCard(
                      planAnimation,
                      Colors.black,
                      AppColors.scaffoldColor,
                      Colors.black,
                      'Starting From',
                      'NGN 6000',
                      context
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                     planCard(
                      planAnimation,
                      Colors.black,
                      AppColors.scaffoldColor,
                      Colors.black,
                      'Starting From',
                      'NGN 6000',
                      context
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
