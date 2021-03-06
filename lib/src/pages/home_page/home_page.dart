import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:simple_animations/simple_animations.dart';

import '../../stores/pokeapi_store.dart';
import 'package:flutter_pokedex/src/models/pokeapi.dart';
import 'package:flutter_pokedex/src/pages/home_page/widgets/poke_item.dart';
import 'package:get_it/get_it.dart';
import './widgets/app_bar_home.dart';
import '../../consts/consts_app.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PokeApiStore _pokeApiStore;
  MultiTrackTween _animation;

  @override
  void initState() {
    super.initState();
    _pokeApiStore = GetIt.instance<PokeApiStore>();

    if (_pokeApiStore.pokeApi == null) {
      _pokeApiStore.fetchPokemonList();
    }

    _animation = MultiTrackTween([
      Track("rotation").add(
          Duration(seconds: 100), Tween(begin: 20.0, end: 80.0),
          curve: Curves.linear),
    ]);
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
            top: MediaQuery.of(context).padding.top - 240 / 3.1,
            left: _screenWidth - (240 / 1.6),
            child: Opacity(
              opacity: 0.1,
              child: ControlledAnimation(
                playback: Playback.LOOP,
                duration: _animation.duration,
                tween: _animation,
                curve: Curves.linear,
                builder: (context, anim) {
                  return Transform.rotate(
                    angle: anim['rotation'],
                    child: Hero(
                      tag: 'pokeball_header',
                      child: Image.asset(
                        ConstsApp.darkPokeball,
                        height: 240,
                        width: 240,
                      ),
                    ),
                  );
                },
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
                                          color: ConstsApp.getColorType(
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
