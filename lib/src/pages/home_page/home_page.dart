import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_pokedex/src/consts/consts_api.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:flutter_pokedex/stores/pokeapi_store.dart';
import 'package:flutter_pokedex/src/models/pokeapi.dart';
import 'package:flutter_pokedex/src/pages/home_page/widgets/poke_item.dart';
import 'package:provider/provider.dart';
import './widgets/app_bar_home.dart';
import '../../consts/consts_app.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _pokeApiStore = Provider.of<PokeApiStore>(context);
    if (_pokeApiStore.pokeApi == null) {
      _pokeApiStore.fetchPokemonList();
    }

    double _screenWidth = MediaQuery.of(context).size.width;
    double _statusbarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: Stack(
        overflow: Overflow.visible,
        alignment: Alignment.topCenter,
        children: <Widget>[
          Positioned(
            top: (-240 / 4.7),
            left: _screenWidth - (240 / 1.6),
            child: Opacity(
              opacity: 0.06,
              child: Image.asset(
                ConstsApp.darkPokeball,
                height: 240,
                width: 240,
              ),
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: _statusbarHeight,
                ),
                AppBarHome(),
                Expanded(
                  child: Container(
                    child: Observer(builder: (_) {
                      PokeApi _pokeApi = _pokeApiStore.pokeApi;
                      return (_pokeApi != null)
                          ? AnimationLimiter(
                              child: GridView.builder(
                                physics: BouncingScrollPhysics(),
                                padding: EdgeInsets.all(12),
                                addAutomaticKeepAlives: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                ),
                                itemCount: _pokeApi.pokemon.length,
                                itemBuilder: (context, index) {
                                  Pokemon _pokemon =
                                      _pokeApiStore.getPokemon(index: index);
                                  return AnimationConfiguration.staggeredGrid(
                                    position: index,
                                    duration: const Duration(milliseconds: 375),
                                    columnCount: 2,
                                    child: ScaleAnimation(
                                      child: GestureDetector(
                                        child: PokeItem(
                                          index: index,
                                          types: _pokemon.type,
                                          name: _pokemon.name,
                                          color: ConstsAPI.getColorType(
                                              type: _pokemon.type[0]),
                                          num: _pokemon.num,
                                        ),
                                        onTap: () {
                                          _pokeApiStore
                                              .setCurrentPokemon(index);
                                          Navigator.pushNamed(
                                            context,
                                            'poke_detail_page',
                                            arguments: index,
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.grey,
                                strokeWidth: 1.8,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.redAccent,
                                ),
                              ),
                            );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
