import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

import 'package:solevad/bloc/screen_offset.dart';
import 'package:solevad/screen/sections/bottom_bar.dart';
import 'package:solevad/screen/widget/responsive.dart';
import 'package:solevad/screen/widget/text_reveal.dart';
import 'package:solevad/screen/widget/text_transform.dart';

class OurTeamScreen extends StatefulWidget {
  const OurTeamScreen({super.key});

  @override
  State<OurTeamScreen> createState() => _OurTeamScreenState();
}

class _OurTeamScreenState extends State<OurTeamScreen> with SingleTickerProviderStateMixin {
 
  OverlayEntry? _overlayEntry;
  bool _isSubMenuOpen = false;
  int? _hoveredMenuIndex;

 // List of submenu items with routes
final Map<int, List<Map<String, String>>> _subMenuItems = {
 
  0: [
    {"title": "Solar Development", "route": "/products&services/solar-development"},
    {"title": "Energy Management Services", "route": "/products&services/energy-management"},
    {"title": "Operation and Maintenance", "route": "/products&services/operation&maintenance"},
    {"title": "Solar Financing", "route": "/products&services/solar-financing"},
  ],
};

int? _hoveredIndex; // null when nothing is hovered

bool hover = false;
  /// Show submenu on hover
  void _showSubMenu(BuildContext context, int index, Offset position) {
    _removeOverlay(); // Remove existing submenu first

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: position.dx,
        top: position.dy + 30,
        child: MouseRegion(
          onEnter: (_) => _isSubMenuOpen = true, // Keep submenu open
          onExit: (_) {
            Future.delayed(const Duration(milliseconds: 300), () {
              if (!_isSubMenuOpen) _removeOverlay();
            });
          },
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: 450,
              padding: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(1),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
               children: _subMenuItems[index]!.asMap().entries.map((entry) {
  int itemIndex = entry.key;
  Map<String, String> item = entry.value;

  return MouseRegion(
    onEnter: (_) {
      setState(() {
        _hoveredIndex = itemIndex;
      });
    },
    onExit: (_) {
      setState(() {
        _hoveredIndex = null;
      });
    },
   
    child: InkWell(
  
      onTap: () {
        _removeOverlay(); // Close menu
        context.go(item["route"]!);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          children: [
            Text(
              item["title"]!,
              style: TextStyle(
                color: _hoveredIndex == itemIndex ? Colors.blue[200] : Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
               
          ],
        ),
      ),
    ),
  );
}).toList(),
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  /// Removes overlay menu
  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _isSubMenuOpen = false;
  }

  /// Main menu item widget
  Widget _buildMenuItem(BuildContext context, String title, int index) {
                var screenSize = MediaQuery.of(context).size;

    return MouseRegion(
      onEnter: (event) {
        setState(() {
          _hoveredMenuIndex = index;
        });
        _showSubMenu(context, index, event.position);
      },
      onExit: (_) {
        Future.delayed(const Duration(milliseconds: 300), () {
          if (!_isSubMenuOpen) {
            setState(() => _hoveredMenuIndex = null);
            _removeOverlay();
          }
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: _hoveredMenuIndex == index ? Colors.blue[200] : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: screenSize.width *0.013,

            ),
          ),
          const SizedBox(height: 5),
          Visibility(
            maintainAnimation: true,
            maintainState: true,
            maintainSize: true,
            visible: _hoveredMenuIndex == index,
            child: Container(
              height: 2,
              width: 20,
              color: Colors.blue[200],
            ),
          )
        ],
      ),
    );
  }


   final List _isHovering = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];


  // late ScrollController controllers;
  // double _scrollPosition = 0;
  // double _opacity = 0;

