
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:solevad/bloc/screen_offset.dart';
import 'package:solevad/model/items.dart';
import 'package:solevad/screen/widget/item_card.dart';

class ForthSection extends StatefulWidget {
  const ForthSection({super.key});

  @override
  State<ForthSection> createState() => _ForthSectionState();
}

class _ForthSectionState extends State<ForthSection>
    with TickerProviderStateMixin {
  late AnimationController controller;
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
            if ((current.scrollOffsetValue >= 1200 &&
                    current.scrollOffsetValue <= 1200) ||
                controller.isAnimating) {
              return true;
            } else {
              return false;
            }
          },
          builder: (context, state) {
              if (state.scrollOffsetValue > 1200.0) {
                controller.forward();
              } else {
                controller.reverse();
              }
            return Column(
              children: [
                const Text(
                  'PRODUCTS & SERVICES',
                  style: TextStyle(
                    
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                          color: Color(0xff32CD32),
                  ),
                ),
               const SizedBox(
                height: 30,
               ),
                Wrap(
                  runAlignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 90,
                  runSpacing: 70,
                  children: items
                      .map(
                        (item) => ItemCard(
                          image: item.image,
                          title: item.title,
                          subtitle: item.subtitle,
                        ),
                      )
                      .toList(),
                )
              ],
            );
          },
        )
      ],
    );
  }
}
