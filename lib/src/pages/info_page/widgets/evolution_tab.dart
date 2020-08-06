import 'package:flutter/material.dart';
import 'package:flutter_pokedex/src/shared/widgets/pokemon_evolution_widget.dart';
import 'package:flutter_pokedex/src/stores/pokeapi_store.dart';

class EvolutionTab extends StatelessWidget {
  final PokeApiStore pokemonStore;

  EvolutionTab({
    @required this.pokemonStore,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: PokemonEvolutionWidget(
        pokemonStore: pokemonStore,
      ),
    );
  }
}
