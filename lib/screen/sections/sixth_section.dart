
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oavltd/bloc/screen_offset.dart';
import 'package:oavltd/model/news.dart';
import 'package:oavltd/screen/widget/news_card.dart';
import 'package:oavltd/screen/widget/text_reveal.dart';


class SixthSection extends StatefulWidget {
  const SixthSection({super.key});

  @override
  State<SixthSection> createState() => _SixthSectionState();
}

class _SixthSectionState extends State<SixthSection>
    with TickerProviderStateMixin {
  @override
  late AnimationController controller;
  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1000,
      ),
      reverseDuration: const Duration(
        milliseconds: 375,
      ),
    );
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
    return Column(
      children: [
        BlocBuilder<DisplayOffset, ScrollOffset>(
          buildWhen: (previous, current) {
            if ((current.scrollOffsetValue >= 2800 &&
                    current.scrollOffsetValue <= 4500) ||
                controller.isAnimating) {
              return true;
            } else {
              return false;
            }
          },
          builder: (context, state) {
            if (state.scrollOffsetValue > 4200.0) {
              //print(state.scrollOffsetValue);
              controller.forward();
            } else {
              controller.reverse();
            }
            return Column(
              children: [
                
                TextReveal(
                  maxHeight: 70,
                  controller: controller,
                  child: const Text(
                    'Learn More About Going Solar with Solevad',
                    style: TextStyle(
                      
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color:Color(0xff32CD32),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  height: 600,
                  child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: news
                          .map((news) => NewsCard(
                                news,
                              ))
                          .toList()),
                )
              ],
            );
          },
        ),
      ],
    );
  }
}
