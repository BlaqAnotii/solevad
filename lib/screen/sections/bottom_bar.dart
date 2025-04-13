import 'package:flutter/material.dart';
import 'package:solevad/model/bottom_bar_column.dart';
import 'package:solevad/model/info_text.dart';

import 'package:solevad/screen/widget/responsive.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      height: ResponsiveWidget.isSmallScreen(context) ?550:300,
      color:  const Color.fromARGB(255, 42, 45, 46),
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
                      heading: 'SOLEVAD',
                      s1: 'Contact Us',
                      s2: 'About Us',
                      s3: 'Product & Services',
                      s4: 'Careers',
                    ),
                   
                    BottomBarColumn(
                      heading: 'FOLLOW US',
                     s1: 'Instagram @solevad',
                      s2: 'Facebook @solevad',
                      s3: 'LinkedIn @solevad',
                      s4: '',
                    ),
                  ],
                ),
                Container(
                  color: Colors.blueGrey,
                  width: double.maxFinite,
                  height: 1,
                ),
                                                  const SizedBox(height: 20),

  const Text(
            'CONTACT INFORMATION',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
                                  const SizedBox(height: 10),
                                                  const Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                         children: [
                                           Text(
                                                       'Head Office',
                                                       style: TextStyle(
                                                         color: Color(0xff32CD32),
                                                         fontSize: 16,
                                                         fontWeight: FontWeight.w500,
                                                       ),
                                                     ),
                                                     SizedBox(height: 5),

                        InfoText(
                          type: 'Phone',
                          text: '0913500046',
                        ),
                        SizedBox(height: 5),
                        InfoText(
                          type: 'Address',
                  text: 'Edo House Complex,\nSuite 105 Bishop Oluwole Street,\nVictoria Island.',
                        ),
                                         ],
                                       ),
                                                                         const SizedBox(height: 10),

                                    const Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                         children: [
                                           Text(
                                                       'Branch Office',
                                                       style: TextStyle(
                                                         color: Color(0xff32CD32),
                                                         fontSize: 16,
                                                         fontWeight: FontWeight.w500,
                                                       ),
                                                     ),
                                                     SizedBox(height: 5),

                        InfoText(
                          type: 'Phone',
                          text: '09028297993',
                        ),
                        SizedBox(height: 5),
                        InfoText(
                          type: 'Address',
                  text: 'Emekpa Junction Ughelli-Patani Road,\nUghelli-Delta State.',
                        ),
                                         ],
                                       ),         
                const SizedBox(height: 10),
                Container(
                  color: Colors.blueGrey,
                  width: double.maxFinite,
                  height: 1,
                ),
                const SizedBox(height: 10),
                Text(
                  'Copyright © 2020 | Solevad Energy',
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
                      heading: 'SOLEVAD',
                      s1: 'Contact Us',
                      s2: 'About Us',
                      s3: 'Product & Services',
                      s4: 'Careers',
                    ),
                    BottomBarColumn(
                      heading: 'FOLLOW US',
                      s1: 'Instagram @solevad',
                      s2: 'Facebook @solevad',
                      s3: 'LinkedIn @solevad',
s4: '',
                    ),
                    Container(
                      color: Colors.blueGrey,
                      width: 2,
                      height: 150,
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                          Text(
            'CONTACT INFORMATION',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                       Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                         children: [
                                           Text(
                                                       'Head Office',
                                                       style: TextStyle(
                                                         color: Color(0xff32CD32),
                                                         fontSize: 16,
                                                         fontWeight: FontWeight.w500,
                                                       ),
                                                     ),
                                                     SizedBox(height: 5),

                        InfoText(
                          type: 'Phone',
                          text: '0913500046',
                        ),
                        SizedBox(height: 5),
                        InfoText(
                          type: 'Address',
                  text: 'Edo House Complex,\nSuite 105 Bishop Oluwole Street,\nVictoria Island.',
                        ),
                                         ],
                                       ),
                                                                         SizedBox(width: 20),

                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                         children: [
                                           Text(
                                                       'Branch Office',
                                                       style: TextStyle(
                                                         color: Color(0xff32CD32),
                                                         fontSize: 16,
                                                         fontWeight: FontWeight.w500,
                                                       ),
                                                     ),
                                                     SizedBox(height: 5),

                        InfoText(
                          type: 'Phone',
                          text: '09028297993',
                        ),
                        SizedBox(height: 5),
                        InfoText(
                          type: 'Address',
                  text: 'Emekpa Junction Ughelli-Patani Road,\nUghelli-Delta State.',
                        ),
                                         ],
                                       ),         
                                    ],
                                  ),
             
                      ],
                    ),
                  ],
                ),
                                const SizedBox(height: 20),

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
                  'Copyright © 2020 | Solevad Energy',
                  style: TextStyle(
                                          

                    color: Colors.blueGrey[300],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
    );
  }
}
