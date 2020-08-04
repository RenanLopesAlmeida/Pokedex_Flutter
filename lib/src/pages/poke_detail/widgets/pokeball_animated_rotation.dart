import 'package:flutter/material.dart';
import 'package:flutter_pokedex/src/consts/consts_app.dart';
import 'package:flutter_pokedex/src/models/pokeapi.dart';
import 'package:simple_animations/simple_animations.dart';

class PokeballAnimatedRotation extends StatelessWidget {
  final MultiTrackTween animation;
  final Pokemon pokemonItem;

  PokeballAnimatedRotation({this.animation, this.pokemonItem});

  @override
  Widget build(BuildContext context) {
    return ControlledAnimation(
      playback: Playback.LOOP,
      duration: animation.duration,
      tween: animation,
      curve: Curves.easeInOutSine,
      builder: (context, anim) {
        return Transform.rotate(
          angle: anim['rotation'],
          child: Hero(
            tag: pokemonItem.name + 'rotation',
            child: Opacity(
              opacity: 0.2,
              child: Image.asset(
                ConstsApp.whitePokeball,
                height: 280,
                width: 280,
              ),
            ),
          ),
        );
      },
    );
  }
}
