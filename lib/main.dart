import 'package:flutter/material.dart';

import 'package:qr_scanner/src/pages/home_page.dart';
import 'package:qr_scanner/src/pages/map_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QRScanner',
      initialRoute: 'home',
      routes: <String, WidgetBuilder>{
        'home': (context) => HomePage(),
        'map': (context) => MapPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
    );
  }
}
