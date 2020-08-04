import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_pokedex/src/consts/consts_app.dart';
import 'package:flutter_pokedex/src/models/pokeapi.dart';
import 'package:flutter_pokedex/stores/pokeapi_store.dart';
import 'package:simple_animations/simple_animations.dart';

class PokeballAnimatedRotation extends StatelessWidget {
  final MultiTrackTween animation;
  final Pokemon pokemonItem;
  final PokeApiStore pokeApiStore;
  final int index;

  PokeballAnimatedRotation({
    this.animation,
    this.pokemonItem,
    this.pokeApiStore,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    return ControlledAnimation(
      playback: Playback.LOOP,
      duration: animation.duration,
      tween: animation,
      curve: Curves.easeInOutSine,
      builder: (context, anim) {
        return Observer(
          builder: (ctx) {
            return Transform.rotate(
              angle: anim['rotation'],
              child: Hero(
                tag: pokemonItem.name + 'rotation',
                child: Opacity(
                  opacity: (pokeApiStore.currentPosition == index) ? 0.2 : 0,
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
      },
    );
  }
}
