import 'package:flutter/material.dart';
import './widgets/app_bar_home.dart';
import '../../consts/consts_app.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    double _statusbarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Stack(
        overflow: Overflow.visible,
        alignment: Alignment.topCenter,
        children: <Widget>[
          Positioned(
            top: (-240 / 4.7),
            left: _screenWidth - (240 / 1.6),
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(
                ConstsApp.darkPokeball,
                height: 240,
                width: 240,
              ),
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: _statusbarHeight,
                ),
                AppBarHome(),
                Expanded(
                  child: Container(
                    child: ListView(
                      children: <Widget>[
                        ListTile(
                          title: Text('Pokemon'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
