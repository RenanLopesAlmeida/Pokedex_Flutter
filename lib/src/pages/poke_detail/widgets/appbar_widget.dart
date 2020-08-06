import 'package:flutter/material.dart';
import 'package:flutter_pokedex/src/consts/consts_app.dart';
import 'package:simple_animations/simple_animations.dart';

class AppbarWidget extends StatelessWidget {
  final MultiTrackTween animation;
  final double opacityTitleAppBar;

  const AppbarWidget({Key key, this.animation, this.opacityTitleAppBar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: <Widget>[
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            ControlledAnimation(
              playback: Playback.LOOP,
              duration: animation.duration,
              tween: animation,
              //curve: Curves.easeInOutSine,
              builder: (context, anim) {
                return Transform.rotate(
                  angle: anim['rotation'],
                  child: Opacity(
                    opacity: (opacityTitleAppBar >= 0.2) ? 0.2 : 0,
                    child: Image.asset(
                      ConstsApp.whitePokeball,
                      height: 60,
                      width: 60,
                    ),
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.favorite_border),
              onPressed: () {},
            )
          ],
        ),
      ],
    );
  }
}
