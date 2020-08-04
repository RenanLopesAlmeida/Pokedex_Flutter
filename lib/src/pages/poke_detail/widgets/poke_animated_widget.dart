import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_pokedex/src/models/pokeapi.dart';
import 'package:flutter_pokedex/stores/pokeapi_store.dart';

class PokeAnimatedWidget extends StatelessWidget {
  final int index;
  final PokeApiStore pokemonStore;
  final Pokemon pokemonItem;

  PokeAnimatedWidget({this.index, this.pokemonStore, this.pokemonItem});

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return AnimatedPadding(
          duration: Duration(milliseconds: 500),
          curve: Curves.bounceInOut,
          padding: EdgeInsets.all(
            (index == pokemonStore.currentPosition) ? 0 : 60,
          ),
          child: Hero(
            tag: pokemonItem.name,
            child: CachedNetworkImage(
              height: 160,
              width: 160,
              color: (index == pokemonStore.currentPosition)
                  ? null
                  : Colors.black.withOpacity(0.4),
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey,
                  strokeWidth: 1.8,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.deepPurpleAccent,
                  ),
                ),
              ),
              imageUrl:
                  'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/${pokemonItem.num}.png',
            ),
          ),
        );
      },
    );
  }
}
