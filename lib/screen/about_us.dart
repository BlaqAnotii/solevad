
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:oavltd/bloc/screen_offset.dart';
import 'package:oavltd/screen/sections/bottom_bar.dart';
import 'package:oavltd/screen/widget/responsive.dart';
import 'package:oavltd/screen/widget/text_reveal.dart';
import 'package:oavltd/screen/widget/text_transform.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> with SingleTickerProviderStateMixin  {


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
      _scrollPosition = controllers.position.pixels;
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

    textRevealAnimation = Tween<double>(begin: 60.0, end: 0.0).animate(
        CurvedAnimation(
            parent: controller,
            curve: const Interval(0.0, 0.2, curve: Curves.easeOut)));

    textOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: controller,
            curve: const Interval(0.0, 0.3, curve: Curves.easeOut)));
    Future.delayed(const Duration(milliseconds: 1000), () {
      controller.forward();
    });

    controllers = ScrollController();
    controllers.addListener(_scrollListener);

    controllers.addListener(() {
      context.read<DisplayOffset>().changeDisplayOffset(
          (MediaQuery.of(context).size.height + controllers.position.pixels)
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

    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
     var screenSize = MediaQuery.of(context).size;
 _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;
      return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      extendBodyBehindAppBar: true,
      appBar: 
      ResponsiveWidget.isSmallScreen(context)
          ? AppBar(
              backgroundColor:
                  Colors.blueGrey[900],
              elevation: 0,
              centerTitle: true,
         leading: Builder(
      builder: (context) => IconButton(
        icon: const Icon(Icons.menu, color: Colors.white),
        onPressed: () {
          Scaffold.of(context).openDrawer();  // Opens the drawer using correct context
        },
      ),
    ),
              title: Text(
                'Onoseke-vwe Agro Ventures Ltd',
                style: TextStyle(
                  color: Colors.blueGrey[100],
                  fontSize: 17,
                  fontFamily: 'CH',
                  fontWeight: FontWeight.w500,
                  letterSpacing: 3,
                ),
              ),
             
            )
          :
       PreferredSize(
      preferredSize: Size(screenSize.width, 1000),
      child: Container(
        color: Colors.blueGrey[900],
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                                  SizedBox(width: screenSize.width / 30),

              Text(
                'Onoseke-vwe Agro Ventures Ltd',
                style: TextStyle(
                  color: Colors.blueGrey[100],
                  fontSize: 20,
                  fontFamily: 'CH',
                  fontWeight: FontWeight.w500,
                  letterSpacing: 3,
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(width: screenSize.width / 7),
                    InkWell(
                      onHover: (value) {
                        setState(() {
                          value
                              ? _isHovering[0] = true
                              : _isHovering[0] = false;
                        });
                      },
                      onTap: () {
                                                            context.go('/About_Us');

                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'About Us',
                            style: TextStyle(
                                                fontFamily: 'CH',
                              color: _isHovering[0]
                                  ? Colors.blue[200]
                                  : Colors.white,
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
                                                            context.go('/Our_Services');

                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Our Services',
                            style: TextStyle(
                             fontFamily: 'CH',
                              color: _isHovering[1]
                                  ? Colors.blue[200]
                                  : Colors.white,
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
                    InkWell(
                      onHover: (value) {
                        setState(() {
                          value
                              ? _isHovering[2] = true
                              : _isHovering[2] = false;
                        });
                      },
                      onTap: () {
                                                                              context.go('/Contact_us');

                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Contact Us',
                            style: TextStyle(
                             fontFamily: 'CH',
                              color: _isHovering[2]
                                  ? Colors.blue[200]
                                  : Colors.white,
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
                     SizedBox(width: screenSize.width / 20),
                    InkWell(
                      onHover: (value) {
                        setState(() {
                          value
                              ? _isHovering[3] = true
                              : _isHovering[3] = false;
                        });
                      },
                      onTap: () {},
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Join Our Community',
                            style: TextStyle(
                             fontFamily: 'CH',
                              color: _isHovering[3]
                                  ? Colors.blue[200]
                                  : Colors.white,
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
                width: screenSize.width / 20,
              ),
         
            ],
          ),
        ),
      ),
    ),
    drawer:  
        Drawer(
      child: Container(
        color:  Colors.blueGrey[900],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
             const SizedBox(height: 50),
              InkWell(
                onTap: () {
                                                                context.go('/About_Us');

                },
                child: const Text(
                  'About Us',
                  style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: 'CH'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Divider(
                  color: Colors.blueGrey[400],
                  thickness: 0.5,
                ),
              ),
              InkWell(
                onTap: () {
                                                                        context.go('/Our_Services');

                },
                child: const Text(
                  'Our Services',
                  style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: 'CH'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Divider(
                  color: Colors.blueGrey[400],
                  thickness: 0.5,
                ),
              ),
              InkWell(
                onTap: () {
                                                                        context.go('/Contact_us');

                },
                child: const Text(
                  'Contact Us',
                  style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: 'CH'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Divider(
                  color: Colors.blueGrey[400],
                  thickness: 0.5,
                ),
              ),
              InkWell(
                onTap: () {
                                                    context.go('/join_community');

                },
                child: const Text(
                  'Join Our Community',
                  style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: 'CH'),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'Copyright © 2024 | Onoseke-vwe Agro Ventures Ltd',
                    style: TextStyle(
                      color: Colors.blueGrey[300],
                      fontSize: 14,
                      fontFamily: 'CH'
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ),
      body: ListView(
      controller: controllers,
      children: [
ResponsiveWidget.isSmallScreen(context)
          ? 
           Container(
      height: 400,
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
                        colorFilter:
                            ColorFilter.mode(Colors.grey, BlendMode.darken,),
          image: AssetImage('assets/images/warehouse.jpg'))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.only(left: 40, top: 110),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextReveal(
                    maxHeight: 50,
                    controller: controller,
                    textOpacityAnimation: textOpacityAnimation,
                    textRevealAnimation: textRevealAnimation,
                    child: const Text(
                      'About Us',
                      style: TextStyle(
                          fontFamily: 'CH',
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  
                  const SizedBox(
                    height: 18,
                  ),
                  TextTransform(
                    maxHeight: 80,
                    controller: controller,
                    textOpacityAnimation: textOpacityAnimation,
                    //textRevealAnimation: textRevealAnimation,
                    child: const Text(
                      'With 25+ years of years experience,we are committed to providing high-quality agro-inputs\nand innovative solutions to boost productivity and food security.',
                      style: TextStyle(
                          fontFamily: 'CH',
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
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
      height: 400,
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          colorFilter:
                            ColorFilter.mode(Colors.green, BlendMode.darken,),
          image: AssetImage('assets/images/warehouse.jpg'))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.only(left: 90, top: 130),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextReveal(
                    maxHeight: 100,
                    controller: controller,
                    textOpacityAnimation: textOpacityAnimation,
                    textRevealAnimation: textRevealAnimation,
                    child: const Text(
                      'About Us',
                      style: TextStyle(
                          fontFamily: 'CH',
                          fontSize: 45,
                          color: Colors.white,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  
                  const SizedBox(
                    height: 20,
                  ),
                  TextTransform(
                    maxHeight: 100,
                    controller: controller,
                    textOpacityAnimation: textOpacityAnimation,
                    //textRevealAnimation: textRevealAnimation,
                    child: const Text(
                      'With 25+ years of years experience,we are committed to providing high-quality agro-inputs\nand innovative solutions to boost productivity and food security.',
                      style: TextStyle(
                          fontFamily: 'CH',
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
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
//SecondScreen(),
        const SizedBox(
          height: 100.0,
        ),
         Center(
           child: TextReveal(
                      maxHeight: 50,
                      controller: controller,
                      textOpacityAnimation: textOpacityAnimation,
                      textRevealAnimation: textRevealAnimation,
                      child: const Text(
                        'About Onoseke-vwe Agro Ventures Ltd,',
                        style: TextStyle(
                            fontFamily: 'CH',
                            fontSize: 19,
                            color: Colors.black,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
         ),
          Center(
            child: TextTransform(
                      maxHeight: 100,
                      controller: controller,
                      textOpacityAnimation: textOpacityAnimation,
                      //textRevealAnimation: textRevealAnimation,
                      child: const Padding(
                        padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        child: Text(
                          'Onoseke-vwe Agro Ventures Ltd (Onoseke-vwe Agro Ventures Ltd) is one of the biggest players in Nigeria’s livestock sector, dedicated to improving food security and empowering livestock farmers with high-quality agro-inputs and innovative farming solutions. Founded in 1996 by Mrs. Mercy Etso, Onoseke-vwe Agro Ventures Ltd launched its first agro-inputs store in 2004, and in 2008, was officially registered as a limited company. Since then, Onoseke-vwe Agro Ventures Ltd has grown into a reputable agricultural company that combines a wealth of experience with a strong commitment to advancing sustainable agriculture across Nigeria and Africa. With over 20 years in the livestock value chain, Onoseke-vwe Agro Ventures Ltd is focused on supporting farmers by providing them with the resources they need to boost productivity and achieve efficient farming practices.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'CH',
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
          ),
           const SizedBox(
          height: 60.0,
        ),
        Center(
           child: TextReveal(
                      maxHeight: 50,
                      controller: controller,
                      textOpacityAnimation: textOpacityAnimation,
                      textRevealAnimation: textRevealAnimation,
                      child: const Text(
                        'Our Mission',
                        style: TextStyle(
                            fontFamily: 'CH',
                            fontSize: 19,
                            color: Colors.black,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
         ),
          Center(
            child: TextTransform(
                      maxHeight: 100,
                      controller: controller,
                      textOpacityAnimation: textOpacityAnimation,
                      //textRevealAnimation: textRevealAnimation,
                      child: const Padding(
                        padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        child: Text(
                          'To combat food insecurity in Africa through the provision of quality agro-inputs, feed manufacturing, and reliable food distribution.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'CH',
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
          ),
          const SizedBox(
          height: 60.0,
        ),
        Center(
           child: TextReveal(
                      maxHeight: 50,
                      controller: controller,
                      textOpacityAnimation: textOpacityAnimation,
                      textRevealAnimation: textRevealAnimation,
                      child: const Text(
                        'Our Vision',
                        style: TextStyle(
                            fontFamily: 'CH',
                            fontSize: 19,
                            color: Colors.black,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
         ),
          Center(
            child: TextTransform(
                      maxHeight: 100,
                      controller: controller,
                      textOpacityAnimation: textOpacityAnimation,
                      //textRevealAnimation: textRevealAnimation,
                      child: const Padding(
                        padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        child: Text(
                          'To lead the agricultural sector in Africa by providing exceptional agro-inputs and services that support farmers and promote food security.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'CH',
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
          ),
           const SizedBox(
          height: 60.0,
        ),
        Center(
           child: TextReveal(
                      maxHeight: 50,
                      controller: controller,
                      textOpacityAnimation: textOpacityAnimation,
                      textRevealAnimation: textRevealAnimation,
                      child: const Text(
                        'Our Culture',
                        style: TextStyle(
                            fontFamily: 'CH',
                            fontSize: 19,
                            color: Colors.black,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
         ),
          Center(
            child: TextTransform(
                      maxHeight: 100,
                      controller: controller,
                      textOpacityAnimation: textOpacityAnimation,
                      //textRevealAnimation: textRevealAnimation,
                      child: const Padding(
                        padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        child: Text(
                          'Onoseke-vwe Agro Ventures Ltd’s culture is centered on integrity, delivering exceptional quality, fostering innovation, and focusing on meeting customer needs. We believe in building strong relationships with farmers, customers, and partners to create value and address the challenges facing agriculture in Africa. We are committed to empowering the farming community by providing continuous support, education, and access to resources.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'CH',
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
          ),
          const SizedBox(
          height: 60.0,
        ),
        Center(
           child: TextReveal(
                      maxHeight: 50,
                      controller: controller,
                      textOpacityAnimation: textOpacityAnimation,
                      textRevealAnimation: textRevealAnimation,
                      child: const Text(
                        'Why Choose Onoseke-vwe Agro Ventures Ltd?',
                        style: TextStyle(
                            fontFamily: 'CH',
                            fontSize: 19,
                            color: Colors.black,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
         ),
          Center(
            child: TextTransform(
                      maxHeight: 100,
                      controller: controller,
                      textOpacityAnimation: textOpacityAnimation,
                      //textRevealAnimation: textRevealAnimation,
                      child: const Padding(
                        padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        child: Text(
                          'With over two decades of experience, Onoseke-vwe Agro Ventures Ltd has built a reputation for excellence in the agricultural sector. We understand the needs of livestock farmers and are committed to providing solutions that drive productivity and sustainability. Our innovative approaches, such as the Onoseke-vwe Agro Ventures Ltd Community, set us apart as a company dedicated to transforming agriculture in Africa. Whether you are a livestock farmer seeking reliable inputs, an agro-dealer looking for quality products, or a partner aiming to make an impact in the agricultural space, Onoseke-vwe Agro Ventures Ltd is your trusted ally in making a difference',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'CH',
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
          ),
        const SizedBox(
          height: 100.0,
        ),
        BottomBar(),
      ],
    )
    );
  }
}