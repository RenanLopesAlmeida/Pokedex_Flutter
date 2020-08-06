import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_pokedex/src/models/specie.dart';
import 'package:flutter_pokedex/src/pages/info_page/widgets/pokemon_biology_info.dart';
import 'package:flutter_pokedex/src/shared/widgets/circular_progress_about.dart';
import 'package:flutter_pokedex/src/stores/pokeapi_store.dart';
import 'package:flutter_pokedex/src/stores/pokeapi_v2_store.dart';

class AboutTab extends StatelessWidget {
  final PokeApiStore pokemonStore;
  final PokeApiV2Store pokeApiV2Store;

  AboutTab({
    @required this.pokeApiV2Store,
    @required this.pokemonStore,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Description',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(
              height: 10,
            ),
            Observer(builder: (_) {
              Specie _specie = pokeApiV2Store.specie;

              return Container(
                height: 70,
                child: _specie != null
                    ? Text(
                        _specie.flavorTextEntries
                            .where((item) => item.language.name == 'en')
                            .first
                            .flavorText
                            .replaceAll("\n", " ")
                            .replaceAll("\f", " ")
                            .replaceAll("POKéMON", "Pokémon"),
                        style: Theme.of(context).textTheme.bodyText2,
                      )
                    : CircularProgressAbout(
                        color: pokemonStore.currentPokemonColor,
                      ),
              );
            }),
            SizedBox(
              height: 10,
            ),
            Text(
              'Biology',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(
              height: 10,
            ),
            Observer(builder: (_) {
              return Column(
                children: <Widget>[
                  PokemonBiologyInfo(
                    biologyTitle: 'Height',
                    biologyValue: pokemonStore.currentPokemon.height,
                    titleStyle: Theme.of(context).textTheme.headline4,
                    valueStyle: Theme.of(context).textTheme.headline3,
                  ),
                  PokemonBiologyInfo(
                    biologyTitle: 'Weight',
                    biologyValue: pokemonStore.currentPokemon.weight,
                    titleStyle: Theme.of(context).textTheme.headline4,
                    valueStyle: Theme.of(context).textTheme.headline3,
                  ),
                  PokemonBiologyInfo(
                    biologyTitle: 'Type',
                    biologyValue: pokemonStore.currentPokemon.type.toString(),
                    titleStyle: Theme.of(context).textTheme.headline4,
                    valueStyle: Theme.of(context).textTheme.headline3,
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
