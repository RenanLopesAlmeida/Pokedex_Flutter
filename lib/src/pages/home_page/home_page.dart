import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:flutter_pokedex/stores/pokeapi_store.dart';
import 'package:flutter_pokedex/src/models/pokeapi.dart';
import 'package:flutter_pokedex/src/pages/home_page/widgets/poke_item.dart';
import './widgets/app_bar_home.dart';
import '../../consts/consts_app.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PokeApiStore _pokeApiStore = PokeApiStore();

  @override
  void initState() {
    super.initState();

    _pokeApiStore = PokeApiStore();
    _pokeApiStore.fetchPokemonList();
  }

  @override
  Widget build(BuildContext context) {
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
                      PokeApi _pokeApi = this._pokeApiStore.pokeApi;
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
                                  Pokemon _pokemon = this
                                      ._pokeApiStore
                                      .getPokemon(index: index);
                                  return AnimationConfiguration.staggeredGrid(
                                    position: index,
                                    duration: const Duration(milliseconds: 375),
                                    columnCount: 2,
                                    child: ScaleAnimation(
                                      child: GestureDetector(
                                        child: PokeItem(
                                          index: index,
                                          name: _pokemon.name,
                                          color: Colors.redAccent,
                                          image: _pokeApiStore.getImage(
                                              pokemonNumber: _pokemon.num),
                                        ),
                                        onTap: () {
                                          // _pokemonStore.setPokemonAtual(
                                          //     index: index);
                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(
                                          //     builder:
                                          //         (BuildContext context) =>
                                          //             PokeDetailPage(
                                          //       index: index,
                                          //     ),
                                          //     fullscreenDialog: true,
                                          //   ),
                                          // );
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