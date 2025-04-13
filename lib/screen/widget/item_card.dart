import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solevad/bloc/screen_offset.dart';

class ItemCard extends StatefulWidget {
  final String image;
  final String title;
  final String subtitle;
  const ItemCard(
      {required this.image,
      required this.subtitle,
      required this.title,
      super.key});

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard>
    with SingleTickerProviderStateMixin {
  bool isHovered = false;

  late AnimationController controller;

  late Animation<double> imageReveal;
  late Animation<double> imageOpacity;
  late Animation<double> headingTextOpacity;
  late Animation<double> subTextOpacity;
  late Animation<double> descriptionOpacity;
  @override
  void initState() {
    controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1700),
        reverseDuration: const Duration(milliseconds: 375));

    imageReveal = Tween<double>(begin: 500.0, end: 200.0).animate(
        CurvedAnimation(
            parent: controller,
            curve: const Interval(0.0, 0.40, curve: Curves.easeInOutCubic)));

    imageOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 1, curve: Curves.easeOut)));

    headingTextOpacity = Tween<double>(begin: 70.0, end: 1.0).animate(
        CurvedAnimation(
            parent: controller,
            curve: const Interval(0.60, 0.80, curve: Curves.easeOut)));

    subTextOpacity = Tween<double>(begin: 1.0, end: 1.0).animate(
        CurvedAnimation(
            parent: controller,
            curve: const Interval(0.6, 0.8, curve: Curves.easeOut)));

    descriptionOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: controller,
            curve: const Interval(0.6, 0.8, curve: Curves.easeOut)));

    // priceOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
    //     parent: controller,
    //     curve: const Interval(0.8, 1.0, curve: Curves.easeOut)));
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
    return SizedBox(
      height: 425,
      width: 480,
      child: BlocBuilder<DisplayOffset, ScrollOffset>(
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
          if (state.scrollOffsetValue >= (1200)) {
            controller.forward();
          } else {
            controller.reverse();
          }
          return AnimatedBuilder(
              animation: imageOpacity,
              builder: (context, child) {
                return Column(
                  children: [
                    SizedBox(
                      height: 290.0,
                      width: 290.0,
                      child: Center(
                        child: SizedBox(
                          height: imageReveal.value,
                          width: imageReveal.value,
                          child: Container(
                            height: 450,
                            width: 450,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(image: AssetImage(widget.image),  fit: BoxFit.cover,
                              )
                            ),
                            // child: Image.asset(
                            //   widget.image,
                            //   fit: BoxFit.cover,
                            //   filterQuality: FilterQuality.medium,
                            //   scale: 0.5,
                            // ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Flexible(
                        child: Column(
                      children: [
                        FadeTransition(
                          opacity: headingTextOpacity,
                          child: Text(
                            widget.title,
                            style: const TextStyle(
                              color: Color(0xff32CD32),
                              
                              fontSize: 19,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeTransition(
                          opacity: descriptionOpacity,
                          child: Text(
                            widget.subtitle,
                            style: const TextStyle(
                              color: Colors.black,
                              
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      ],
                    ))
                  ],
                );
              });
        },
      ),
    );
  }
}
