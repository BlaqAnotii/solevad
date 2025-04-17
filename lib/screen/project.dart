import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:solevad/bloc/screen_offset.dart';

import 'package:solevad/screen/sections/bottom_bar.dart';
import 'package:solevad/screen/widget/responsive.dart';
import 'package:solevad/screen/widget/text_reveal.dart';
import 'package:solevad/screen/widget/text_transform.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({super.key});

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> with SingleTickerProviderStateMixin {
  OverlayEntry? _overlayEntry;
  bool _isSubMenuOpen = false;
  int? _hoveredMenuIndex;

  
// List of submenu items with routes
final Map<int, List<Map<String, String>>> _subMenuItems = {
  0: [
    {"title": "Our Team", "route": "/about-us/our-team"},
      {
        "title": "Our Vision, Mission & Values",
        "route": "/about-us/our-mission&vision&values"
      },
      {
        "title": "Careers at Solevad",
        "route": "/about-us/careers"
      },
  ],
  1: [
    {"title": "Solar Development", "route": "/products&services/solar-development"},
    {"title": "Energy Management Services", "route": "/products&services/energy-management"},
    {"title": "Operation and Maintenance", "route": "/products&services/operation&maintenance"},
    {"title": "Solar Financing", "route": "/products&services/solar-financing"},
  ],
};

int? _hoveredIndex; // null when nothing is hovered


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
              width: 350,
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
        child: Text(
          item["title"]!,
          style: TextStyle(
            color: _hoveredIndex == itemIndex ? Colors.blue[200] : Colors.black,
            fontSize: 17,
          ),
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
  Widget _buildMenuItem(BuildContext context,
      String title, int index) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          _hoveredMenuIndex = index;
        });
        _showSubMenu(
            context, index, event.position);
      },
      onExit: (_) {
        Future.delayed(
            const Duration(milliseconds: 300),
            () {
          if (!_isSubMenuOpen) {
            setState(
                () => _hoveredMenuIndex = null);
            _removeOverlay();
          }
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: _hoveredMenuIndex == index
                  ? Colors.blue[200]
                  : Colors.black,
              fontWeight: FontWeight.bold,
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

  late AnimationController controller;
  late Animation<double> textRevealAnimation;
  late Animation<double> textOpacityAnimation;
  late Animation<double> descriptionAnimation;

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
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

  late ScrollController controllers;
  double _scrollPosition = 0;
  double _opacity = 0;

  _scrollListener() {
    setState(() {
      _scrollPosition =
          controllers.position.pixels;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1700,
      ),
      reverseDuration: const Duration(
        milliseconds: 375,
      ),
    );

    textRevealAnimation =
        Tween<double>(begin: 60.0, end: 0.0)
            .animate(CurvedAnimation(
                parent: controller,
                curve: const Interval(0.0, 0.2,
                    curve: Curves.easeOut)));

    textOpacityAnimation =
        Tween<double>(begin: 0.0, end: 1.0)
            .animate(CurvedAnimation(
                parent: controller,
                curve: const Interval(0.0, 0.3,
                    curve: Curves.easeOut)));
    Future.delayed(
        const Duration(milliseconds: 1000), () {
      controller.forward();
    });

    controllers = ScrollController();
    controllers.addListener(_scrollListener);

    controllers.addListener(() {
      context
          .read<DisplayOffset>()
          .changeDisplayOffset(
              (MediaQuery.of(context)
                          .size
                          .height +
                      controllers.position.pixels)
                  .toInt());
    });
    super.initState();
  }

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
    _opacity =
        _scrollPosition < screenSize.height * 0.40
            ? _scrollPosition /
                (screenSize.height * 0.40)
            : 1;
    return Scaffold(
        backgroundColor:
            Theme.of(context).colorScheme.surface,
        extendBodyBehindAppBar: true,
        appBar: ResponsiveWidget.isSmallScreen(
                context)
            ? AppBar(
                backgroundColor:
                    const Color(0xffffffff),
                elevation: 0,
                centerTitle: true,
                toolbarHeight: 80,
                leading: Builder(
                  builder: (context) =>
                      IconButton(
                    icon: const Icon(
                        Iconsax.menu_1_outline,
                        color: Colors.black),
                    onPressed: () {
                      Scaffold.of(context)
                          .openDrawer(); // Opens the drawer using correct context
                    },
                  ),
                ),
                title: Image.asset(
                  'assets/images/newlogo.png',
                  scale: 6,
                ),
              )
            : PreferredSize(
              preferredSize: Size(screenSize.width, 1000),
              child: Container(
                color: const Color(0xfffffffff),
                child: Padding(
                  padding: const EdgeInsets.all(10),
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
                          scale: 6,
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
                                          : Colors.black,
                                          fontWeight: FontWeight.bold
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
                            _buildMenuItem(context, "About Us", 0),
                    SizedBox(width: screenSize.width / 20),
                    _buildMenuItem(context, "Products & Services", 1),
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
                                          : Colors.black,
                                          fontWeight: FontWeight.bold
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
                                          : Colors.black,
                                          fontWeight: FontWeight.bold
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
                          fixedSize: const Size(170, 45),
                          backgroundColor: const Color(0xff4779A3),
                        ),
                        child: const Text(
                          'Get Started',
                          style: TextStyle(
                            fontSize: 13,
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
              ),
            ), 
      drawer: Drawer(
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
              ExpansionTile(
                leading: const Icon(
                  Iconsax.profile_2user_bold,
                  size: 22,
                  color: Color(0xff4779A3),
                ),
                title: const Text(
                  'About us',
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
                      'Our Team',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                    onTap: () {
                      //  navigationService.push(const WithdrawMoneyScreen());
                                            context.go('/about-us/our-team');

                      // Navigate or handle logic for withdrawing money
                    },
                  ),
                  ListTile(
                    title: const Text(
                      'Our Vision, Mission & Values',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                    onTap: () {
                      // Navigate or handle logic for viewing withdrawal list
                      // navigationService
                      //     .push(const WithdarwalListScreen());
                                            context.go('/about-us/our-mission&vision&values');

                    },
                  ),
                  ListTile(
                    title: const Text(
                      'Careers at Solevad',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                    onTap: () {
                      // Navigate or handle logic for withdrawal settings
                      // navigationService
                      //     .push(const WithdrawalSettingScreen());
                      context.go('/about-us/careers');

                    },
                  ),
                ],
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
      ),
        body: ListView(
          controller: controllers,
          children: [
            ResponsiveWidget.isSmallScreen(
                    context)
                ? Container(
                    height: 400,
                    decoration:
                        const BoxDecoration(
                            image:
                                DecorationImage(
                                    fit: BoxFit
                                        .cover,
                                    colorFilter:
                                        ColorFilter
                                            .mode(
                                      Colors
                                          .black54,
                                      BlendMode
                                          .darken,
                                    ),
                                    image: AssetImage(
                                        'assets/images/operation.jpg'))),
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Padding(
                            padding:
                                const EdgeInsets
                                    .only(
                                    left: 40,
                                    top: 110),
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
                              children: [
                                TextReveal(
                                  maxHeight: 80,
                                  controller:
                                      controller,
                                  textOpacityAnimation:
                                      textOpacityAnimation,
                                  textRevealAnimation:
                                      textRevealAnimation,
                                  child:
                                      const Text(
                                    'Operation and Maintenance',
                                    style: TextStyle(
                                        fontSize:
                                            22,
                                        color: Colors
                                            .white,
                                        fontWeight:
                                            FontWeight
                                                .w800),
                                  ),
                                ),
                                const SizedBox(
                                  height: 18,
                                ),
                                TextTransform(
                                  maxHeight: 180,
                                  controller:
                                      controller,
                                  textOpacityAnimation:
                                      textOpacityAnimation,
                                  //textRevealAnimation: textRevealAnimation,
                                  child:
                                      const Text(
                                    'To ensure optimal performance and longevity, we provide comprehensive operation and maintenance services.',
                                    style: TextStyle(
                                        fontSize:
                                            13,
                                        color: Colors
                                            .white,
                                        fontWeight:
                                            FontWeight
                                                .w500),
                                  ),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                              ],
                            ),
                          ),
                        ),
                        //const Expanded(flex: 9, child: FirstPageImage())
                      ],
                    ),
                  )
                : Container(
                    height: 500,
                    decoration:
                        const BoxDecoration(
                            image:
                                DecorationImage(
                                    fit: BoxFit
                                        .cover,
                                    colorFilter:
                                        ColorFilter
                                            .mode(
                                      Colors
                                          .black54,
                                      BlendMode
                                          .darken,
                                    ),
                                    image: AssetImage(
                                        'assets/images/operation.jpg'))),
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Padding(
                            padding:
                                const EdgeInsets
                                    .only(
                                    left: 90,
                                    top: 130),
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
                              children: [
                                TextReveal(
                                  maxHeight: 110,
                                  controller:
                                      controller,
                                  textOpacityAnimation:
                                      textOpacityAnimation,
                                  textRevealAnimation:
                                      textRevealAnimation,
                                  child:
                                      const Text(
                                    'Operation and Maintenance',
                                    style: TextStyle(
                                        fontSize:
                                            45,
                                        color: Colors
                                            .white,
                                        fontWeight:
                                            FontWeight
                                                .w800),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextTransform(
                                  maxHeight: 180,
                                  controller:
                                      controller,
                                  textOpacityAnimation:
                                      textOpacityAnimation,
                                  //textRevealAnimation: textRevealAnimation,
                                  child:
                                      const Text(
                                    'To ensure optimal performance and longevity, we provide comprehensive operation\nand maintenance services.',
                                    style: TextStyle(
                                        fontSize:
                                            16,
                                        color: Colors
                                            .white,
                                        fontWeight:
                                            FontWeight
                                                .w500),
                                  ),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                              ],
                            ),
                          ),
                        ),
                        //const Expanded(flex: 9, child: FirstPageImage())
                      ],
                    ),
                  ),
            PreferredSize(
              preferredSize: Size(
                screenSize.width,
                1000,
              ),
              child: Container(
                color: const Color.fromARGB(
                    255, 253, 249, 249),
                height: 60,
                child: Padding(
                  padding:
                      const EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    scrollDirection:
                        Axis.horizontal,
                    child: Row(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .center,
                      mainAxisAlignment:
                          MainAxisAlignment.start,
                      children: [
                        SizedBox(
                            width:
                                screenSize.width /
                                    70),
                        InkWell(
                          onTap: () {
                            //  context.go('/Contact_us');
                          },
                          child: Column(
                            mainAxisSize:
                                MainAxisSize.min,
                            children: [
                              Text(
                                'HOME',
                                style: TextStyle(
                                    color: _isHovering[
                                            6]
                                        ? Colors.blue[
                                            200]
                                        : Colors
                                            .black,
                                    fontWeight:
                                        FontWeight
                                            .w400),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                            width:
                                screenSize.width /
                                    40),
                        const VerticalDivider(),
                        SizedBox(
                            width:
                                screenSize.width /
                                    40),
                        const Column(
                          mainAxisSize:
                              MainAxisSize.min,
                          children: [
                            Text(
                              'PRODUCT & SERVICES',
                              style: TextStyle(
                                  color: Colors
                                      .black,
                                  fontWeight:
                                      FontWeight
                                          .w400),
                            ),
                          ],
                        ),
                        SizedBox(
                            width:
                                screenSize.width /
                                    40),
                        const VerticalDivider(),
                        SizedBox(
                            width:
                                screenSize.width /
                                    40),
                        const Column(
                          mainAxisSize:
                              MainAxisSize.min,
                          children: [
                            Text(
                              'OPERATION & MAINTENANCE',
                              style: TextStyle(
                                  color: Colors
                                      .black,
                                  fontWeight:
                                      FontWeight
                                          .w400),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Divider(),
                          const SizedBox(height: 20,)    ,         

                      ResponsiveWidget.isSmallScreen(
                    context)
                ? Container(
                    margin: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 300,
                              width: 350,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/system.jpg'))),
                            ),
                          ],
                        ),
                        const Column(
                          mainAxisAlignment:
                              MainAxisAlignment
                                  .start,
                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .center,
                          children: [
                            Text(
                              'System Performance Monitoring',
                              style: TextStyle(
                                color: Color(
                                    0xff32CD32),
                                fontSize: 30,
                                fontWeight:
                                    FontWeight
                                        .bold,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'We offer System Performance Monitoring services for solar system installations to ensure optimal efficiency and reliability through Continuous remote monitoring for real-time analytics and reporting.',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    scrollDirection:
                        Axis.horizontal,
                    child: Container(
                      margin:
                          const EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 500,
                                width: 600,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/system.jpg'))),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                          const Column(
                            mainAxisAlignment:
                                MainAxisAlignment
                                    .start,
                            children: [
                              Text(
                                'System Performance Monitoring',
                                style: TextStyle(
                                  color: Color(
                                      0xff32CD32),
                                  fontSize: 30,
                                  fontWeight:
                                      FontWeight
                                          .bold,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'We offer System Performance Monitoring services for solar system installations\nto ensure optimal efficiency and reliability through Continuous remote monitoring\nfor real-time analytics and reporting.',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
            ResponsiveWidget.isSmallScreen(
                    context)
                ? Container(
                    margin: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 300,
                              width: 350,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/prevent.jpg'))),
                            ),
                          ],
                        ),
                        const Column(
                          mainAxisAlignment:
                              MainAxisAlignment
                                  .start,
                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .center,
                          children: [
                            Text(
                              'Preventive Maintenance',
                              style: TextStyle(
                                color: Color(
                                    0xff32CD32),
                                fontSize: 30,
                                fontWeight:
                                    FontWeight
                                        .bold,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'We provide Preventive Maintenance services for solar installations to ensure optimal performance and longevity of solar energy systems. Our approach focuses on regular  Scheduled inspections, cleaning of solar panels, and checks on inverters, batteries, and connections tasks that help identify and address potential issues before they escalate, thereby enhancing the reliability and efficiency of the solar systems.',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    scrollDirection:
                        Axis.horizontal,
                    child: Container(
                      margin:
                          const EdgeInsets.only(
                        left: 20,
                        right: 50,
                      ),
                      child: Row(
                        children: [
                          const Column(
                            mainAxisAlignment:
                                MainAxisAlignment
                                    .start,
                            children: [
                              Text(
                                'Preventive Maintenance',
                                style: TextStyle(
                                  color: Color(
                                      0xff32CD32),
                                  fontSize: 30,
                                  fontWeight:
                                      FontWeight
                                          .bold,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'We provide Preventive Maintenance services for solar installations to ensure\noptimal performance and longevity of solar energy systems. Our approach focuses\non regular  Scheduled inspections, cleaning of solar panels, and checks on inverters,\nbatteries, and connections tasks that help identify and address potential issues\nbefore they escalate, thereby enhancing the reliability and efficiency of the\nsolar systems.',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                          Column(
                            children: [
                              Container(
                                height: 500,
                                width: 650,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/prevent.jpg'))),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
            ResponsiveWidget.isSmallScreen(
                    context)
                ? Container(
                    margin: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 300,
                              width: 350,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/correct.jpg'))),
                            ),
                          ],
                        ),
                        const Column(
                          mainAxisAlignment:
                              MainAxisAlignment
                                  .start,
                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .center,
                          children: [
                            Text(
                              'Corrective Maintenance ',
                              style: TextStyle(
                                color: Color(
                                    0xff32CD32),
                                fontSize: 30,
                                fontWeight:
                                    FontWeight
                                        .bold,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'We offer Corrective Maintenance services for solar installations to address and resolve issues that may arise during the operation of solar energy systems. This service is essential for restoring systems to optimal functionality after a failure or performance drop has been detected. Our approach focuses Troubleshooting and repairing issues, including inverter failures, wiring damage, and shading concerns.',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    scrollDirection:
                        Axis.horizontal,
                    child: Container(
                      margin:
                          const EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 500,
                                width: 600,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/correct.jpg'))),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                          const Column(
                            mainAxisAlignment:
                                MainAxisAlignment
                                    .start,
                            children: [
                              Text(
                                'Corrective Maintenance',
                                style: TextStyle(
                                  color: Color(
                                      0xff32CD32),
                                  fontSize: 30,
                                  fontWeight:
                                      FontWeight
                                          .bold,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'We offer Corrective Maintenance services for solar installations to,address and resolve\nissues that may arise during the operation of solar energy systems. This service is\nessential for restoring systems to optimal functionality after a failure or performance\ndrop has been detected. Our approach focuses Troubleshooting and repairing issues,\nincluding inverter failures, wiring damage and shading concerns.',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
            ResponsiveWidget.isSmallScreen(
                    context)
                ? Container(
                    margin: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 300,
                              width: 350,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/learn4.png'))),
                            ),
                          ],
                        ),
                        const Column(
                          mainAxisAlignment:
                              MainAxisAlignment
                                  .start,
                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .center,
                          children: [
                            Text(
                              'After Sales Services',
                              style: TextStyle(
                                color: Color(
                                    0xff32CD32),
                                fontSize: 30,
                                fontWeight:
                                    FontWeight
                                        .bold,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Offering robust after-sales services is essential for ensuring customer satisfaction and the long-term success of solar installations. Our approach focuses on customer support system, warranty and reliability and customer  engagement and feedback.',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    scrollDirection:
                        Axis.horizontal,
                    child: Container(
                      margin:
                          const EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      child: Row(
                        children: [
                          const Column(
                            mainAxisAlignment:
                                MainAxisAlignment
                                    .start,
                            children: [
                              Text(
                                'After Sales Services',
                                style: TextStyle(
                                  color: Color(
                                      0xff32CD32),
                                  fontSize: 30,
                                  fontWeight:
                                      FontWeight
                                          .bold,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Offering robust after-sales services is essential for ensuring customer\nsatisfaction and the long-term success of solar installations. Our approach focuses\non customer support system, warranty and reliability and customer  engagement\nand feedback.',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          Column(
                            children: [
                              Container(
                                height: 500,
                                width: 650,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/learn4.png'))),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
            const SizedBox(
              height: 100.0,
            ),
            const BottomBar(),
          ],
        ));
  }

  bool termsAccepted = false;
}