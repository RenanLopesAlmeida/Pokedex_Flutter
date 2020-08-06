import 'package:flutter/material.dart';

class StatusBarWidget extends StatelessWidget {
  final double widthFactor;

  const StatusBarWidget({Key key, this.widthFactor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4,
      alignment: Alignment.centerLeft,
      decoration: ShapeDecoration(shape: StadiumBorder(), color: Colors.grey),
      child: FractionallySizedBox(
        widthFactor: widthFactor,
        heightFactor: 1.0,
        child: Container(
          decoration: ShapeDecoration(
            shape: StadiumBorder(),
            color: widthFactor > 0.5 ? Colors.deepPurpleAccent : Colors.green,
          ),
        ),
      ),
    );
  }
}
