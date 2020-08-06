import 'package:flutter/material.dart';

class CircularProgressAbout extends StatelessWidget {
  final Color color;

  CircularProgressAbout({@required this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 30,
        width: 30,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            color,
          ),
        ),
      ),
    );
  }
}