  // _scrollListener() {
  //   setState(() {
  //     _scrollPosition =
  //         controllers.position.pixels;
  //   });
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   controller = AnimationController(
  //     vsync: this,
  //     duration: const Duration(
  //       milliseconds: 1700,
  //     ),
  //     reverseDuration: const Duration(
  //       milliseconds: 375,
  //     ),
  //   );

  //   textRevealAnimation =
  //       Tween<double>(begin: 60.0, end: 0.0)
  //           .animate(CurvedAnimation(
  //               parent: controller,
  //               curve: const Interval(0.0, 0.2,
  //                   curve: Curves.easeOut)));

  //   textOpacityAnimation =
  //       Tween<double>(begin: 0.0, end: 1.0)
  //           .animate(CurvedAnimation(
  //               parent: controller,
  //               curve: const Interval(0.0, 0.3,
  //                   curve: Curves.easeOut)));
  //   Future.delayed(
  //       const Duration(milliseconds: 1000), () {
  //     controller.forward();
  //   });

  //   controllers = ScrollController();
  //   controllers.addListener(_scrollListener);

  //   controllers.addListener(() {
  //     context
  //         .read<DisplayOffset>()
  //         .changeDisplayOffset(
  //             (MediaQuery.of(context)
  //                         .size
  //                         .height +
  //                     controllers.position.pixels)
  //                 .toInt());
  //   });
  //   super.initState();
  // }

  // @override
  // void initState() {
  //   controller = ScrollController();
  //   controller.addListener(_scrollListener);

  //   controller.addListener(() {
  //     context.read<DisplayOffset>().changeDisplayOffset(
  //         (MediaQuery.of(context).size.height + controller.position.pixels)
  //             .toInt());
  //   });
  //   super.initState();
  // }

  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

  return Scaffold(
      drawer: ResponsiveWidget.isSmallScreen(context)
         ? 
      
    Drawer(
        child: Container(
          color: const Color(0xfffffffff),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Center(
                child: Image.asset(
                  'assets/images/newlogo.png',
                  scale: 6,
                ),
              ),
              const SizedBox(height: 10),
              Divider(
                color: Colors.blueGrey[400],
                thickness: 0.5,
              ),
              const SizedBox(height: 30),
               ListTile(
                onTap: () {
               context.go('/home');

                },
                leading: const Icon(
                  Iconsax.home_1_bold,
                  size: 22,
                  color: Color(0xff4779A3),
                ),
                title: const Text(
                  'Home',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(
                  Iconsax.people_bold,
                  size: 22,
                  color: Color(0xff4779A3),
                ),
                title: const Text(
                  'About Us',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  //  navigationService.push(const WithdrawMoneyScreen());
                                        context.go('/about-us');
              
                  // Navigate or handle logic for withdrawing money
                },
              ),
             
              ExpansionTile(
                leading: const Icon(
                  Iconsax.bag_2_bold,
                  size: 22,
                  color: Color(0xff4779A3),
                ),
                title: const Text(
                  'Products & Services',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                trailing: const Icon(
                  Iconsax.arrow_down_1_outline,
                  size: 22,
                  color: Colors.black,
                ),
                children: <Widget>[
                  ListTile(
                    title: const Text(
                      'Solar Development',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                    onTap: () {
                      //  navigationService.push(const WithdrawMoneyScreen());
context.go('/products&services/solar-development');
                      // Navigate or handle logic for withdrawing money
                    },
                  ),
                  ListTile(
                    title: const Text(
                      'Energy Management Services',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                    onTap: () {
                      // Navigate or handle logic for viewing withdrawal list
                      // navigationService
                      //     .push(const WithdarwalListScreen());
                      context.go('/products&services/energy-management');

                    },
                  ),
                  ListTile(
                    title: const Text(
                      'Operation and Maintenance',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                    onTap: () {
                      // Navigate or handle logic for withdrawal settings
                      // navigationService
                      //     .push(const WithdrawalSettingScreen());
                                            context.go('/products&services/operation&maintenance');

                    },
                  ),
                  ListTile(
                    title: const Text(
                      'Solar Financing',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                    onTap: () {
                      // Navigate or handle logic for withdrawal settings
                      // navigationService
                      //     .push(const WithdrawalSettingScreen());
                                            context.go('/products&services/solar-financing');

                    },
                  ),
                ],
              ),
             
               ListTile(
                onTap: () {
               context.go('/contact_us');

                },
                leading: const Icon(
                  Iconsax.call_add_bold,
                  size: 22,
                  color: Color(0xff4779A3),
                ),
                title: const Text(
                  'Contact Us',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ),
               ListTile(
                onTap: () {
               context.go('/blog');

                },
                leading: const Icon(
                  Iconsax.blogger_bold,
                  size: 22,
                  color: Color(0xff4779A3),
                ),
                title: const Text(
                  'Blog',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ),
              const Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'Copyright © 2024 | Solevad Energy',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ): null,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
           toolbarHeight: 90,
        pinned: false,
        floating: false,
        snap: false,
        expandedHeight: 630,
        backgroundColor: Colors.transparent,
          automaticallyImplyLeading: ResponsiveWidget.isSmallScreen(context)
           ?true : false, // 👈 This hides the back button
        leading: 
        ResponsiveWidget.isSmallScreen(context)
           ?
        Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Iconsax.menu_1_outline, color:  Color(0xffffffff)),
                  onPressed: () {
                    Scaffold.of(context)
                        .openDrawer(); // Opens the drawer using correct context
                  },
                ),
              ): null,
        elevation: 0,
        centerTitle: true,
title: ResponsiveWidget.isSmallScreen(context)
           ?  InkWell(
                        onTap: () {
                                 context.go('/home');

                        },
                        child: Image.asset(
                          'assets/images/newlogo.png',
                          scale: 5,
                        ),
                      ) :
            Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: screenSize.width / 70),
                      InkWell(
                        onTap: () {
                                 context.go('/home');

                        },
                        child: Image.asset(
                          'assets/images/newlogo.png',
                          scale: screenSize.width *0.0037,
                        ),
                      ),

                      // const Text(
                      //   'Solevad Energy',
                      //   style: TextStyle(
                      //     color: Colors.white,
                      //     fontSize: 20,
                      //     fontWeight: FontWeight.w500,
                      //     letterSpacing: 3,
                      //   ),
                      // ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: screenSize.width / 12),
                            InkWell(
                              onHover: (value) {
                                setState(() {
                                  value
                                      ? _isHovering[0] = true
                                      : _isHovering[0] = false;
                                });
                              },
                              onTap: () {
                                 context.go('/home');
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Home',
                                    style: TextStyle(
                                      color: _isHovering[0]
                                          ? Colors.blue[200]
                                          : Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: screenSize.width *0.013,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Visibility(
                                    maintainAnimation: true,
                                    maintainState: true,
                                    maintainSize: true,
                                    visible: _isHovering[0],
                                    child: Container(
                                      height: 2,
                                      width: 20,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(width: screenSize.width / 20),
                            InkWell(
                              onHover: (value) {
                                setState(() {
                                  value
                                      ? _isHovering[1] = true
                                      : _isHovering[1] = false;
                                });
                              },
                              onTap: () {
                                context.go('/about-us');
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'About',
                                    style: TextStyle(
                                      color: _isHovering[1]
                                          ? Colors.blue[200]
                                          : Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: screenSize.width *0.013,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Visibility(
                                    maintainAnimation: true,
                                    maintainState: true,
                                    maintainSize: true,
                                    visible: _isHovering[1],
                                    child: Container(
                                      height: 2,
                                      width: 20,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(width: screenSize.width / 20),
                          _buildMenuItem(context, "Services", 0),
                            SizedBox(width: screenSize.width / 20),

                            InkWell(
                              onHover: (value) {
                                setState(() {
                                  value
                                      ? _isHovering[3] = true
                                      : _isHovering[3] = false;
                                });
                              },
                              onTap: () {
                                context.go('/contact_us');
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Contact Us',
                                    style: TextStyle(
                                      color: _isHovering[3]
                                          ? Colors.blue[200]
                                          : Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: screenSize.width *0.013,

                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Visibility(
                                    maintainAnimation: true,
                                    maintainState: true,
                                    maintainSize: true,
                                    visible: _isHovering[3],
                                    child: Container(
                                      height: 2,
                                      width: 20,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(width: screenSize.width / 20),
                            InkWell(
                              onHover: (value) {
                                setState(() {
                                  value
                                      ? _isHovering[4] = true
                                      : _isHovering[4] = false;
                                });
                              },
                              onTap: () {
                                context.go('/blog');
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Blog',
                                    style: TextStyle(
                                      color: _isHovering[4]
                                          ? Colors.blue[200]
                                          : Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: screenSize.width *0.013,

                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Visibility(
                                    maintainAnimation: true,
                                    maintainState: true,
                                    maintainSize: true,
                                    visible: _isHovering[4],
                                    child: Container(
                                      height: 2,
                                      width: 20,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // IconButton(
                      //   icon: const Icon(Icons.brightness_6),
                      //   splashColor: Colors.transparent,
                      //   highlightColor: Colors.transparent,
                      //   color: Colors.white,
                      //   onPressed: () {
                      //     EasyDynamicTheme.of(context).changeTheme();
                      //   },
                      // ),
                      SizedBox(width: screenSize.width / 20),
                      ElevatedButton(
                        onPressed: () {
                          //context.go('/Our_Services');
                        context.go('/contact_us');  
                               },
                        style: ElevatedButton.styleFrom(
                           shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(1),
                          ),
                          fixedSize: Size(screenSize.width *0.11, 45),
                          backgroundColor: const Color(0xff4779A3),
                        ),
                        child:  Text(
                          'Get Started',
                          style: TextStyle(
                           fontSize: screenSize.width *0.011,
                            color: Color(0xffffffff),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: screenSize.width / 20,
                      ),
                      ],
                    ),
                  ),
          flexibleSpace:  FlexibleSpaceBar(
            background: Stack(
              fit: StackFit.expand,
              children: [
      ResponsiveWidget.isSmallScreen(context)
          ? 
           Container(
      height: 530,
       width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/event5.jpg',),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black54,
                      BlendMode.darken,
                    ),
                  ),
                ),
      child: Stack(
        children: [
     

           // Static Text on top
          Positioned(
            left: 50,
            top: 220,
            right: 50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 DefaultTextStyle(
        style: const TextStyle(
          fontFamily: 'Mulish',
         fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
    constraints: const BoxConstraints(maxWidth: 950),
            child: AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'About Us',
                  speed: const Duration(milliseconds: 100),
                  textAlign: TextAlign.center,
                  cursor: '|'
                ),
              ],
              totalRepeatCount: 1,
              pause: const Duration(milliseconds: 1000),
              displayFullTextOnTap: true,
              stopPauseOnTap: true,
            ),
          ),
        ),
      ),
              
                const SizedBox(height: 20),
       Center(
  child: Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0),
    constraints: const BoxConstraints(maxWidth: 1000), // Constrain width for better block layout
    child: Text(
      'Solevad Energy is a leading innovator in Clean Energy Technologies, specializing in Solar Power and Battery Storage. We provide tailored solutions, including site feasibility studies, precise system sizing, and efficient implementation, to help clients optimize energy use and reduce costs. ',
      textAlign: TextAlign.justify, // This aligns both edges
      style: TextStyle(
        fontSize: screenSize.width * 0.028, // Adjusted for readability
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
    ),
  ),
),
              
              
              ],
            ),
          ),

          // Indicator Dots
          // Positioned(
          //   bottom: 30,
          //   left: 230,
          //   child: Row(
          //     children: List.generate(
          //       imageList.length,
          //       (index) => Container(
          //         margin: const EdgeInsets.symmetric(horizontal: 5),
          //         width: _currentIndex == index ? 11 : 7,
          //         height: _currentIndex == index ? 11 : 7,
          //         decoration: BoxDecoration(
          //           color: _currentIndex == index ? Colors.white : Colors.grey,
          //           shape: BoxShape.circle,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    )
          : Container(
             width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/event5.jpg',),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black54,
                      BlendMode.darken,
                    ),
                  ),
                ),
      height: 700,
      child: Stack(
        children: [
         

            // Static Text on top
          Positioned(
            left: 90,
            top: 190,
            right: 50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DefaultTextStyle(
        style: const TextStyle(
          fontFamily: 'Mulish',
         fontSize: 45,
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
        ),
        child: Center(
          child: Container(
             padding: const EdgeInsets.symmetric(horizontal: 24.0),
    constraints: const BoxConstraints(maxWidth: 1000),
            child: AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'About Us',
                                    textAlign: TextAlign.center,
            
                  speed: const Duration(milliseconds: 100),
                  cursor: '|'
                ),
              ],
              totalRepeatCount: 2,
              repeatForever: true,
              pause: const Duration(milliseconds: 10000),
              displayFullTextOnTap: true,
              stopPauseOnTap: true,
            ),
          ),
        ),
      ),
                const SizedBox(height: 20),
              
                   Center(
  child: Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0),
    constraints: const BoxConstraints(maxWidth: 1000), // Constrain width for better block layout
    child: Text(
      'Solevad Energy is a leading innovator in Clean Energy Technologies, specializing in Solar Power and Battery Storage. We provide tailored solutions, including site feasibility studies, precise system sizing, and efficient implementation, to help clients optimize energy use and reduce costs. ',
      textAlign: TextAlign.justify, // This aligns both edges
      style: TextStyle(
        fontSize: screenSize.width * 0.018, // Adjusted for readability
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
    ),
  ),
),
              ],
            ),
          ),

        
        ],
      ),
    )   ],
            ),
          ),
        ),
      
         // Sliver content section
        const SliverToBoxAdapter(
          child: Column(
            children: [
              SolvedaServicesApp(),
           Renewable10(),
          Renewable11(),
          Renewable12(),
          Team(),
       SizedBox(height: 25),


                 //   Renewables3(),
                  //  Renewables4(),
                  //  Renewables5(),
                   // Renewables6(),
          //           Renewable7(),
          //           Renewable8(),

      // EnergyManage(),
      // EnergyProcure(),
      // RealEstate(),
          BottomBar(),
            ]
          ),
        )
               
        ],
      ),
    );
  
  
    
//     return Scaffold(
//         backgroundColor:
//             Theme.of(context).colorScheme.surface,
//         extendBodyBehindAppBar: true,
//         appBar: ResponsiveWidget.isSmallScreen(
//                 context)
//             ? AppBar(
//                 backgroundColor:
//                     const Color(0xffffffff),
//                 elevation: 0,
//                 centerTitle: true,
//                 toolbarHeight: 80,
//                 leading: Builder(
//                   builder: (context) =>
//                       IconButton(
//                     icon: const Icon(
//                         Iconsax.menu_1_outline,
//                         color: Colors.black),
//                     onPressed: () {
//                       Scaffold.of(context)
//                           .openDrawer(); // Opens the drawer using correct context
//                     },
//                   ),
//                 ),
//                 title: Image.asset(
//                   'assets/images/newlogo.png',
//                   scale: 6,
//                 ),
//               )
//             : PreferredSize(
//               preferredSize: Size(screenSize.width, 1000),
//               child: Container(
//                 color: const Color(0xfffffffff),
//                 child: Padding(
//                   padding: const EdgeInsets.all(10),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       SizedBox(width: screenSize.width / 70),
//                       InkWell(
//                         onTap: () {
//                                  context.go('/home');

//                         },
//                         child: Image.asset(
//                           'assets/images/newlogo.png',
//                           scale: 6,
//                         ),
//                       ),

//                       // const Text(
//                       //   'Solevad Energy',
//                       //   style: TextStyle(
//                       //     color: Colors.white,
//                       //     fontSize: 20,
//                       //     fontWeight: FontWeight.w500,
//                       //     letterSpacing: 3,
//                       //   ),
//                       // ),
//                       Expanded(
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             SizedBox(width: screenSize.width / 12),
//                             InkWell(
//                               onHover: (value) {
//                                 setState(() {
//                                   value
//                                       ? _isHovering[0] = true
//                                       : _isHovering[0] = false;
//                                 });
//                               },
//                               onTap: () {
//                                 context.go('/home');
//                               },
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Text(
//                                     'Home',
//                                     style: TextStyle(
//                                       color: _isHovering[0]
//                                           ? Colors.blue[200]
//                                           : Colors.black,
//                                           fontWeight: FontWeight.bold
//                                     ),
//                                   ),
//                                   const SizedBox(height: 5),
//                                   Visibility(
//                                     maintainAnimation: true,
//                                     maintainState: true,
//                                     maintainSize: true,
//                                     visible: _isHovering[0],
//                                     child: Container(
//                                       height: 2,
//                                       width: 20,
//                                       color: Colors.white,
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                     SizedBox(width: screenSize.width / 20),
//                             _buildMenuItem(context, "About Us", 0),
//                     SizedBox(width: screenSize.width / 20),
//                     _buildMenuItem(context, "Products & Services", 1),
//                             SizedBox(width: screenSize.width / 20),
//                             InkWell(
//                               onHover: (value) {
//                                 setState(() {
//                                   value
//                                       ? _isHovering[3] = true
//                                       : _isHovering[3] = false;
//                                 });
//                               },
//                               onTap: () {
//                                 context.go('/contact_us');
//                               },
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Text(
//                                     'Contact Us',
//                                     style: TextStyle(
//                                       color: _isHovering[3]
//                                           ? Colors.blue[200]
//                                           : Colors.black,
//                                           fontWeight: FontWeight.bold
//                                     ),
//                                   ),
//                                   const SizedBox(height: 5),
//                                   Visibility(
//                                     maintainAnimation: true,
//                                     maintainState: true,
//                                     maintainSize: true,
//                                     visible: _isHovering[3],
//                                     child: Container(
//                                       height: 2,
//                                       width: 20,
//                                       color: Colors.white,
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                             SizedBox(width: screenSize.width / 20),
//                             InkWell(
//                               onHover: (value) {
//                                 setState(() {
//                                   value
//                                       ? _isHovering[4] = true
//                                       : _isHovering[4] = false;
//                                 });
//                               },
//                               onTap: () {
//                                 context.go('/blog');
//                               },
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Text(
//                                     'Blog',
//                                     style: TextStyle(
//                                       color: _isHovering[4]
//                                           ? Colors.blue[200]
//                                           : Colors.black,
//                                           fontWeight: FontWeight.bold
//                                     ),
//                                   ),
//                                   const SizedBox(height: 5),
//                                   Visibility(
//                                     maintainAnimation: true,
//                                     maintainState: true,
//                                     maintainSize: true,
//                                     visible: _isHovering[4],
//                                     child: Container(
//                                       height: 2,
//                                       width: 20,
//                                       color: Colors.white,
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       // IconButton(
//                       //   icon: const Icon(Icons.brightness_6),
//                       //   splashColor: Colors.transparent,
//                       //   highlightColor: Colors.transparent,
//                       //   color: Colors.white,
//                       //   onPressed: () {
//                       //     EasyDynamicTheme.of(context).changeTheme();
//                       //   },
//                       // ),
//                       SizedBox(width: screenSize.width / 20),
//                       ElevatedButton(
//                         onPressed: () {
//                           //context.go('/Our_Services');
//                           context.go('/contact_us');
//                         },
//                         style: ElevatedButton.styleFrom(
//                           fixedSize: const Size(170, 45),
//                           backgroundColor: const Color(0xff4779A3),
//                         ),
//                         child: const Text(
//                           'Get Started',
//                           style: TextStyle(
//                             fontSize: 13,
//                             color: Color(0xffffffff),
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: screenSize.width / 20,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ), 
//       drawer: Drawer(
//         child: Container(
//           color: const Color(0xfffffffff),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               const SizedBox(height: 30),
//               Center(
//                 child: Image.asset(
//                   'assets/images/newlogo.png',
//                   scale: 6,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               Divider(
//                 color: Colors.blueGrey[400],
//                 thickness: 0.5,
//               ),
//               const SizedBox(height: 30),
//                ListTile(
//                 onTap: () {
//                context.go('/home');

//                 },
//                 leading: const Icon(
//                   Iconsax.home_1_bold,
//                   size: 22,
//                   color: Color(0xff4779A3),
//                 ),
//                 title: const Text(
//                   'Home',
//                   style: TextStyle(
//                     fontSize: 15,
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//               ExpansionTile(
//                 leading: const Icon(
//                   Iconsax.profile_2user_bold,
//                   size: 22,
//                   color: Color(0xff4779A3),
//                 ),
//                 title: const Text(
//                   'About us',
//                   style: TextStyle(
//                     fontSize: 15,
//                     color: Colors.black,
//                   ),
//                 ),
//                 trailing: const Icon(
//                   Iconsax.arrow_down_1_outline,
//                   size: 22,
//                   color: Colors.black,
//                 ),
       
//                 children: <Widget>[
//                   ListTile(
//                     title: const Text(
//                       'Our Team',
//                       style: TextStyle(
//                         fontSize: 15,
//                         color: Colors.black,
//                       ),
//                     ),
//                     onTap: () {
//                       //  navigationService.push(const WithdrawMoneyScreen());
//                                             context.go('/about-us/our-team');

//                       // Navigate or handle logic for withdrawing money
//                     },
//                   ),
//                   ListTile(
//                     title: const Text(
//                       'Our Vision, Mission & Values',
//                       style: TextStyle(
//                         fontSize: 15,
//                         color: Colors.black,
//                       ),
//                     ),
//                     onTap: () {
//                       // Navigate or handle logic for viewing withdrawal list
//                       // navigationService
//                       //     .push(const WithdarwalListScreen());
//                                             context.go('/about-us/our-mission&vision&values');

//                     },
//                   ),
//                   ListTile(
//                     title: const Text(
//                       'Careers at Solevad',
//                       style: TextStyle(
//                         fontSize: 15,
//                         color: Colors.black,
//                       ),
//                     ),
//                     onTap: () {
//                       // Navigate or handle logic for withdrawal settings
//                       // navigationService
//                       //     .push(const WithdrawalSettingScreen());
//                       context.go('/about-us/careers');

//                     },
//                   ),
//                 ],
//               ),
//               ExpansionTile(
//                 leading: const Icon(
//                   Iconsax.bag_2_bold,
//                   size: 22,
//                   color: Color(0xff4779A3),
//                 ),
//                 title: const Text(
//                   'Products & Services',
//                   style: TextStyle(
//                     fontSize: 15,
//                     color: Colors.black,
//                   ),
//                 ),
//                 trailing: const Icon(
//                   Iconsax.arrow_down_1_outline,
//                   size: 22,
//                   color: Colors.black,
//                 ),
//                 children: <Widget>[
//                   ListTile(
//                     title: const Text(
//                       'Solar Development',
//                       style: TextStyle(
//                         fontSize: 15,
//                         color: Colors.black,
//                       ),
//                     ),
//                     onTap: () {
//                       //  navigationService.push(const WithdrawMoneyScreen());
// context.go('/products&services/solar-development');
//                       // Navigate or handle logic for withdrawing money
//                     },
//                   ),
//                   ListTile(
//                     title: const Text(
//                       'Energy Management Services',
//                       style: TextStyle(
//                         fontSize: 15,
//                         color: Colors.black,
//                       ),
//                     ),
//                     onTap: () {
//                       // Navigate or handle logic for viewing withdrawal list
//                       // navigationService
//                       //     .push(const WithdarwalListScreen());
//                       context.go('/products&services/energy-management');

//                     },
//                   ),
//                   ListTile(
//                     title: const Text(
//                       'Operation and Maintenance',
//                       style: TextStyle(
//                         fontSize: 15,
//                         color: Colors.black,
//                       ),
//                     ),
//                     onTap: () {
//                       // Navigate or handle logic for withdrawal settings
//                       // navigationService
//                       //     .push(const WithdrawalSettingScreen());
//                                             context.go('/products&services/operation&maintenance');

//                     },
//                   ),
//                   ListTile(
//                     title: const Text(
//                       'Solar Financing',
//                       style: TextStyle(
//                         fontSize: 15,
//                         color: Colors.black,
//                       ),
//                     ),
//                     onTap: () {
//                       // Navigate or handle logic for withdrawal settings
//                       // navigationService
//                       //     .push(const WithdrawalSettingScreen());
//                                             context.go('/products&services/solar-financing');

//                     },
//                   ),
//                 ],
//               ),
             
//                ListTile(
//                 onTap: () {
//                context.go('/contact_us');

//                 },
//                 leading: const Icon(
//                   Iconsax.call_add_bold,
//                   size: 22,
//                   color: Color(0xff4779A3),
//                 ),
//                 title: const Text(
//                   'Contact Us',
//                   style: TextStyle(
//                     fontSize: 15,
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//                ListTile(
//                 onTap: () {
//                context.go('/blog');

//                 },
//                 leading: const Icon(
//                   Iconsax.blogger_bold,
//                   size: 22,
//                   color: Color(0xff4779A3),
//                 ),
//                 title: const Text(
//                   'Blog',
//                   style: TextStyle(
//                     fontSize: 15,
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//               const Expanded(
//                 child: Align(
//                   alignment: Alignment.bottomCenter,
//                   child: Text(
//                     'Copyright © 2024 | Solevad Energy',
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 13,
//                         fontWeight: FontWeight.w500),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 10),
//             ],
//           ),
//         ),
//       ),
//         body: ListView(
//           controller: controllers,
//           children: [
//             ResponsiveWidget.isSmallScreen(
//                     context)
//                 ? Container(
//                     height: 400,
//                     decoration:
//                         const BoxDecoration(
//                             image:
//                                 DecorationImage(
//                                     fit: BoxFit
//                                         .cover,
//                                     colorFilter:
//                                         ColorFilter
//                                             .mode(
//                                       Colors
//                                           .black54,
//                                       BlendMode
//                                           .darken,
//                                     ),
//                                     image: AssetImage(
//                                         'assets/images/management.png'))),
//                     child: Row(
//                       mainAxisAlignment:
//                           MainAxisAlignment
//                               .spaceBetween,
//                       children: [
//                         Expanded(
//                           flex: 5,
//                           child: Padding(
//                             padding:
//                                 const EdgeInsets
//                                     .only(
//                                     left: 40,
//                                     top: 110),
//                             child: Column(
//                               crossAxisAlignment:
//                                   CrossAxisAlignment
//                                       .start,
//                               children: [
//                                 TextReveal(
//                                   maxHeight: 80,
//                                   controller:
//                                       controller,
//                                   textOpacityAnimation:
//                                       textOpacityAnimation,
//                                   textRevealAnimation:
//                                       textRevealAnimation,
//                                   child:
//                                       const Text(
//                                     'Our Team',
//                                     style: TextStyle(
//                                         fontSize:
//                                             22,
//                                         color: Colors
//                                             .white,
//                                         fontWeight:
//                                             FontWeight
//                                                 .w800),
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   height: 18,
//                                 ),
//                                 TextTransform(
//                                   maxHeight: 180,
//                                   controller:
//                                       controller,
//                                   textOpacityAnimation:
//                                       textOpacityAnimation,
//                                   //textRevealAnimation: textRevealAnimation,
//                                   child:
//                                       const Text(
//                                     'Solevad Energy’s team is built on a foundation of technical excellence, industry expertise, and a shared vision for a sustainable future.',
//                                     style: TextStyle(
//                                         fontSize:
//                                             13,
//                                         color: Colors
//                                             .white,
//                                         fontWeight:
//                                             FontWeight
//                                                 .w500),
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   height: 40,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         //const Expanded(flex: 9, child: FirstPageImage())
//                       ],
//                     ),
//                   )
//                 : Container(
//                     height: 500,
//                     decoration:
//                         const BoxDecoration(
//                             image:
//                                 DecorationImage(
//                                     fit: BoxFit
//                                         .cover,
//                                     colorFilter:
//                                         ColorFilter
//                                             .mode(
//                                       Colors
//                                           .black54,
//                                       BlendMode
//                                           .darken,
//                                     ),
//                                     image: AssetImage(
//                                         'assets/images/management.png'))),
//                     child: Row(
//                       mainAxisAlignment:
//                           MainAxisAlignment
//                               .spaceBetween,
//                       children: [
//                         Expanded(
//                           flex: 5,
//                           child: Padding(
//                             padding:
//                                 const EdgeInsets
//                                     .only(
//                                     left: 90,
//                                     top: 130),
//                             child: Column(
//                               crossAxisAlignment:
//                                   CrossAxisAlignment
//                                       .start,
//                               children: [
//                                 TextReveal(
//                                   maxHeight: 110,
//                                   controller:
//                                       controller,
//                                   textOpacityAnimation:
//                                       textOpacityAnimation,
//                                   textRevealAnimation:
//                                       textRevealAnimation,
//                                   child:
//                                       const Text(
//                                     'Our Team',
//                                     style: TextStyle(
//                                         fontSize:
//                                             45,
//                                         color: Colors
//                                             .white,
//                                         fontWeight:
//                                             FontWeight
//                                                 .w800),
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   height: 20,
//                                 ),
//                                 TextTransform(
//                                   maxHeight: 180,
//                                   controller:
//                                       controller,
//                                   textOpacityAnimation:
//                                       textOpacityAnimation,
//                                   //textRevealAnimation: textRevealAnimation,
//                                   child:
//                                       const Text(
//                                     'Solevad Energy’s team is built on a foundation of technical excellence,\nindustry expertise, and a shared vision for a sustainable future.',
//                                     style: TextStyle(
//                                         fontSize:
//                                             16,
//                                         color: Colors
//                                             .white,
//                                         fontWeight:
//                                             FontWeight
//                                                 .w500),
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   height: 40,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         //const Expanded(flex: 9, child: FirstPageImage())
//                       ],
//                     ),
//                   ),
//             PreferredSize(
//               preferredSize: Size(
//                 screenSize.width,
//                 1000,
//               ),
//               child: Container(
//                 color: const Color.fromARGB(
//                     255, 253, 249, 249),
//                 height: 60,
//                 child: Padding(
//                   padding:
//                       const EdgeInsets.all(10),
//                   child: SingleChildScrollView(
//                     scrollDirection:
//                         Axis.horizontal,
//                     child: Row(
//                       crossAxisAlignment:
//                           CrossAxisAlignment
//                               .center,
//                       mainAxisAlignment:
//                           MainAxisAlignment.start,
//                       children: [
//                         SizedBox(
//                             width:
//                                 screenSize.width /
//                                     70),
//                         InkWell(
//                           onTap: () {
//                             //  context.go('/Contact_us');
//                           },
//                           child: Column(
//                             mainAxisSize:
//                                 MainAxisSize.min,
//                             children: [
//                               Text(
//                                 'HOME',
//                                 style: TextStyle(
//                                     color: _isHovering[
//                                             6]
//                                         ? Colors.blue[
//                                             200]
//                                         : Colors
//                                             .black,
//                                     fontWeight:
//                                         FontWeight
//                                             .w400),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                             width:
//                                 screenSize.width /
//                                     40),
//                         const VerticalDivider(),
//                         SizedBox(
//                             width:
//                                 screenSize.width /
//                                     40),
//                         const Column(
//                           mainAxisSize:
//                               MainAxisSize.min,
//                           children: [
//                             Text(
//                               'ABOUT US',
//                               style: TextStyle(
//                                   color: Colors
//                                       .black,
//                                   fontWeight:
//                                       FontWeight
//                                           .w400),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                             width:
//                                 screenSize.width /
//                                     40),
//                         const VerticalDivider(),
//                         SizedBox(
//                             width:
//                                 screenSize.width /
//                                     40),
//                         const Column(
//                           mainAxisSize:
//                               MainAxisSize.min,
//                           children: [
//                             Text(
//                               'OUR TEAM',
//                               style: TextStyle(
//                                   color: Colors
//                                       .black,
//                                   fontWeight:
//                                       FontWeight
//                                           .w400),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             const Divider(),
//                   const SizedBox(height: 20,)    ,         
//             ResponsiveWidget.isSmallScreen(
//                     context)
//                 ? Container(
//                     margin: const EdgeInsets.only(
//                       left: 20,
//                       right: 20,
//                     ),
//                     child: Column(
//                       children: [
//                         Column(
//                           children: [
//                             Container(
//                               height: 300,
//                               width: 350,
//                               decoration: const BoxDecoration(
//                                   image: DecorationImage(
//                                       image: AssetImage(
//                                           'assets/images/aboutus3.png'))),
//                             ),
//                           ],
//                         ),
//                         const Column(
//                           mainAxisAlignment:
//                               MainAxisAlignment
//                                   .start,
//                           crossAxisAlignment:
//                               CrossAxisAlignment
//                                   .center,
//                           children: [
                           
//                             Text(
//                               'Our team consists of highly skilled engineers, experienced project managers, and renewable energy specialists who leverage cutting-edge technologies and innovative strategies to deliver exceptional results. At the helm of our leadership is CEO Leroy Ahwinahwi, whose visionary leadership drives our commitment to excellence. Under his guidance, we foster a culture of collaboration, continuous improvement, and client-centric solutions. With our collective expertise, we develop energy solutions that meet, and often exceed, industry standards, contributing to a greener and more sustainable future.',
//                               style: TextStyle(
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   )
//                 : SingleChildScrollView(
//                     scrollDirection:
//                         Axis.horizontal,
//                     child: Container(
//                       margin:
//                           const EdgeInsets.only(
//                         left: 20,
//                         right: 20,
//                       ),
//                       child: Row(
//                         children: [
//                           Column(
//                             children: [
//                               Container(
//                                 height: 500,
//                                 width: 600,
//                                 decoration: const BoxDecoration(
//                                     image: DecorationImage(
//                                         image: AssetImage(
//                                             'assets/images/aboutus3.png'))),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(
//                             width: 40,
//                           ),
//                           const Column(
//                             mainAxisAlignment:
//                                 MainAxisAlignment
//                                     .start,
//                             children: [
                           
//                               Text(
//                                 'Our team consists of highly skilled engineers, experienced project managers,\nand renewable energy specialists who leverage cutting-edge technologies and innovative\nstrategies to deliver exceptional results. At the helm of our leadership is\nCEO Leroy Ahwinahwi, whose visionary leadership drives our commitment to excellence.\nUnder his guidance, we foster a culture of collaboration, continuous improvement,\nand client-centric solutions. With our collective expertise, we develop energy\nsolutions that meet, and often exceed, industry standards, contributing to a greener\nand more sustainable future.',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//            ResponsiveWidget.isSmallScreen(
//                 context)
//             ? Container(
//               margin: const EdgeInsets.only(
//                 left: 10, right: 10,
//               ),
//               child:  Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                    const SizedBox(
//                       height: 45,
//                     ),
//                 const Center(
//                               child: Text(
//                                                 'Management Team',
//                                                 style: TextStyle(
//                                                   color: Color(
//                                                       0xff32CD32),
//                                                   fontSize: 20,
//                                                   fontWeight:
//                                                       FontWeight
//                                                           .bold,
//                                                 ),
//                                               ),
//                             ),
//                               const SizedBox(
//                       height: 15,
//                     ),
//                     Center(
//                       child: Container(
//                          padding: const EdgeInsets.all(30),
//                           decoration: BoxDecoration(
//                             border: Border.all(
//                               color: Colors.grey,
//                             )
//                           ),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                                 Container(
//                                 width: 300,
//                                 margin: const EdgeInsets.only(right: 15, bottom: 35),
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(5),
//                                     color: Colors.white,
//                                     border: Border.all(
//                                       width: 1,
//                                       color: Colors.grey,
//                                     )),
//                                 child: Column(
//                                   children: [
//                                     Stack(
//                                       children: [
//                                         Container(
//                                           height: 220,
//                                           width: 300,
//                                           decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.circular(5),
//                                             image: const DecorationImage(
//                                               image: AssetImage(
//                                                   'assets/images/leroy.jpg'),
//                                               fit: BoxFit.fill,
//                                             ),
//                                           ),
//                                         ),
                                      
//                                       ],
//                                     ),
//                                     Container(
//                                       padding: const EdgeInsets.all(
//                                         10,
//                                       ),
//                                       width: 300,
//                                       child: const Column(
//                                         crossAxisAlignment: CrossAxisAlignment.center,
//                                         children: [
//                                           Text(
//                                             'CHIEF EXECUTIVE',
//                                             overflow: TextOverflow.ellipsis,
//                                             style: TextStyle(
//                                               color: Color(
//                                                             0xff32CD32),
//                                               fontSize: 19,
//                                               fontWeight: FontWeight.w600,
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             height: 3,
//                                           ),
                                        
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             Container(
//                                 width: 300,
//                                 margin: const EdgeInsets.only(right: 15, bottom: 35),
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(5),
//                                     color: Colors.white,
//                                     border: Border.all(
//                                       width: 1,
//                                       color: Colors.grey,
//                                     )),
//                                 child: Column(
//                                   children: [
//                                     Stack(
//                                       children: [
//                                         Container(
//                                           height: 220,
//                                           width: 300,
//                                           decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.circular(5),
//                                             image: const DecorationImage(
//                                               image: AssetImage(
//                                                   'assets/images/efe.jpg'),
//                                               fit: BoxFit.fill,
//                                             ),
//                                           ),
//                                         ),
                                      
//                                       ],
//                                     ),
//                                     Container(
//                                       padding: const EdgeInsets.all(
//                                         10,
//                                       ),
//                                       width: 300,
//                                       child: const Column(
//                                         crossAxisAlignment: CrossAxisAlignment.center,
//                                         children: [
//                                           Text(
//                                             'BUSINESS DEVELOPMENT',
//                                             overflow: TextOverflow.ellipsis,
//                                             style: TextStyle(
//                                               color: Color(
//                                                             0xff32CD32),
//                                               fontSize: 19,
//                                               fontWeight: FontWeight.w600,
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             height: 3,
//                                           ),
                                         
                                       
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
                            
//                                               Container(
//                                 width: 300,
//                                 margin: const EdgeInsets.only(right: 15, bottom: 35),
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(5),
//                                     color: Colors.white,
//                                     border: Border.all(
//                                       width: 1,
//                                       color: Colors.grey,
//                                     )),
//                                 child: Column(
//                                   children: [
//                                     Stack(
//                                       children: [
//                                         Container(
//                                           height: 220,
//                                           width: 300,
//                                           decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.circular(5),
//                                             image: const DecorationImage(
//                                               image: AssetImage(
//                                                   'assets/images/promise.jpg'),
//                                               fit: BoxFit.fill,
//                                             ),
//                                           ),
//                                         ),
                                      
//                                       ],
//                                     ),
//                                     Container(
//                                       padding: const EdgeInsets.all(
//                                         10,
//                                       ),
//                                       width: 300,
//                                       child: const Column(
//                                         crossAxisAlignment: CrossAxisAlignment.center,
//                                         children: [
//                                           Text(
//                                             'OPERATION SERVICE',
//                                             overflow: TextOverflow.ellipsis,
//                                             style: TextStyle(
//                                               color: Color(
//                                                             0xff32CD32),
//                                               fontSize: 19,
//                                               fontWeight: FontWeight.w600,
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             height: 3,
//                                           ),
                                         
                                      
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                                 Container(
//                                 width: 300,
//                                 margin: const EdgeInsets.only(right: 15, bottom: 35),
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(5),
//                                     color: Colors.white,
//                                     border: Border.all(
//                                       width: 1,
//                                       color: Colors.grey,
//                                     )),
//                                 child: Column(
//                                   children: [
//                                     Stack(
//                                       children: [
//                                         Container(
//                                           height: 220,
//                                           width: 300,
//                                           decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.circular(5),
//                                             image: const DecorationImage(
//                                               image: AssetImage(
//                                                   'assets/images/dona.jpg'),
//                                               fit: BoxFit.fill,
//                                             ),
//                                           ),
//                                         ),
                                      
//                                       ],
//                                     ),
//                                     Container(
//                                       padding: const EdgeInsets.all(
//                                         10,
//                                       ),
//                                       width: 300,
//                                       child: const Column(
//                                         crossAxisAlignment: CrossAxisAlignment.center,
//                                         children: [
//                                           Text(
//                                             'PROJECT DEVELOPMENT',
//                                             overflow: TextOverflow.ellipsis,
//                                             style: TextStyle(
//                                               color: Color(
//                                                             0xff32CD32),
//                                               fontSize: 19,
//                                               fontWeight: FontWeight.w600,
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             height: 3,
//                                           ),
                                        
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
                           
                            
                                       
//                             ],
//                           ),
//                       ),
//                     ),

//                 ],
//               ),
//             )
//             : Container(
//               margin: const EdgeInsets.only(
//                 left: 80, right: 60,
//               ),
//               child:  Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   const SizedBox(
//                     height: 40,
//                   ),
//               const Center(
//                             child: Text(
//                                               'Management Team',
//                                               style: TextStyle(
//                                                 color: Color(
//                                                     0xff32CD32),
//                                                 fontSize: 30,
//                                                 fontWeight:
//                                                     FontWeight
//                                                         .bold,
//                                               ),
//                                             ),
//                           ),
//                             const SizedBox(
//                     height: 40,
//                   ),
//                   Container(
//                     padding: const EdgeInsets.all(30),
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: Colors.grey,
//                         )
//                       ),
//                     child: Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                         Container(
//                             width: 250,
//                             margin: const EdgeInsets.only(right: 5, bottom: 35),
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(5),
//                                 color: Colors.white,
//                                 border: Border.all(
//                                   width: 1,
//                                   color: Colors.grey,
//                                 )),
//                             child: Column(
//                               children: [
//                                 Stack(
//                                   children: [
//                                     Container(
//                                       height: 220,
//                                       width: 250,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(5),
//                                         image: const DecorationImage(
//                                           image: AssetImage(
//                                               'assets/images/leroy.jpg'),
//                                           fit: BoxFit.fill,
//                                         ),
//                                       ),
//                                     ),
                                  
//                                   ],
//                                 ),
//                                 Container(
//                                   padding: const EdgeInsets.all(
//                                     10,
//                                   ),
//                                   width: 250,
//                                   child: const Column(
//                                     crossAxisAlignment: CrossAxisAlignment.center,
//                                     children: [
//                                       Text(
//                                         'CHIEF EXECUTIVE',
//                                         overflow: TextOverflow.ellipsis,
//                                         style: TextStyle(
//                                           color: Color(
//                                                         0xff32CD32),
//                                           fontSize: 19,
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         height: 3,
//                                       ),
                                     
                                  
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         Container(
//                             width: 250,
//                             margin: const EdgeInsets.only(right: 5, bottom: 35),
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(5),
//                                 color: Colors.white,
//                                 border: Border.all(
//                                   width: 1,
//                                   color: Colors.grey,
//                                 )),
//                             child: Column(
//                               children: [
//                                 Stack(
//                                   children: [
//                                     Container(
//                                       height: 220,
//                                       width: 250,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(5),
//                                         image: const DecorationImage(
//                                           image: AssetImage(
//                                               'assets/images/efe.jpg'),
//                                           fit: BoxFit.fill,
//                                         ),
//                                       ),
//                                     ),
                                  
//                                   ],
//                                 ),
//                                 Container(
//                                   padding: const EdgeInsets.all(
//                                     10,
//                                   ),
//                                   width: 250,
//                                   child: const Column(
//                                     crossAxisAlignment: CrossAxisAlignment.center,
//                                     children: [
//                                       Text(
//                                         'BUSINESS DEVELOPMENT',
//                                         overflow: TextOverflow.ellipsis,
//                                         style: TextStyle(
//                                           color: Color(
//                                                         0xff32CD32),
//                                           fontSize: 19,
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         height: 3,
//                                       ),
                                     
                                     
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
                        
//                                           Container(
//                             width: 250,
//                             margin: const EdgeInsets.only(right: 5, bottom: 35),
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(5),
//                                 color: Colors.white,
//                                 border: Border.all(
//                                   width: 1,
//                                   color: Colors.grey,
//                                 )),
//                             child: Column(
//                               children: [
//                                 Stack(
//                                   children: [
//                                     Container(
//                                       height: 220,
//                                       width: 250,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(5),
//                                         image: const DecorationImage(
//                                           image: AssetImage(
//                                               'assets/images/promise.jpg'),
//                                           fit: BoxFit.fill,
//                                         ),
//                                       ),
//                                     ),
                                  
//                                   ],
//                                 ),
//                                 Container(
//                                   padding: const EdgeInsets.all(
//                                     10,
//                                   ),
//                                   width: 250,
//                                   child: const Column(
//                                     crossAxisAlignment: CrossAxisAlignment.center,
//                                     children: [
//                                       Text(
//                                         'OPERATION SERVICE',
//                                         overflow: TextOverflow.ellipsis,
//                                         style: TextStyle(
//                                           color: Color(
//                                                         0xff32CD32),
//                                           fontSize: 19,
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         height: 3,
//                                       ),
                                    
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                                   Container(
//                             width: 250,
//                             margin: const EdgeInsets.only(right: 5, bottom: 35),
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(5),
//                                 color: Colors.white,
//                                 border: Border.all(
//                                   width: 1,
//                                   color: Colors.grey,
//                                 )),
//                             child: Column(
//                               children: [
//                                 Stack(
//                                   children: [
//                                     Container(
//                                       height: 220,
//                                       width: 250,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(5),
//                                         image: const DecorationImage(
//                                           image: AssetImage(
//                                               'assets/images/dona.jpg'),
//                                           fit: BoxFit.fill,
//                                         ),
//                                       ),
//                                     ),
                                  
//                                   ],
//                                 ),
//                                 Container(
//                                   padding: const EdgeInsets.all(
//                                     10,
//                                   ),
//                                   width: 250,
//                                   child: const Column(
//                                     crossAxisAlignment: CrossAxisAlignment.center,
//                                     children: [
//                                       Text(
//                                         'PROJECT DEVELOPMENT',
//                                         overflow: TextOverflow.ellipsis,
//                                         style: TextStyle(
//                                           color: Color(
//                                                         0xff32CD32),
//                                           fontSize: 19,
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         height: 3,
//                                       ),
                                     
                                     
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           ],
//                         ),
                        
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 100.0,
//             ),
//             const BottomBar(),
//           ],
//         ));
  }

  bool termsAccepted = false;
}




class Renewable10 extends StatefulWidget {
  const Renewable10({super.key});

  @override
  State<Renewable10> createState() => _Renewable10State();
}

class _Renewable10State extends State<Renewable10> {
  @override
  Widget build(BuildContext context) {
     return   ResponsiveWidget.isSmallScreen(context)
          ? 
              Padding(
       padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Center(
                     child: Container(
                       padding: const EdgeInsets.symmetric(horizontal: 24.0),
    constraints: const BoxConstraints(maxWidth: 1000),
                       child: const Text(
                         'Market Overview',
                         style: TextStyle(
                           color: Color(0xff32CD32),
                       
                           fontSize: 26,
                           fontWeight: FontWeight.w700,
                         ),
                       ),
                     ),
                   ),
                                      const SizedBox(height: 20),

                   Center(
                     child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
    constraints: const BoxConstraints(maxWidth: 900),
                       child: const Text(
                       "The demand for solar energy in Nigeria is driven by challenges in national power supply and rising fossil fuel costs. Solar technology adoption, including panels, inverters, and batteries, offers a practical solution to frequent power outages while promoting environmental sustainability. Solevad Energy is committed to empowering businesses and households with reliable, cost-effective solar solutions.",
                             textAlign: TextAlign.justify, // This aligns both edges

                       style: TextStyle(
                         fontSize: 16,
                         height: 1.5,
                       ),
                                        ),
                     ),
                   ),
                 
                                      const SizedBox(height: 30),
 Center(
   child: ClipRRect(
                       borderRadius: BorderRadius.circular(5),
                       child: Image.asset(
                         'assets/images/event3.jpg', // Replace with your image path
                         width: 380,
                         height: 350,
                         fit: BoxFit.cover,
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

               Expanded(
               flex: 6,
               child: Column(
                 children: [
                   ClipRRect(
                     borderRadius: BorderRadius.circular(5),
                     child: Image.asset(
                         'assets/images/event3.jpg', // Replace with your image path
                       width: 620,
                       height: 350,
                       fit: BoxFit.cover,
                     ),
                   ),
                   
                 ],
               ),
             ),
           
         
             const SizedBox(width: 70),
         
             // Right: CEO Image and Name
             Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Center(
                   child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
    constraints: const BoxConstraints(maxWidth: 1000),
                     child: const Text(
                           'Market Overview',
                       style: TextStyle(
                         color: Color(0xff32CD32),
                     
                         fontSize: 26,
                         fontWeight: FontWeight.w700,
                       ),
                     ),
                   ),
                 ),
                 const SizedBox(height: 20),
                  Center(
                    child: Container(
padding: const EdgeInsets.symmetric(horizontal: 24.0),
    constraints: const BoxConstraints(maxWidth: 600),
                      child: const Text(
                       "The demand for solar energy in Nigeria is driven by challenges in national power supply and rising fossil fuel costs. Solar technology adoption, including panels, inverters, and batteries, offers a practical solution to frequent power outages while promoting environmental sustainability. Solevad Energy is committed to empowering businesses and households with reliable, cost-effective solar solutions.",
                             textAlign: TextAlign.justify, // This aligns both edges

                       style: TextStyle(
                         fontSize: 16,
                         height: 1.5,
                       ),
                                       ),
                    ),
                  ),
                              
               ],
             ),
           ],
         ),
       );
  }
}






class Renewable11 extends StatefulWidget {
  const Renewable11({super.key});

  @override
  State<Renewable11> createState() => _Renewable11State();
}

class _Renewable11State extends State<Renewable11> {
  @override
  Widget build(BuildContext context) {
     return   ResponsiveWidget.isSmallScreen(context)
          ? 
              Padding(
       padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Center(
                     child: Container(
                       padding: const EdgeInsets.symmetric(horizontal: 24.0),
    constraints: const BoxConstraints(maxWidth: 1000),
                       child: const Text(
                         'Our Mission',
                         style: TextStyle(
                           color: Color(0xff32CD32),
                       
                           fontSize: 26,
                           fontWeight: FontWeight.w700,
                         ),
                       ),
                     ),
                   ),
                                      const SizedBox(height: 20),

                   Center(
                     child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
    constraints: const BoxConstraints(maxWidth: 900),
                       child: const Text(
                       "To revolutionize energy accessibility by delivering innovative, sustainable solar solutions that exceed client expectations.",
                             textAlign: TextAlign.justify, // This aligns both edges

                       style: TextStyle(
                         fontSize: 16,
                         height: 1.5,
                       ),
                                        ),
                     ),
                   ),
                 
                                      const SizedBox(height: 30),
 Center(
   child: ClipRRect(
                       borderRadius: BorderRadius.circular(5),
                       child: Image.asset(
                         'assets/images/event2.jpg', // Replace with your image path
                         width: 380,
                         height: 350,
                         fit: BoxFit.cover,
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

           Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Center(
                   child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
    constraints: const BoxConstraints(maxWidth: 1000),
                     child: const Text(
                           'Our Mission',
                       style: TextStyle(
                         color: Color(0xff32CD32),
                     
                         fontSize: 26,
                         fontWeight: FontWeight.w700,
                       ),
                     ),
                   ),
                 ),
                 const SizedBox(height: 20),
                  Center(
                    child: Container(
padding: const EdgeInsets.symmetric(horizontal: 24.0),
    constraints: const BoxConstraints(maxWidth: 600),
                      child: const Text(
                       "To revolutionize energy accessibility by delivering innovative, sustainable solar solutions that exceed client expectations.",
                             textAlign: TextAlign.justify, // This aligns both edges

                       style: TextStyle(
                         fontSize: 16,
                         height: 1.5,
                       ),
                                       ),
                    ),
                  ),
                              
               ],
             ),
         
             const SizedBox(width: 70),
           Expanded(
               flex: 6,
               child: Column(
                 children: [
                   ClipRRect(
                     borderRadius: BorderRadius.circular(5),
                     child: Image.asset(
                         'assets/images/event2.jpg', // Replace with your image path
                       width: 620,
                       height: 350,
                       fit: BoxFit.cover,
                     ),
                   ),
                   
                 ],
               ),
             ),
             // Right: CEO Image and Name
             
           ],
         ),
       );
  }
}




class Renewable12 extends StatefulWidget {
  const Renewable12({super.key});

  @override
  State<Renewable12> createState() => _Renewable12State();
}

class _Renewable12State extends State<Renewable12> {
  @override
  Widget build(BuildContext context) {
     return   ResponsiveWidget.isSmallScreen(context)
          ? 
              Padding(
       padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Center(
                     child: Container(
                       padding: const EdgeInsets.symmetric(horizontal: 24.0),
    constraints: const BoxConstraints(maxWidth: 1000),
                       child: const Text(
                         'Our Vision',
                         style: TextStyle(
                           color: Color(0xff32CD32),
                       
                           fontSize: 26,
                           fontWeight: FontWeight.w700,
                         ),
                       ),
                     ),
                   ),
                                      const SizedBox(height: 20),

                   Center(
                     child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
    constraints: const BoxConstraints(maxWidth: 900),
                       child: const Text(
                       "To be the foremost partner for solar solutions across Sub-Saharan Africa, empowered by strategic alliances with global leaders in technology, manufacturing, and finance.",
                             textAlign: TextAlign.justify, // This aligns both edges

                       style: TextStyle(
                         fontSize: 16,
                         height: 1.5,
                       ),
                                        ),
                     ),
                   ),
                 
                                      const SizedBox(height: 30),
 Center(
   child: ClipRRect(
                       borderRadius: BorderRadius.circular(5),
                       child: Image.asset(
                         'assets/images/event4.jpg', // Replace with your image path
                         width: 380,
                         height: 350,
                         fit: BoxFit.cover,
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

               Expanded(
               flex: 6,
               child: Column(
                 children: [
                   ClipRRect(
                     borderRadius: BorderRadius.circular(5),
                     child: Image.asset(
                         'assets/images/event4.jpg', // Replace with your image path
                       width: 620,
                       height: 350,
                       fit: BoxFit.cover,
                     ),
                   ),
                   
                 ],
               ),
             ),
           
         
             const SizedBox(width: 70),
         
             // Right: CEO Image and Name
             Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Center(
                   child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
    constraints: const BoxConstraints(maxWidth: 1000),
                     child: const Text(
                           'Our Vision',
                       style: TextStyle(
                         color: Color(0xff32CD32),
                     
                         fontSize: 26,
                         fontWeight: FontWeight.w700,
                       ),
                     ),
                   ),
                 ),
                 const SizedBox(height: 20),
                  Center(
                    child: Container(
padding: const EdgeInsets.symmetric(horizontal: 24.0),
    constraints: const BoxConstraints(maxWidth: 600),
                      child: const Text(
                       "To be the foremost partner for solar solutions across Sub-Saharan Africa, empowered by strategic alliances with global leaders in technology, manufacturing, and finance.",
                             textAlign: TextAlign.justify, // This aligns both edges

                       style: TextStyle(
                         fontSize: 16,
                         height: 1.5,
                       ),
                                       ),
                    ),
                  ),
                              
               ],
             ),
           ],
         ),
       );
  }
}


