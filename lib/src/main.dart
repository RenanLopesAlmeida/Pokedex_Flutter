import 'package:flutter/material.dart';
import './pages/home_page/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'Google',
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              headline5: TextStyle(
                fontFamily: 'Google',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              subtitle2: TextStyle(
                fontFamily: 'Google',
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
      ),
    );
  }
}
