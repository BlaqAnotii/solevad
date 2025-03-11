
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:oavltd/bloc/screen_offset.dart';
import 'package:oavltd/model/about_us.dart';
import 'package:oavltd/screen/about_us.dart';
import 'package:oavltd/screen/contact_us.dart';
import 'package:oavltd/screen/our_community.dart';
import 'package:oavltd/screen/our_service.dart';
import 'package:oavltd/screen/whole_screen.dart';
import 'package:oavltd/screen/widget/responsive.dart';


void main() {
    WidgetsFlutterBinding.ensureInitialized();

   final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MyHomePage(),
      routes: <RouteBase>[
      
        GoRoute(
          path: 'home',
          builder: (context, GoRouterState state) {
            return const MyHomePage();
          },
        ),
        GoRoute(
          path: 'About_Us',
          builder: (context, GoRouterState state) {
            return const AboutUsScreen();
          },
        ),
        GoRoute(
          path: 'Our_Services',
          builder: (context, GoRouterState state) {
            return const OurServiceScreen();
          },
        ),
         GoRoute(
          path: 'Contact_us',
          builder: (context, GoRouterState state) {
            return const ContactUsScreen();
          },
        ),
         GoRoute(
          path: 'join_community',
          builder: (context, GoRouterState state) {
            return const JoinCommunityScreen ();
          },
        ),
        GoRoute(
          path: 'whatsapp',
          builder: (context, GoRouterState state) {
            return const Link();
          },
        ),
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
        fontFamily: 'JosefinSans'
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
    {"title": "Our Team", "route": "/our-team"},
    {"title": "Our Vision", "route": "/our-vision"},
    {"title": "Our Mission", "route": "/our-mission"},
  ],
  1: [
    {"title": "Comprehensive Solar Services", "route": "/solar-services"},
    {"title": "Energy Management Services", "route": "/energy-management"},
    {"title": "Project Development & Management", "route": "/project-management"},
    {"title": "Product Supply and Distribution", "route": "/product-supply"},
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
              width: 250,
              padding: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
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
                      Navigator.pushNamed(context, item["route"]!);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      child: Text(item["title"]!,
                          style: const TextStyle(color: Colors.black)),
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: screenSize.width / 12),
                            _buildMenuItem(context, "About Us", 0),
                    SizedBox(width: screenSize.width / 20),
                    _buildMenuItem(context, "Our Services", 1),
                            SizedBox(width: screenSize.width / 20),
                            InkWell(
                              onHover: (value) {
                                setState(() {
                                  value
                                      ? _isHovering[2] = true
                                      : _isHovering[2] = false;
                                });
                              },
                              onTap: () {
                                //  context.go('/Contact_us');
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Contact Us',
                                    style: TextStyle(
                                      color: _isHovering[2]
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
                                    visible: _isHovering[2],
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
                          //context.go('/whatsapp');
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
                      'Our Mission',
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
                      'Our Vision',
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
              const ListTile(
                leading: Icon(
                  Iconsax.cloud_lightning_bold,
                  size: 22,
                  color: Color(0xff4779A3),
                ),
                title: Text(
                  'Our Services',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
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
