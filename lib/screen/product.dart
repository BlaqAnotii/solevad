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

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen>with SingleTickerProviderStateMixin {
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
    
    return  Scaffold(
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
                    image: AssetImage('assets/images/fin1.jpg',),
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
                  'Solar Financing',
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
      'We make solar energy accessible and affordable by offering flexible financing solutions designed to meet diverse needs, through the following key components.',
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
                    image: AssetImage('assets/images/fin1.jpg',),
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
                  'Solar Financing',
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
      'We make solar energy accessible and affordable by offering flexible financing solutions designed to meet diverse needs, through the following key components.',
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
              Renewables15(),
              Renewables17(),
                            Renewables16(),
                            Renewables18(),

      //               Sustain(),
      // Renewable(),
      // EnergyManage(),
      // EnergyProcure(),
       SizedBox(height: 25),


                 
          BottomBar(),
            ]
          ),
        )
               
        ],
      ),
    );
    
  }

  bool termsAccepted = false;
}


class Renewables15 extends StatefulWidget {
  const Renewables15({super.key});

  @override
  State<Renewables15> createState() => _Renewables15State();
}

class _Renewables15State extends State<Renewables15> {
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
                         'Flexible Loan Options',
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
                       "Secured and unsecured loan options tailored to your financial situation.",
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
                         'assets/images/fin2.jpg', // Replace with your image path
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
                         'assets/images/fin2.jpg', // Replace with your image path
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
                           'Flexible Loan Options',
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
                       "Secured and unsecured loan options tailored to your financial situation.",
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



class Renewables16 extends StatefulWidget {
  const Renewables16({super.key});

  @override
  State<Renewables16> createState() => _Renewables16State();
}

class _Renewables16State extends State<Renewables16> {
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
                         'Quick Approval Process',
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
                       "Streamlined applications to enable faster project execution.",
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
                         'assets/images/fin4.jpg', // Replace with your image path
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
                         'assets/images/fin4.jpg', // Replace with your image path
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
                           'Quick Approval Process',
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
                       "Streamlined applications to enable faster project execution.",
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






class Renewables17 extends StatefulWidget {
  const Renewables17({super.key});

  @override
  State<Renewables17> createState() => _Renewables17State();
}

class _Renewables17State extends State<Renewables17> {
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
                         'Competitive Rates',
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
                       "Affordable interest rates and payment terms for manageable costs.",
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
                         'assets/images/fin3.jpg', // Replace with your image path
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
                           'Competitive Rates',
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
                       "Affordable interest rates and payment terms for manageable costs.",
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
                         'assets/images/fin3.jpg', // Replace with your image path
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


class Renewables18 extends StatefulWidget {
  const Renewables18({super.key});

  @override
  State<Renewables18> createState() => _Renewables18State();
}

class _Renewables18State extends State<Renewables18> {
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
                         'Power Purchase Agreements (PPA)',
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
                       "At Solevad Energy , we provide Power Purchase Agreement (PPA) financing 	solutions for solar energy installations, enabling clients to enjoy the benefits 	of solar power without upfront capital investment. Under this model, we design, install, and maintain the solar system on your premises, while you pay only for the power you consume at a lower, predictable rate than traditional electricity sources. This approach helps reduce energy costs, manage cash flow efficiently, and achieve sustainability goals with zero ownership risks.",
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
                         'assets/images/fin5.jpg', // Replace with your image path
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
    constraints: const BoxConstraints(maxWidth: 500),
                     child: const Text(
                           'Power Purchase Agreements (PPA)',
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
                       "At Solevad Energy , we provide Power Purchase Agreement (PPA) financing 	solutions for solar energy installations, enabling clients to enjoy the benefits 	of solar power without upfront capital investment. Under this model, we design, install, and maintain the solar system on your premises, while you pay only for the power you consume at a lower, predictable rate than traditional electricity sources. This approach helps reduce energy costs, manage cash flow efficiently, and achieve sustainability goals with zero ownership risk.",
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
                         'assets/images/fin5.jpg', // Replace with your image path
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