class Team extends StatefulWidget {
  const Team({super.key});

  @override
  State<Team> createState() => _TeamState();
}

class _TeamState extends State<Team> {

  final services = [
    // {
    //   "icon": 'assets/images/vector.jpg',
    //   "title": "Sustainable Infrastructure"
    // },
    // {
    //   "icon": 'assets/images/vector2.jpg',
    //   "title": "Renewable Energy Services"
    // },
       {
      "icon": 'assets/images/leroy.jpg',
      "title": "CHIEF EXECUTIVE",
      'index': "1",
    },
    {
      "icon": 'assets/images/efe.jpg' ,
      "title": "BUSINESS MANAGEMENT",
      'index': "2",
    },
    {
      "icon": 'assets/images/promise.jpg',
      "title": "OPERATION SERVICES",
      'index': "3",

    },
    {
      "icon": 'assets/images/dona.jpg',
      "title": "PROJECT MANAGEMENT",
      'index': "4",

    },
  ];
  @override
  Widget build(BuildContext context) {
           return   ResponsiveWidget.isSmallScreen(
                context)
            ? Container(
              margin: const EdgeInsets.only(
                left: 10, right: 10,
              ),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                   const SizedBox(
                      height: 45,
                    ),
                const Center(
                              child: Text(
                                                'Management Team',
                                                style: TextStyle(
                                                  color: Color(
                                                      0xff32CD32),
                                                  fontSize: 20,
                                                  fontWeight:
                                                      FontWeight
                                                          .bold,
                                                ),
                                              ),
                            ),
                              const SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: Container(
                         padding: const EdgeInsets.all(30),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            )
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                                ClipRRect(
                     borderRadius: BorderRadius.circular(5),
                     child: Image.asset(
                       'assets/images/leroy.jpg', // Replace with your image path
                       width: 350,
                       height: 350,
                       fit: BoxFit.contain,
                     ),
                   ),
                   const SizedBox(height: 15),
                   const Text(
                     'CHIEF EXECUTIVE',
                     style: TextStyle(
                       fontSize: 17,
                       fontWeight: FontWeight.w700,
                       color: Colors.black87,
                     ),
                   ),
                                      const SizedBox(height: 25),

                   ClipRRect(
                     borderRadius: BorderRadius.circular(5),
                     child: Image.asset(
                       'assets/images/efe.jpg', // Replace with your image path
                       width: 350,
                       height: 350,
                       fit: BoxFit.contain,
                     ),
                   ),
                   const SizedBox(height: 15),
                   const Text(
                     'BUSINESS DEVELOPMENT',
                     style: TextStyle(
                       fontSize: 17,
                       fontWeight: FontWeight.w700,
                       color: Colors.black87,
                     ),
                   ),
                    const SizedBox(height: 25),

                   ClipRRect(
                     borderRadius: BorderRadius.circular(5),
                     child: Image.asset(
                       'assets/images/promise.jpg', // Replace with your image path
                       width: 350,
                       height: 350,
                       fit: BoxFit.contain,
                     ),
                   ),
                   const SizedBox(height: 15),
                   const Text(
                     'OPERATION SERVICES',
                     style: TextStyle(
                       fontSize: 17,
                       fontWeight: FontWeight.w700,
                       color: Colors.black87,
                     ),
                   ),
                    const SizedBox(height: 25),

                   ClipRRect(
                     borderRadius: BorderRadius.circular(5),
                     child: Image.asset(
                       'assets/images/dona.jpg', // Replace with your image path
                       width: 350,
                       height: 350,
                       fit: BoxFit.contain,
                     ),
                   ),
                   const SizedBox(height: 15),
                   const Text(
                     'PROJECT DEVELOPMENT',
                     style: TextStyle(
                       fontSize: 17,
                       fontWeight: FontWeight.w700,
                       color: Colors.black87,
                     ),
                   ),
                                  ],
                                ),
                      )
                    )
                      
                                       
                            ],
                          ),
                      
                    )
            : Container(
              margin: const EdgeInsets.only(
                left: 50, right: 40,
              ),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
              const Center(
                            child: Text(
                                              'Management Team',
                                              style: TextStyle(
                                                color: Color(
                                                    0xff32CD32),
                                                fontSize: 30,
                                                fontWeight:
                                                    FontWeight
                                                        .bold,
                                              ),
                                            ),
                          ),
                            const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
          height: 480,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: services.length,
            separatorBuilder: (_, __) => const SizedBox(width: 1),
            itemBuilder: (context, index) {
              final service = services[index];
              return Column(
                children: [
                  Column(
                         children: [
                           ClipRRect(
                                                borderRadius: BorderRadius.circular(5),
                                                child: Image.asset(
                                                  service["icon"]!, // Replace with your image path
                                                  width: 310,
                                                  height: 360,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                              const SizedBox(height: 15),
                                      Text(
                        service["title"]!,
                   style: const TextStyle(
                     fontSize: 17,
                     fontWeight: FontWeight.w700,
                     color: Colors.black87,
                   ),
                                     ),
                         ],
                       ),
                                     
                  
                                  
                ],
              );
            },
          ),
        ),
                
                ],
              ),
            );
  }
}



