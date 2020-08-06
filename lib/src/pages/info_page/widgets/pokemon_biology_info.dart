import 'package:flutter/material.dart';

class PokemonBiologyInfo extends StatelessWidget {
  final String biologyTitle;
  final String biologyValue;
  final TextStyle titleStyle;
  final TextStyle valueStyle;

  PokemonBiologyInfo({
    @required this.biologyTitle,
    @required this.biologyValue,
    @required this.titleStyle,
    @required this.valueStyle,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Row(
        children: <Widget>[
          Text(
            biologyTitle,
            style: titleStyle,
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            biologyValue,
            style: valueStyle,
          ),
        ],
      ),
    );
  }
}
