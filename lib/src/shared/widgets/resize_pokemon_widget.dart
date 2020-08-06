import 'package:flutter/material.dart';

class ResizePokemonWidget extends StatelessWidget {
  final Widget widget;

  ResizePokemonWidget({this.widget});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 80,
      child: widget,
    );
  }
}