class SolvedaServicesApp extends StatefulWidget {
  const SolvedaServicesApp({super.key});

  @override
  State<SolvedaServicesApp> createState() => _SolvedaServicesAppState();
}

class _SolvedaServicesAppState extends State<SolvedaServicesApp> {
  @override
  Widget build(BuildContext context) {
                        var screenSize = MediaQuery.of(context).size;

    return
        Padding(
       padding: EdgeInsets.symmetric(horizontal:ResponsiveWidget.isSmallScreen(context)
          ? 50: 80, vertical: 50),
          child: Column(
            children: [
              ResponsiveWidget.isSmallScreen(context)
          ?  
           DefaultTextStyle(
            style:  TextStyle(
           color: Color(0xff32CD32),
           fontFamily: 'Mulish',
           
           fontSize: screenSize.width /25,
              fontWeight: FontWeight.w700,  ),
            child: AnimatedTextKit(
              animatedTexts: [
                WavyAnimatedText('Core Values', 
              speed: const Duration(milliseconds: 200),
                ),
              ],
              isRepeatingAnimation: true,
              // onTap: () {
              //   print("Tap Event");
              // },
            ),
          ):
              DefaultTextStyle(
            style:  TextStyle(
           color: const Color(0xff32CD32),
           fontFamily: 'Mulish',
           
           fontSize: screenSize.width /35,
              fontWeight: FontWeight.w700,  ),
            child: AnimatedTextKit(
              animatedTexts: [
                WavyAnimatedText('Core Values', 
              speed: const Duration(milliseconds: 200),
                ),
              ],
              isRepeatingAnimation: true,
              // onTap: () {
              //   print("Tap Event");
              // },
            ),
          ),
                  const SizedBox(height: 40),
          
              const ServicesGrid(),
            ],
          ),
        );
  }
}

