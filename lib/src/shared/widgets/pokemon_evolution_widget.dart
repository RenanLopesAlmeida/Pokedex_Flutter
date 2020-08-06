import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_pokedex/src/models/pokeapi.dart';
import 'package:flutter_pokedex/src/shared/widgets/resize_pokemon_widget.dart';
import 'package:flutter_pokedex/src/stores/pokeapi_store.dart';

class PokemonEvolutionWidget extends StatelessWidget {
  final PokeApiStore pokemonStore;

  PokemonEvolutionWidget({this.pokemonStore});

  List<Widget> getEvolution(BuildContext context) {
    List<Widget> _evolutionList = [];
    Pokemon pokemon = pokemonStore.currentPokemon;

    if (pokemon.prevEvolution != null) {
      pokemon.prevEvolution.forEach((pokeItem) {
        _evolutionList.add(
          ResizePokemonWidget(
            widget: pokemonStore.getImage(pokemonNumber: pokeItem.num),
          ),
        );
        _evolutionList.add(
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Text(
              pokeItem.name,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        );
        _evolutionList.add(Icon(
          Icons.keyboard_arrow_down,
          size: 32,
          color: Colors.black,
        ));
      });
    }

    _evolutionList.add(ResizePokemonWidget(
      widget: pokemonStore.getImage(pokemonNumber: pokemon.num),
    ));

    _evolutionList.add(
      Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: Text(
          pokemon.name,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );

    if (pokemon.nextEvolution != null) {
      _evolutionList.add(Icon(
        Icons.keyboard_arrow_down,
        size: 32,
        color: Colors.black,
      ));

      pokemon.nextEvolution.forEach((pokeItem) {
        _evolutionList.add(
          ResizePokemonWidget(
            widget: pokemonStore.getImage(pokemonNumber: pokeItem.num),
          ),
        );

        _evolutionList.add(
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Text(
              pokeItem.name,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        );

        if (pokemon.nextEvolution.last.name != pokeItem.name) {
          _evolutionList.add(Icon(
            Icons.keyboard_arrow_down,
            size: 32,
            color: Colors.black,
          ));
        }
      });
    }

    return (_evolutionList != null)
        ? _evolutionList
        : CircularProgressIndicator();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: getEvolution(context),
        ),
      );
    });
  }
}
