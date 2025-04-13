
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:solevad/bloc/screen_offset.dart';
import 'package:solevad/screen/blog.dart';
import 'package:solevad/screen/careers.dart';
import 'package:solevad/screen/contact_us.dart';
import 'package:solevad/screen/energy.dart';
import 'package:solevad/screen/our_community.dart';
import 'package:solevad/screen/our_service.dart';
import 'package:solevad/screen/our_team.dart';
import 'package:solevad/screen/our_values.dart';
import 'package:solevad/screen/product.dart';
import 'package:solevad/screen/project.dart';
import 'package:solevad/screen/solar.dart';
import 'package:solevad/screen/whole_screen.dart';
import 'package:solevad/screen/widget/responsive.dart';



void main() {
    WidgetsFlutterBinding.ensureInitialized();

   final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MyHomePage(),
      routes: <RouteBase>[
      
        GoRoute(
          path: '/home',
          builder: (context, GoRouterState state) {
            return const MyHomePage();
          },
        ),
        GoRoute(
          path: '/products&services/solar-development',
          builder: (context, GoRouterState state) {
            return const SolarScreen();
          },
        ),
         GoRoute(
          path: '/products&services/energy-management',
          builder: (context, GoRouterState state) {
            return const EnergyScreen();
          },
        ),
       GoRoute(
          path: '/products&services/operation&maintenance',
          builder: (context, GoRouterState state) {
            return const ProjectScreen();
          },
        ),
         GoRoute(
          path: '/products&services/solar-financing',
          builder: (context, GoRouterState state) {
            return const ProductScreen();
          },
        ),
          GoRoute(
          path: '/about-us/our-team',
          builder: (context, GoRouterState state) {
            return const OurTeamScreen();
          },
        ),
             GoRoute(
          path: '/about-us/our-mission&vision&values',
          builder: (context, GoRouterState state) {
            return const OurValuesScreen();
          },
        ),
          GoRoute(
          path: '/about-us/careers',
          builder: (context, GoRouterState state) {
            return const CareerScreen();
          },
        ),
        // GoRoute(
        //   path: 'Our_Services',
        //   builder: (context, GoRouterState state) {
        //     return const OurServiceScreen();
        //   },
        // ),
         GoRoute(
          path: '/contact_us',
          builder: (context, GoRouterState state) {
            return const ContactUsScreen();
          },
        ),
           GoRoute(
          path: '/blog',
          builder: (context, GoRouterState state) {
            return const BlogScreen();
          },
        ),
        //  GoRoute(
        //   path: 'join_community',
        //   builder: (context, GoRouterState state) {
        //     return const JoinCommunityScreen ();
        //   },
        // ),
        // GoRoute(
        //   path: 'whatsapp',
        //   builder: (context, GoRouterState state) {
        //     return const Link();
        //   },
        // ),
        // GoRoute(
        //   path: 'join-business',
        //   builder: (context, GoRouterState state) {
        //     return const JoinBusinessView();
        //   },
        // )
      ],
    ),
  ],
);
  runApp(MyApp(router: router,));
}

class MyApp extends StatefulWidget {
  final GoRouter router;

  const MyApp({super.key, required this.router});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Solevad Energy',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Mulish'
      ),
        routerConfig: widget.router,

    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
                children: _subMenuItems[index]!.map((item) {
                  return InkWell(
                    onTap: () {
                      _removeOverlay(); // Close menu
                      context.go( item["route"]!);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      child: Text(item["title"]!,
                          style: const TextStyle(color: Colors.black, fontSize: 17)),
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
              color: _hoveredMenuIndex == index ? Colors.blue[200] : Colors.black,
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

  late ScrollController _scrollController;
  double _scrollPosition = 0;
  double _opacity = 0;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
        var screenSize = MediaQuery.of(context).size;
 _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;
    return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
      extendBodyBehindAppBar: true,
      appBar: ResponsiveWidget.isSmallScreen(context)
          ? AppBar(
              backgroundColor: const Color(0xffffffff),
              elevation: 0,
              centerTitle: true,
              toolbarHeight: 80,
              leading: Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Iconsax.menu_1_outline, color: Colors.black),
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
          :
      PreferredSize(
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
      body: BlocProvider(
        create: (context) => DisplayOffset(ScrollOffset(scrollOffsetValue: 0)),
        child: const WholeScreen(),
      ),
    );
  }
}
