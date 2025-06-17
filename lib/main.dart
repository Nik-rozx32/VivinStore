import 'package:flutter/material.dart';

import 'package:vivinstore/screens/home_page.dart';

void main() {
  runApp(DressShopApp());
}

class DressShopApp extends StatelessWidget {
  const DressShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vivin Store',
      theme: ThemeData(
        primaryColor: Color(0xFF2C1810),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFF8B4513),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Montserrat',
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
