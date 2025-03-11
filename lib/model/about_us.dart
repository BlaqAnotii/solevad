import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Link extends StatefulWidget {
  const Link({super.key});

  @override
  State<Link> createState() => _LinkState();
}

class _LinkState extends State<Link> {

  

  @override
  void initState() {
    super.initState();
  _launchURL();
  }

    Future<void> _launchURL() async {
    final Uri url = Uri.parse('https://wa.me/+2348076692285');
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication, // Opens in a new browser tab/window
    )) {
      throw Exception('Could not launch $url');
    }
  }


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      
     
    );
  }
}