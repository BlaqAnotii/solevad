import 'package:flutter/material.dart';
import 'package:oavltd/model/bottom_bar_column.dart';
import 'package:oavltd/model/info_text.dart';
import 'package:oavltd/screen/widget/responsive.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      color:  Colors.blueGrey[900],
      child: ResponsiveWidget.isSmallScreen(context)
          ? Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BottomBarColumn(
                      ontap: () {
                        
                      },
                      heading: 'ABOUT',
                      s1: 'Contact Us',
                      s2: 'About Us',
                      s3: 'Join Our Community ',
                      s4: 'Whatsapp',
                    ),
                   
                    BottomBarColumn(
                      heading: 'SOCIAL',
                     s1: 'Instagram @onosekevweagro',
                      s2: 'Facebook @ Onosekevwe Agro Ventures LTD',
                      s3: 'LinkedIn @ Onoseke-vwe Agro Ventures LTD',
                      s4: '+2348076692285',
                    ),
                  ],
                ),
                Container(
                  color: Colors.blueGrey,
                  width: double.maxFinite,
                  height: 1,
                ),
                const SizedBox(height: 20),
                InfoText(
                  type: 'Email',
                  text: 'explore@gmail.com',
                ),
                const SizedBox(height: 5),
                InfoText(
                  type: 'Address',
                  text: ' 6 Ejavota street along Olori road, Ughelli, Delta State.',
                ),
                const SizedBox(height: 20),
                Container(
                  color: Colors.blueGrey,
                  width: double.maxFinite,
                  height: 1,
                ),
                const SizedBox(height: 20),
                Text(
                  'Copyright © 2020 | Onoseke-vwe Agro Ventures Ltd',
                  style: TextStyle(
                    color: Colors.blueGrey[300],
                    fontSize: 12,
                  ),
                ),
              ],
            )
          : Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BottomBarColumn(
                      heading: 'ABOUT',
                      s1: 'Contact Us',
                      s2: 'About Us',
                      s3: 'Join Our Community',
                      s4: 'Whatsapp',
                    ),
                    BottomBarColumn(
                      heading: 'SOCIAL',
                      s1: 'Instagram @onosekevweagro',
                      s2: 'Facebook @ Onosekevwe Agro Ventures LTD',
                      s3: 'LinkedIn @ Onoseke-vwe Agro Ventures LTD',
                     s4: '+2348076692285',

                    ),
                    Container(
                      color: Colors.blueGrey,
                      width: 2,
                      height: 150,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InfoText(
                          type: 'Email',
                          text: 'explore@gmail.com',
                        ),
                        const SizedBox(height: 5),
                        InfoText(
                          type: 'Address',
                  text: ' 6 Ejavota street along Olori road, Ughelli, Delta State.',
                        )
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.blueGrey,
                    width: double.maxFinite,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Copyright © 2020 | Onoseke-vwe Agro Ventures Ltd',
                  style: TextStyle(
                                          fontFamily: 'CH',

                    color: Colors.blueGrey[300],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
    );
  }
}
