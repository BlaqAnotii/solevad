import 'package:flutter/material.dart';


class ExploreDrawer extends StatefulWidget {
  const ExploreDrawer({
    Key? key,
  }) : super(key: key);

  @override
  _ExploreDrawerState createState() => _ExploreDrawerState();
}

class _ExploreDrawerState extends State<ExploreDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color:  Colors.blueGrey[900],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
             const SizedBox(height: 20),
              InkWell(
                onTap: () {},
                child: const Text(
                  'About Us',
                  style: TextStyle(color: Colors.white, fontSize: 22, fontFamily: 'CH'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Divider(
                  color: Colors.blueGrey[400],
                  thickness: 2,
                ),
              ),
              InkWell(
                onTap: () {},
                child: const Text(
                  'Our Services',
                  style: TextStyle(color: Colors.white, fontSize: 22, fontFamily: 'CH'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Divider(
                  color: Colors.blueGrey[400],
                  thickness: 2,
                ),
              ),
              InkWell(
                onTap: () {},
                child: const Text(
                  'Contact Us',
                  style: TextStyle(color: Colors.white, fontSize: 22, fontFamily: 'CH'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Divider(
                  color: Colors.blueGrey[400],
                  thickness: 2,
                ),
              ),
              InkWell(
                onTap: () {},
                child: const Text(
                  'News & Updates',
                  style: TextStyle(color: Colors.white, fontSize: 22, fontFamily: 'CH'),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'Copyright © 2024 | OAVL',
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
    );
  }
}
