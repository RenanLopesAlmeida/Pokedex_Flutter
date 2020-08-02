import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_pokedex/src/consts/consts_api.dart';
import 'package:flutter_pokedex/src/models/pokeapi.dart';
import 'package:flutter_pokedex/stores/pokeapi_store.dart';
import 'package:provider/provider.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class PokeDetailPage extends StatelessWidget {
  Color _pokemonColor;

  @override
  Widget build(BuildContext context) {
    final _pokemonStore = Provider.of<PokeApiStore>(context);
    Pokemon _pokemon = _pokemonStore.currentPokemon;

    return Scaffold(
      backgroundColor: _pokemonColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: Observer(
          builder: (context) {
            _pokemonColor = ConstsAPI.getColorType(
              type: _pokemonStore.currentPokemon.type[0],
            );
            return AppBar(
              backgroundColor: _pokemonColor,
              elevation: 0,
              title: Opacity(
                opacity: 0,
                child: Text(
                  _pokemon.name,
                  style: TextStyle(
                      fontFamily: 'Google',
                      fontSize: 21,
                      fontWeight: FontWeight.bold),
                ),
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.favorite_border),
                  onPressed: () {},
                )
              ],
            );
          },
        ),
      ),
      body: Stack(
        children: <Widget>[
          Observer(
            builder: (ctx) {
              _pokemonColor = ConstsAPI.getColorType(
                  type: _pokemonStore.currentPokemon.type[0]);
              return Container(
                color: _pokemonColor,
              );
            },
          ),
          Container(
            height: MediaQuery.of(context).size.height / 3,
          ),
          SlidingSheet(
            elevation: 0,
            cornerRadius: 16,
            snapSpec: const SnapSpec(
              snap: true,
              snappings: [0.7, 1.0],
              positioning: SnapPositioning.relativeToAvailableSpace,
            ),
            builder: (context, state) {
              return Container(
                height: MediaQuery.of(context).size.height,
              );
            },
          ),
          Padding(
            padding: EdgeInsets.only(top: 50),
            child: SizedBox(
              height: 150,
              child: PageView.builder(
                itemCount: _pokemonStore.pokeApi.pokemon.length,
                onPageChanged: (index) {
                  _pokemonStore.setCurrentPokemon(index);
                },
                itemBuilder: (context, index) {
                  Pokemon _pokemonItem = _pokemonStore.getPokemon(index: index);
                  return CachedNetworkImage(
                    height: 90,
                    width: 90,
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
                        'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/${_pokemonItem.num}.png',
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
