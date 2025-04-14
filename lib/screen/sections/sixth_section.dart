
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:solevad/bloc/screen_offset.dart';
import 'package:solevad/model/news.dart';
import 'package:solevad/screen/widget/news_card.dart';
import 'package:solevad/screen/widget/text_reveal.dart';


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
        milliseconds: 1800,
      ),
      reverseDuration: const Duration(
        milliseconds: 1000,
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
            if (state.scrollOffsetValue > 2200.0) {
              //print(state.scrollOffsetValue);
              controller.forward();
            } else {
              controller.reverse();
            }
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  
                  TextReveal(
                    maxHeight: 90,
                    controller: controller,
                    child: const Text(
                      'Products & Services',
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
              ),
            );
          },
        ),
      ],
    );
  }
}
