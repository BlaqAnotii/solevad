import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:oavltd/bloc/screen_offset.dart';
import 'package:oavltd/model/news.dart';
import 'package:oavltd/screen/sections/bottom_bar.dart';
import 'package:oavltd/screen/widget/energy_card.dart';
import 'package:oavltd/screen/widget/responsive.dart';
import 'package:oavltd/screen/widget/text_reveal.dart';
import 'package:oavltd/screen/widget/text_transform.dart';

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
  final Map<int, List<Map<String, String>>>
      _subMenuItems = {
    0: [
      {"title": "Our Team", "route": "/our-team"},
      {
        "title": "Our Vision, Mission & Values",
        "route": "/our-vision"
      },
      {
        "title": "Careers at Solevad",
        "route": "/our-mission"
      },
    ],
    1: [
      {
        "title": "Comprehensive Solar Services",
        "route":
            "/products&services/solar-services"
      },
      {
        "title": "Energy Management Services",
        "route":
            "/products&services/energy-management"
      },
      {
        "title":
            "Project Development & Management",
        "route":
            "/products&services/project-management"
      },
      {
        "title":
            "Product Supply and Distribution",
        "route":
            "/products&services/product-supply"
      },
    ],
  };

  /// Show submenu on hover
  void _showSubMenu(BuildContext context,
      int index, Offset position) {
    _removeOverlay(); // Remove existing submenu first

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: position.dx,
        top: position.dy + 30,
        child: MouseRegion(
          onEnter: (_) => _isSubMenuOpen =
              true, // Keep submenu open
          onExit: (_) {
            Future.delayed(
                const Duration(milliseconds: 300),
                () {
              if (!_isSubMenuOpen) {
                _removeOverlay();
              }
            });
          },
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: 250,
              padding: const EdgeInsets.symmetric(
                  vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(8),
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
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: _subMenuItems[index]!
                    .map((item) {
                  return InkWell(
                    onTap: () {
                      _removeOverlay(); // Close menu
                      context.go(item["route"]!);
                    },
                    child: Padding(
                      padding: const EdgeInsets
                          .symmetric(
                          vertical: 12,
                          horizontal: 16),
                      child: Text(item["title"]!,
                          style: const TextStyle(
                            fontSize: 17,
                              color:
                                  Colors.black)),
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
                preferredSize:
                    Size(screenSize.width, 1000),
                child: Container(
                  color: const Color(0xfffffffff),
                  child: Padding(
                    padding:
                        const EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .center,
                      children: [
                        SizedBox(
                            width:
                                screenSize.width /
                                    70),
                        Image.asset(
                          'assets/images/newlogo.png',
                          scale: 6,
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
                            mainAxisAlignment:
                                MainAxisAlignment
                                    .center,
                            children: [
                              SizedBox(
                                  width: screenSize
                                          .width /
                                      12),
                              _buildMenuItem(
                                  context,
                                  "About Us",
                                  0),
                              SizedBox(
                                  width: screenSize
                                          .width /
                                      20),
                              _buildMenuItem(
                                  context,
                                  "Products & Services",
                                  1),
                              SizedBox(
                                  width: screenSize
                                          .width /
                                      20),
                              InkWell(
                                onHover: (value) {
                                  setState(() {
                                    value
                                        ? _isHovering[
                                                2] =
                                            true
                                        : _isHovering[
                                                2] =
                                            false;
                                  });
                                },
                                onTap: () {
                                  //  context.go('/Contact_us');
                                },
                                child: Column(
                                  mainAxisSize:
                                      MainAxisSize
                                          .min,
                                  children: [
                                    Text(
                                      'Contact Us',
                                      style: TextStyle(
                                          color: _isHovering[2]
                                              ? Colors.blue[
                                                  200]
                                              : Colors
                                                  .black,
                                          fontWeight:
                                              FontWeight.bold),
                                    ),
                                    const SizedBox(
                                        height:
                                            5),
                                    Visibility(
                                      maintainAnimation:
                                          true,
                                      maintainState:
                                          true,
                                      maintainSize:
                                          true,
                                      visible:
                                          _isHovering[
                                              2],
                                      child:
                                          Container(
                                        height: 2,
                                        width: 20,
                                        color: Colors
                                            .white,
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
                        SizedBox(
                            width:
                                screenSize.width /
                                    20),
                        ElevatedButton(
                          onPressed: () {
                            //context.go('/Our_Services');
                            //context.go('/whatsapp');
                          },
                          style: ElevatedButton
                              .styleFrom(
                            fixedSize: const Size(
                                170, 45),
                            backgroundColor:
                                const Color(
                                    0xff4779A3),
                          ),
                          child: const Text(
                            'Get Started',
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(
                                  0xffffffff),
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          width:
                              screenSize.width /
                                  20,
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
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              mainAxisAlignment:
                  MainAxisAlignment.start,
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
                        'Comprehensive Solar Service',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                      onTap: () {
                        //  navigationService.push(const WithdrawMoneyScreen());
                        context.go(
                            '/products&services/solar-services');
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
                        context.go(
                            '/products&services/energy-management');
                      },
                    ),
                    ListTile(
                      title: const Text(
                        'Project Development & Management',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                      onTap: () {
                        // Navigate or handle logic for withdrawal settings
                        // navigationService
                        //     .push(const WithdrawalSettingScreen());
                        context.go(
                            '/products&services/project-management');
                      },
                    ),
                    ListTile(
                      title: const Text(
                        'Product Supply and Distribution',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                      onTap: () {
                        // Navigate or handle logic for withdrawal settings
                        // navigationService
                        //     .push(const WithdrawalSettingScreen());
                        context.go(
                            '/products&services/product-supply');
                      },
                    ),
                  ],
                ),
                const ListTile(
                  leading: Icon(
                    Iconsax.call_add_bold,
                    size: 22,
                    color: Color(0xff4779A3),
                  ),
                  title: Text(
                    'Contact Us',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ),
                const Expanded(
                  child: Align(
                    alignment:
                        Alignment.bottomCenter,
                    child: Text(
                      'Copyright © 2024 | Solevad Energy',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight:
                              FontWeight.w500),
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
                                        'assets/images/testimony.png'))),
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
                                    'Project Development & Management',
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
                                    'Our Extensive Project Development and Management involves a comprehensive approach to conceptualizing, planning, implementing, and maintaining solar energy projects. These projects can range from small residential solar installations to large-scale commercial solar, Mini Grid Projects, large home system, solar street project, energy efficiency housing projects.',
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
                                        'assets/images/testimony.png'))),
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
                                    'Project Development & Management',
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
                                    'Our Extensive Project Development and Management involves a comprehensive\napproach to conceptualizing, planning, implementing, and maintaining solar energy projects.\nThese projects can range from small residential solar installations to large-scale commercial solar,\nMini Grid Projects, large home system, solar street project, energy\nefficiency housing projects.',
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
                              'PROJECT MANAGEMENT',
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
                          const SizedBox(height: 70,)    ,         

              //                ResponsiveWidget.isSmallScreen(
              //       context)
                  
              //   ?
              //   Container(
              //   margin: const EdgeInsets.only(
              //     left: 20, right: 20
              //   ),
              //   child: const Column(
              //     children: [
              //       Column(
              //         crossAxisAlignment: CrossAxisAlignment.center,
              //         children: [
              //           Center(
              //             child: Text(
              //                               'Advisory & consultancy for energy management system',
              //                               style: TextStyle(
              //                                 color: Color(
              //                                     0xff32CD32),
              //                                 fontSize: 20,
              //                                 fontWeight:
              //                                     FontWeight
              //                                         .bold,
              //                               ),
              //                             ),
              //           ),
              //            SizedBox(
              //                         height: 30,
              //                       ),
              //                       Center(
              //                         child: Text(
              //                           'Through consultancy and advisory services, we offer Energy Management System to our clients to a remotely host, managed and supported system. Helping customer increase reliability, and optimize energy usage to reduce cost. We are Committed to providing users with system solutions for energy efficiency management and electricity safety.',
              //                           style: TextStyle(
              //                             fontSize: 16,
              //                           ),
              //                         ),
              //                       ),
              //         ],
              //       ),
                   
              //     ],
              //   ),
              // )
              // :
            SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(
                  left: 120, right: 20
                ),
                child:  Row(
                  children: [
                   
                   

                     const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                                            'What We Do',
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
                         SizedBox(
                                      height: 20,
                                    ),
                                   Row(
                                    children: [
                                      Icon(Icons.arrow_forward_ios,
                                       color:  Color(0xff4779A3),),
                                       SizedBox(width: 10,),
                                       Text(
                                            'Feasibility Study',
                                            style: TextStyle(
                                              
                                              fontSize: 15,
                                              fontWeight:
                                                  FontWeight
                                                      .w500,
                                            ),
                                          ),
                                    ],
                                   ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                   Row(
                                    children: [
                                     Icon(Icons.arrow_forward_ios,
                                       color:  Color(0xff4779A3),),
                                       SizedBox(width: 10,),
                                       Text(
                                            'Project Planning',
                                            style: TextStyle(
                                              
                                              fontSize: 15,
                                              fontWeight:
                                                  FontWeight
                                                      .w500,
                                            ),
                                          ),
                                    ],
                                   ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                   Row(
                                    children: [
                                      Icon(Icons.arrow_forward_ios,
                                       color:  Color(0xff4779A3),),
                                       SizedBox(width: 10,),
                                       Text(
                                            'Financing and Procurement',
                                            style: TextStyle(
                                              
                                              fontSize: 15,
                                              fontWeight:
                                                  FontWeight
                                                      .w500,
                                            ),
                                          ),
                                    ],
                                   ),
                                     SizedBox(
                                      height: 10,
                                    ),
                                   Row(
                                    children: [
                                      Icon(Icons.arrow_forward_ios,
                                       color:  Color(0xff4779A3),),
                                       SizedBox(width: 10,),
                                       Text(
                                            'Implementation',
                                            style: TextStyle(
                                              
                                              fontSize: 15,
                                              fontWeight:
                                                  FontWeight
                                                      .w500,
                                            ),
                                          ),
                                    ],
                                   ),   
                                     SizedBox(
                                      height: 10,
                                    ),
                                   Row(
                                    children: [
                                      Icon(Icons.arrow_forward_ios,
                                       color:  Color(0xff4779A3),),
                                       SizedBox(width: 10,),
                                       Text(
                                            'Performance Monitoring',
                                            style: TextStyle(
                                              
                                              fontSize: 15,
                                              fontWeight:
                                                  FontWeight
                                                      .w500,
                                            ),
                                          ),
                                    ],
                                   ),   
                                   SizedBox(
                                    height: 1000,
                                   )  
                      ],
                    ),
                     const SizedBox(width: 5,),
                
                                        const SizedBox(width: 200,),
                     Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        )
                      ),
                       child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                                              'Feasibility Study',
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
                           SizedBox(
                                        height: 30,
                                      ),
                                      Center(
                                        child: Text(
                                          '- Site Assessment : Evaluating location suitability for solar installation.',
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                        child: Text(
                                          '- Resource Analysis : Measuring solar radiation, shading, and environmental impact.',
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                        child: Text(
                                          '- Financial Viability : Determining ROI, payback period, and overall project cost-effectiveness.',
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
SizedBox(
                                        height: 50,
                                      ),

                                      Center(
                            child: Text(
                                              'Project Planning',
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
                           SizedBox(
                                        height: 30,
                                      ),
                                      Center(
                                        child: Text(
                                          '- Design and Engineering : Creating optimal system designs based on energy needs.',
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                        child: Text(
                                          '- Permits and Compliance : Securing local, state, and federal approvals for solar installations.',
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                        child: Text(
                                          '- Stakeholder Engagement : Coordinating with utilities, investors, and community members.',
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 50,
                                      ),

                                      Center(
                            child: Text(
                                              'Financing and Procurement',
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
                           SizedBox(
                                        height: 30,
                                      ),
                                      Center(
                                        child: Text(
                                          '- Funding Acquisition : Arranging capital through loans, grants, or Power Purchase\nAgreements (PPAs).',
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                        child: Text(
                                          '- Equipment Procurement : Selecting reliable solar panels, inverters, and other\ncomponents.',
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    SizedBox(
                                        height: 50,
                                      ),

                                      Center(
                            child: Text(
                                              'Implementation',
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
                           SizedBox(
                                        height: 30,
                                      ),
                                      Center(
                                        child: Text(
                                          '- Installation: Managing on-site activities, including mounting, wiring, and\nconnecting systems.',
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                        child: Text(
                                          '- Project Management: Overseeing schedules, budgets, and quality\nassurance.',
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 50,
                                      ),

                                      Center(
                            child: Text(
                                              'Performance Monitoring',
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
                           SizedBox(
                                        height: 30,
                                      ),
                                      Center(
                                        child: Text(
                                          '- Testing: Verifying system performance and efficiency post-installation.',
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                        child: Text(
                                          '- Maintenance Plans: Establishing long-term operation and maintenance protocols.',
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                       SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                        child: Text(
                                          '- Data Monitoring: Implementing real-time tracking systems to monitor\nenergy output.',
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 190,
                                      ),
                                      
                                      
                        ],
                                           ),
                     ),
                                    
                  ],
                ),
              ),
            ),
                           
              const SizedBox(height: 70,)    ,         
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
                                          'assets/images/learn1.png'))),
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
                              'Load Audit and system design',
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
                              'At Solevad Energy, we specialize in providing comprehensive Load Audit and System Design solutions to meet your energy needs efficiently and sustainably. By performing a detailed load audit and designing a solar system to meet our client’s unique energy needs, organizations can maximize efficiency, minimize costs, and contribute to environmental sustainability.',
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
                        left: 40,
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
                                            'assets/images/learn1.png'))),
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
                                'Load Audit and system design',
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
                                'At Solevad Energy, we specialize in providing comprehensive Load Audit and System\nDesign solutions to meet your energy needs efficiently and sustainably. By performing\na detailed load audit and designing a solar system to meet our client’s unique energy\nneeds, organizations can maximize efficiency, minimize costs, and contribute to\nenvironmental sustainability.',
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
                                          'assets/images/learn2.png'))),
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
                              'Energy Usage Analysis Service',
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
                              'We also specialize on providing Energy Usage Analysis services designed to help individuals, businesses, and organizations understand and optimize their energy consumption. By understanding consumption patterns, the right capacity for solar panels, inverters, and battery storage can be determined, ensuring cost-effectiveness and reliability.',
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
                        left: 40,
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
                                'Energy Usage Analysis Service',
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
                                'We also specialize on providing Energy Usage Analysis services designed\nto help individuals, businesses, and organizations understand and optimize\ntheir energy consumption. By understanding consumption patterns, the right\ncapacity for solar panels, inverters, and battery storage can be determined,\nensuring cost-effectiveness and reliability.',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 70,
                          ),
                          Column(
                            children: [
                              Container(
                                height: 500,
                                width: 650,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/learn2.png'))),
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
                                          'assets/images/learn33.jpg'))),
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
                              'Energy Efficiency Conversion Studies and Implementation',
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
                              'At Solevad we are committed to helping clients transition to more energy-efficient systems through Energy Efficiency Conversion Studies and Implementation Services. Our expertise ensures that you maximize energy savings, enhance system performance, and reduce your environmental footprint.',
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
                        left: 40,
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
                                            'assets/images/learn33.jpg'))),
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
                                'Energy Efficiency Conversion Studies and\nImplementation',
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
                                'At Solevad we are committed to helping clients transition to more energy-efficient\nsystems through Energy Efficiency Conversion Studies and Implementation\nServices. Our expertise ensures that you maximize energy savings, enhance\nsystem performance, and reduce your environmental\nfootprint. ',
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
                              'After-Sales Support Services',
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
                              'Customer satisfaction is our top priority. That’s why we provide comprehensive After-Sales Support Services to ensure the smooth operation of your purchased products and solutions long after the initial sale.',
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
                        left: 40,
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
                                'After-Sales Support Services',
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
                                'Customer satisfaction is our top priority. That’s why we provide comprehensive\nAfter-Sales Support Services to ensure the smooth operation of your\npurchased products and solutions long after the initial sale.',
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
          
            const Padding(
              padding: EdgeInsets.all(40.0),
              child: Divider(),
            ),
            const SizedBox(
              height: 10,
            ),
             SingleChildScrollView(
              scrollDirection: Axis.horizontal,
               child: Row(
                   children: newss
                       .map((newss) => NewsCards(
                             newss,
                           ))
                       .toList()),
             ),
                const SizedBox(
              height: 15,
            ),
            const Padding(
              padding: EdgeInsets.all(40.0),
              child: Divider(),
            ),
            const SizedBox(
              height: 10,
            ),
            ResponsiveWidget.isSmallScreen(
                    context)
                ? Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.center,
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Questions about Energy Management? Request a free online appointment with Solevad.',
                        style: TextStyle(
                          fontSize: 22,
                          color:
                              Color(0xff32CD32),
                        ),
                        textAlign:
                            TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Container(
                        height: 650,
                        width: 700,
                        margin:
                            const EdgeInsets.all(
                                15),
                        padding:
                            const EdgeInsets.all(
                                15),
                        decoration: BoxDecoration(
                          color: Colors
                              .white, // Background color
                          borderRadius:
                              BorderRadius
                                  .circular(10),

                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey
                                  .withOpacity(
                                      0.5), // Light shadow
                              blurRadius: 3,
                              offset:
                                  const Offset(
                                      0, 4),
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child:  Column(
                          children: [
                             const SizedBox(
                                height: 20),
                                 TextFormField(
                                    decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                          left:
                                              10,
                                          top: 5,
                                          bottom:
                                              5,
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintStyle: TextStyle(
                                          color: Colors
                                              .grey,
                                          fontWeight:
                                              FontWeight.w400,
                                        ),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                          color: Colors
                                              .grey,
                                          width:
                                              0.5,
                                        )),
                                        hintText: 'First Name'),
                                  ), 
                                  const SizedBox(
                                height: 20),
                                   TextFormField(
                                  decoration:
                                      const InputDecoration(
                                          contentPadding:
                                              EdgeInsets
                                                  .only(
                                            left:
                                                10,
                                            top:
                                                5,
                                            bottom:
                                                5,
                                          ),
                                          filled:
                                              true,
                                          fillColor:
                                              Colors
                                                  .white,
                                          hintStyle:
                                              TextStyle(
                                            color:
                                                Colors.grey,
                                            fontWeight:
                                                FontWeight.w400,
                                          ),
                                          border:
                                              OutlineInputBorder(
                                                  borderSide:
                                                      BorderSide(
                                            color:
                                                Colors.grey,
                                            width:
                                                0.5,
                                          )),
                                          hintText:
                                              'Last Name'),
                                ),
                                 const SizedBox(
                                height: 20),
                                   TextFormField(
                                  decoration:
                                      const InputDecoration(
                                          contentPadding:
                                              EdgeInsets
                                                  .only(
                                            left:
                                                10,
                                            top:
                                                5,
                                            bottom:
                                                5,
                                          ),
                                          filled:
                                              true,
                                          fillColor:
                                              Colors
                                                  .white,
                                          hintStyle:
                                              TextStyle(
                                            color:
                                                Colors.grey,
                                            fontWeight:
                                                FontWeight.w400,
                                          ),
                                          border:
                                              OutlineInputBorder(
                                                  borderSide:
                                                      BorderSide(
                                            color:
                                                Colors.grey,
                                            width:
                                                0.5,
                                          )),
                                          hintText:
                                              'Address'),
                                ),
                                const SizedBox(
                                height: 20),
                                   TextFormField(
                                  decoration:
                                      const InputDecoration(
                                          contentPadding:
                                              EdgeInsets
                                                  .only(
                                            left:
                                                10,
                                            top:
                                                5,
                                            bottom:
                                                5,
                                          ),
                                          filled:
                                              true,
                                          fillColor:
                                              Colors
                                                  .white,
                                          hintStyle:
                                              TextStyle(
                                            color:
                                                Colors.grey,
                                            fontWeight:
                                                FontWeight.w400,
                                          ),
                                          border:
                                              OutlineInputBorder(
                                                  borderSide:
                                                      BorderSide(
                                            color:
                                                Colors.grey,
                                            width:
                                                0.5,
                                          )),
                                          hintText:
                                              'Email'),
                                ),
                                const SizedBox(
                                height: 20),
                                   TextFormField(
                                  decoration:
                                      const InputDecoration(
                                          contentPadding:
                                              EdgeInsets
                                                  .only(
                                            left:
                                                10,
                                            top:
                                                5,
                                            bottom:
                                                5,
                                          ),
                                          filled:
                                              true,
                                          fillColor:
                                              Colors
                                                  .white,
                                          hintStyle:
                                              TextStyle(
                                            color:
                                                Colors.grey,
                                            fontWeight:
                                                FontWeight.w400,
                                          ),
                                          border:
                                              OutlineInputBorder(
                                                  borderSide:
                                                      BorderSide(
                                            color:
                                                Colors.grey,
                                            width:
                                                0.5,
                                          )),
                                          hintText:
                                              'Mobile Phone'),
                                ),
                                 const SizedBox(
                                height: 20),
                            Row(
                              children: [
                                Transform.scale(
                                  scale: 1,
                                  child: Checkbox(
                                    side:
                                        const BorderSide(
                                      color: Colors
                                          .grey,
                                    ),
                                    activeColor:
                                        Colors
                                            .black,
                                    focusColor:
                                        Colors
                                            .black,
                                    checkColor:
                                        Colors
                                            .grey,
                                    value:
                                        termsAccepted,
                                    onChanged:
                                        (bool?
                                            value) {
                                      setState(
                                          () {
                                        termsAccepted =
                                            value ??
                                                false;
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Expanded(
                                  child: Text(
                                    'I own my Home',
                                    maxLines: 2,
                                    style:
                                        TextStyle(
                                      fontSize:
                                          15,
                                      fontWeight:
                                          FontWeight
                                              .w400,
                                      color: Colors
                                          .black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                             const SizedBox(
                                height: 20),
                            const Text(
                              'By clicking the “Get a Quote” button below, I authorize Solevad Energy. and its agents or representatives, to contact me on the phone number provided to send SMS messages or contact me by phone about a solar project. We will send text messages about support, n appointments, reminders, notifications. Consent is not a condition of purchase.',
                              style: TextStyle(),
                            ),
                             const SizedBox(
                                height: 30),
                                Center(
                                  child: ElevatedButton(
                                                          onPressed: () {
                                                            //context.go('/Our_Services');
                                                            //context.go('/whatsapp');
                                                          },
                                                          style: ElevatedButton.styleFrom(
                                                            fixedSize: const Size(170, 45),
                                                            backgroundColor: const Color(0xff4779A3),
                                                          ),
                                                          child: const Text(
                                                            'Get a Quote',
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
                    ],
                  )
                : Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.center,
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Questions about Energy Management? Request a free online\nappointment with Solevad.',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight:
                              FontWeight.w700,
                          color:
                              Color(0xff32CD32),
                        ),
                        textAlign:
                            TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 500,
                        width: 1200,
                        margin:
                            const EdgeInsets.all(
                                15),
                        padding:
                            const EdgeInsets.all(
                                25),
                        decoration: BoxDecoration(
                          color: Colors
                              .white, // Background color
                          borderRadius:
                              BorderRadius
                                  .circular(10),

                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey
                                  .withOpacity(
                                      0.5), // Light shadow
                              blurRadius: 3,
                              offset:
                                  const Offset(
                                      0, 4),
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,
                          children: [
                            const SizedBox(
                                height: 20),
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceEvenly,
                              children: [
                                Expanded(
                                  child:
                                      TextFormField(
                                    decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                          left:
                                              10,
                                          top: 5,
                                          bottom:
                                              5,
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintStyle: TextStyle(
                                          color: Colors
                                              .grey,
                                          fontWeight:
                                              FontWeight.w400,
                                        ),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                          color: Colors
                                              .grey,
                                          width:
                                              0.5,
                                        )),
                                        hintText: 'First Name'),
                                  ),
                                ),
                                const SizedBox(
                                    width: 15),
                                Expanded(
                                    child:
                                        TextFormField(
                                  decoration:
                                      const InputDecoration(
                                          contentPadding:
                                              EdgeInsets
                                                  .only(
                                            left:
                                                10,
                                            top:
                                                5,
                                            bottom:
                                                5,
                                          ),
                                          filled:
                                              true,
                                          fillColor:
                                              Colors
                                                  .white,
                                          hintStyle:
                                              TextStyle(
                                            color:
                                                Colors.grey,
                                            fontWeight:
                                                FontWeight.w400,
                                          ),
                                          border:
                                              OutlineInputBorder(
                                                  borderSide:
                                                      BorderSide(
                                            color:
                                                Colors.grey,
                                            width:
                                                0.5,
                                          )),
                                          hintText:
                                              'Last Name'),
                                )),
                              ],
                            ),
                            const SizedBox(
                                height: 30),
                            TextFormField(
                              decoration:
                                  const InputDecoration(
                                      contentPadding:
                                          EdgeInsets
                                              .only(
                                        left: 10,
                                        top: 5,
                                        bottom: 5,
                                      ),
                                      filled:
                                          true,
                                      fillColor:
                                          Colors
                                              .white,
                                      hintStyle:
                                          TextStyle(
                                        color: Colors
                                            .grey,
                                        fontWeight:
                                            FontWeight
                                                .w400,
                                      ),
                                      border:
                                          OutlineInputBorder(
                                              borderSide:
                                                  BorderSide(
                                        color: Colors
                                            .grey,
                                        width:
                                            0.5,
                                      )),
                                      hintText:
                                          'Address'),
                            ),
                            const SizedBox(
                                height: 30),
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceEvenly,
                              children: [
                                Expanded(
                                  child:
                                      TextFormField(
                                    decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                          left:
                                              10,
                                          top: 5,
                                          bottom:
                                              5,
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintStyle: TextStyle(
                                          color: Colors
                                              .grey,
                                          fontWeight:
                                              FontWeight.w400,
                                        ),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                          color: Colors
                                              .grey,
                                          width:
                                              0.5,
                                        )),
                                        hintText: 'Email'),
                                  ),
                                ),
                                const SizedBox(
                                    width: 15),
                                Expanded(
                                    child:
                                        TextFormField(
                                  decoration:
                                      const InputDecoration(
                                          contentPadding:
                                              EdgeInsets
                                                  .only(
                                            left:
                                                10,
                                            top:
                                                5,
                                            bottom:
                                                5,
                                          ),
                                          filled:
                                              true,
                                          fillColor:
                                              Colors
                                                  .white,
                                          hintStyle:
                                              TextStyle(
                                            color:
                                                Colors.grey,
                                            fontWeight:
                                                FontWeight.w400,
                                          ),
                                          border:
                                              OutlineInputBorder(
                                                  borderSide:
                                                      BorderSide(
                                            color:
                                                Colors.grey,
                                            width:
                                                0.5,
                                          )),
                                          hintText:
                                              'Mobile Phone'),
                                )),
                              ],
                            ),
                            const SizedBox(
                                height: 50),
                            Row(
                              children: [
                                Transform.scale(
                                  scale: 2,
                                  child: Checkbox(
                                    side:
                                        const BorderSide(
                                      color: Colors
                                          .grey,
                                    ),
                                    activeColor:
                                        Colors
                                            .black,
                                    focusColor:
                                        Colors
                                            .black,
                                    checkColor:
                                        Colors
                                            .grey,
                                    value:
                                        termsAccepted,
                                    onChanged:
                                        (bool?
                                            value) {
                                      setState(
                                          () {
                                        termsAccepted =
                                            value ??
                                                false;
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Expanded(
                                  child: Text(
                                    'I own my Home',
                                    maxLines: 2,
                                    style:
                                        TextStyle(
                                      fontSize:
                                          19,
                                      fontWeight:
                                          FontWeight
                                              .w400,
                                      color: Colors
                                          .black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                                height: 20),
                            const Text(
                              'By clicking the “Get a Quote” button below, I authorize Solevad Energy. and its agents or representatives, to contact me on the phone number provided to send SMS messages or contact me by phone about a solar project. We will send text messages about support, n appointments, reminders, notifications. Consent is not a condition of purchase.',
                              style: TextStyle(),
                            ),
                             const SizedBox(
                                height: 30),
                                ElevatedButton(
                        onPressed: () {
                          //context.go('/Our_Services');
                          //context.go('/whatsapp');
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(170, 45),
                          backgroundColor: const Color(0xff4779A3),
                        ),
                        child: const Text(
                          'Get a Quote',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xffffffff),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ), 
                          ],
                        ),
                      ),
                    ],
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