class ServicesGrid extends StatefulWidget {
  const ServicesGrid({super.key});

  @override
  State<ServicesGrid> createState() => _ServicesGridState();
}

class _ServicesGridState extends State<ServicesGrid> {
  final List<ServiceItem> services = [
    ServiceItem(
      icon: Iconsax.arrow_circle_right_bold,
      title: 'Sustainability',
      bullets: ['Championing renewable energy and environmental conservation', ],
    ),
    ServiceItem(
      icon: Iconsax.arrow_circle_right_bold,
      title: 'Innovation',
      bullets: ['Embracing cutting-edge technology to deliver superior solutions.'],
    ),
    ServiceItem(
      icon: Iconsax.arrow_circle_right_bold,
      title: 'Integrity',
      bullets: ['Upholding transparency and accountability in every engagement.'],
    ),
    ServiceItem(
      icon: Iconsax.arrow_circle_right_bold,
      title: 'Customer Focus',
      bullets: ['Tailoring solutions to exceed expectations and foster trust.'],
    ),
     ServiceItem(
      icon: Iconsax.arrow_circle_right_bold,
      title: 'Excellence',
      bullets: ['Delivering durable, reliable systems that lead the industry.'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
                            var screenSize = MediaQuery.of(context).size;

    return  ResponsiveWidget.isSmallScreen(context)
          ? Center(
            child: ListView(
            shrinkWrap: true,
            
                  children: services.map((item) => Center(child: ServiceBox(item: item))).toList(),  
                  ),
          )
    :
    GridView.count(
      crossAxisCount: 2,
         childAspectRatio: screenSize.width *0.006, // Adjust this to control the height vs width
mainAxisSpacing: 20,
      crossAxisSpacing: 5,
      shrinkWrap: true,
      children: services.map((item) => ServiceBox(item: item)).toList(),
    );
  }
}

class ServiceItem {
  final IconData icon;
  final String title;
  final List<String> bullets;

  ServiceItem({required this.icon, required this.title, required this.bullets});
}

class ServiceBox extends StatelessWidget {
  final ServiceItem item;

  const ServiceBox({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(item.icon, size: 30, color: const Color(0xff8B4513)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                 padding: const EdgeInsets.symmetric(horizontal: 24.0),
                   constraints: const BoxConstraints(maxWidth: 600),
                child: Text(
                  item.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                     color: Color(0xff32CD32),
                  ),
                ),
              ),
              ...item.bullets.map(
                (b) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                   constraints: const BoxConstraints(maxWidth: 600),
                   margin: EdgeInsets.only(bottom: 20),
                  child: Text(b, 
                textAlign: TextAlign.justify, // This aligns both edges
                  style: const TextStyle(
                    fontSize: 16,
                     height: 1.5,
                    )
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}


