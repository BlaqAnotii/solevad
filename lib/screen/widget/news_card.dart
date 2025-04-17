// import 'package:crypto_ui_web/bloc/screen_offset.dart';
// import 'package:crypto_ui_web/constant/color.dart';
// import 'package:crypto_ui_web/model/news.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class NewsCard extends StatefulWidget {
//   final News news;
//   const NewsCard(this.news, {super.key});

//   @override
//   State<NewsCard> createState() => _NewsCardState();
// }

// class _NewsCardState extends State<NewsCard>
//     with SingleTickerProviderStateMixin {
//   late AnimationController controller;
//   late Animation<double> animation;

//   @override
//   void initState() {
//     controller = AnimationController(
//         vsync: this, duration: const Duration(milliseconds: 1000));

//     animation = Tween(begin: 250.0, end: 0.0).animate(CurvedAnimation(
//         parent: controller,
//         curve: const Interval(0.0, 1.0, curve: Curves.easeOut)));
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<DisplayOffset, ScrollOffset>(
//       buildWhen: (previous, current) {
//         if (current.scrollOffsetValue > 3400) {
//           return true;
//         } else {
//           return false;
//         }
//       },
//       builder: (context, state) {
//         if (state.scrollOffsetValue > 3600) {
//           controller.forward();
//         } else {
//           controller.reverse();
//         }
//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 5),
//           child: AnimatedBuilder(
//             animation: animation,
//             builder: (context, child) {
//               return Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: const Color(0xff2A2A2A),
//                   border: Border.all(
//                     width: 1,
//                     color: AppColors.secondaryColor,
//                   ),
//                 ),
//                 child: Stack(
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         ClipRRect(
//                           borderRadius: const BorderRadius.only(
//                             topLeft: Radius.circular(10),
//                             topRight: Radius.circular(10),
//                           ),
//                           child: Image.asset(
//                             widget.news.image,
//                             fit: BoxFit.contain,
//                             height: 218,
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 10),
//                           child: Text(
//                             widget.news.title,
//                             style: const TextStyle(
//                               color: Colors.white,
//                              
//                               fontSize: 15,
//                               fontWeight: FontWeight.normal,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 10),
//                           child: SizedBox(
//                             width: 260,
//                             child: Text(
//                               widget.news.description,
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w200,
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 10),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               const Text(
//                                 'Nov. 28, 2023',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                  
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w200,
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: MediaQuery.of(context).size.width * 0.1,
//                               ),
//                               const Text(
//                                 'See more',
//                                 style: TextStyle(
//                                   color: AppColors.secondaryColor,
//                                  
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w200,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                     Align(
//                       alignment: Alignment(
//                           (widget.news.index % 2 == 1) ? 1.0 : -1.0, 1.0),
//                       child: Container(
//                         height: 400.0,
//                         width: animation.value,
//                         color: const Color(0xff2A2A2A),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:solevad/bloc/screen_offset.dart';
import 'package:solevad/model/news.dart';

class NewsCard extends StatefulWidget {
  final News news;
  const NewsCard(this.news, {super.key});

  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));

    animation = Tween(begin: 250.0, end: 0.0).animate(CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 1.0, curve: Curves.easeOut)));
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
    return BlocBuilder<DisplayOffset, ScrollOffset>(
      buildWhen: (previous, current) {
        if (current.scrollOffsetValue >= 2500) {
          return true;
        } else {
          return false;
        }
      },
      builder: (context, state) {
        if (state.scrollOffsetValue >= 2500) {
          controller.forward();
        } else {
          controller.reverse();
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: AnimatedCrossFade(
            crossFadeState: state.scrollOffsetValue >= 2500
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 1000),
            alignment: Alignment.center,
            reverseDuration: const Duration(milliseconds: 2000),
            firstCurve: Curves.easeInOut,
            secondCurve: Curves.linear,
            firstChild: Container(
              decoration: BoxDecoration(
                  color: Colors.white, // Background color
                  borderRadius: BorderRadius.circular(10),
                 
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // Light shadow
                      blurRadius: 3,
                      offset: const Offset(0, 4),
                      spreadRadius: 1,
                    ),
                  ],
              ),
            ),
            secondChild: Container(
              height: 530,
             decoration: BoxDecoration(
                  color: Colors.white, // Background color
                  borderRadius: BorderRadius.circular(10),
                 
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // Light shadow
                      blurRadius: 3,
                      offset: const Offset(0, 4),
                      spreadRadius: 1,
                    ),
                  ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    child: Image.asset(widget.news.image, fit: BoxFit.cover, scale: 2,)
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      widget.news.title,
                      style: const TextStyle(
                        color: Color(0xff32CD32),
                       
                        fontSize: 17,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SizedBox(
                      width: 290,
                      child: Text(
                        widget.news.description,
                        style: const TextStyle(
                          color: Colors.black,
                         
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
height: widget.news.index == 1
      ? 50
      : widget.news.index == 2
          ? 80
          : widget.news.index == 3
              ? 100
              : 60,                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ElevatedButton(
                          onPressed: () {
                            //context.go('/Our_Services');
                           // context.go('/contact_us');
                           if (widget.news.index == 1) {
        context.go('/products&services/solar-development');
      } else if (widget.news.index == 2) {
        context.go('/products&services/energy-management');
      } else if (widget.news.index == 3) {
        context.go('/products&services/operation&maintenance');
      } else if(widget.news.index == 4){
        context.go('/products&services/solar-financing');
      }
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(170, 45),
                            backgroundColor: const Color(0xff4779A3),
                          ),
                          child: const Text(
                            'Learn more',
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xffffffff),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                  ),
                 
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
