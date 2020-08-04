import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_pokedex/src/consts/consts_app.dart';
import 'package:flutter_pokedex/src/models/pokeapi.dart';
import 'package:flutter_pokedex/src/pages/about_page/about_page.dart';
import 'package:flutter_pokedex/src/pages/poke_detail/widgets/poke_animated_widget.dart';
import 'package:flutter_pokedex/src/pages/poke_detail/widgets/pokeball_animated_rotation.dart';
import 'package:flutter_pokedex/stores/pokeapi_store.dart';
import 'package:get_it/get_it.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:simple_animations/simple_animations/multi_track_tween.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class PokeDetailPage extends StatefulWidget {
  @override
  _PokeDetailPageState createState() => _PokeDetailPageState();
}

class _PokeDetailPageState extends State<PokeDetailPage> {
  PageController _pageController;
  PokeApiStore _pokemonStore;

  Pokemon _pokemon;

  MultiTrackTween _animation;

  double _progress, _multiple, _opacity, _opacityTitleAppBar;

  @override
  void initState() {
    super.initState();

    _pokemonStore = GetIt.instance<PokeApiStore>();
    _pokemon = _pokemonStore.currentPokemon;

    _animation = MultiTrackTween([
      Track("rotation").add(Duration(seconds: 5), Tween(begin: 0.0, end: 10.0),
          curve: Curves.linear),
    ]);

    _progress = 0;
    _multiple = 1;
    _opacity = 1;
    _opacityTitleAppBar = 0;
  }

  double interval(double lower, double upper, double progress) {
    assert(lower < upper);

    if (progress > upper) {
      return 1;
    }

    if (progress < lower) {
      return 0;
    }

    return ((progress - lower) / (upper - lower)).clamp(0, 1);
  }

  @override
  Widget build(BuildContext context) {
    final _index = ModalRoute.of(context).settings.arguments;
    _pageController =
        PageController(initialPage: _index, viewportFraction: 0.5);

    return Scaffold(
      backgroundColor: _pokemonStore.currentPokemonColor,
      body: Stack(
        children: <Widget>[
          Observer(
            builder: (ctx) {
              _pokemon = _pokemonStore.currentPokemon;

              return AnimatedContainer(
                duration: Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      _pokemonStore.currentPokemonColor.withOpacity(0.6),
                      _pokemonStore.currentPokemonColor,
                    ],
                  ),
                ),
                child: Stack(
                  children: <Widget>[
                    AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      actions: <Widget>[
                        Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            ControlledAnimation(
                              playback: Playback.LOOP,
                              duration: _animation.duration,
                              tween: _animation,
                              //curve: Curves.easeInOutSine,
                              builder: (context, anim) {
                                return Transform.rotate(
                                  angle: anim['rotation'],
                                  child: Opacity(
                                    opacity:
                                        (_opacityTitleAppBar >= 0.2) ? 0.2 : 0,
                                    child: Image.asset(
                                      ConstsApp.whitePokeball,
                                      height: 60,
                                      width: 60,
                                    ),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.favorite_border),
                              onPressed: () {},
                            )
                          ],
                        ),
                      ],
                    ),
                    Stack(
                      alignment: Alignment.centerLeft,
                      children: <Widget>[
                        Positioned(
                          top: (MediaQuery.of(context).size.height / 8.50) -
                              _progress *
                                  (MediaQuery.of(context).size.height * 0.060),
                          left: 20 +
                              _progress *
                                  (MediaQuery.of(context).size.height * 0.060),
                          child: Text(
                            _pokemon.name,
                            style: TextStyle(
                              fontFamily: 'Google',
                              fontSize: 30 -
                                  _progress *
                                      (MediaQuery.of(context).size.height *
                                          0.011),
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: (MediaQuery.of(context).size.height * 0.15),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                            top: 20,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              _setTypes(_pokemonStore.currentPokemon.type),
                              Text(
                                '#${_pokemon.num}',
                                style: TextStyle(
                                  fontFamily: 'Google',
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
          SlidingSheet(
            listener: (sheetState) {
              setState(
                () {
                  _progress = sheetState.progress;
                  _multiple = 1 - interval(0, 0.87, _progress);
                  _opacity = _multiple;
                  _opacityTitleAppBar =
                      _multiple = interval(0.6, 0.87, _progress);
                },
              );
            },
            elevation: 0,
            cornerRadius: 30,
            snapSpec: const SnapSpec(
              snap: true,
              snappings: [0.6, 0.87],
              positioning: SnapPositioning.relativeToAvailableSpace,
            ),
            builder: (context, state) {
              final _screenHeight = MediaQuery.of(context).size.height * 0.15;
              return Container(
                height: MediaQuery.of(context).size.height - _screenHeight,
                child: AboutPage(),
              );
            },
          ),
          IgnorePointer(
            ignoring: _opacityTitleAppBar == 1,
            child: Opacity(
              opacity: _opacity,
              child: Padding(
                padding: EdgeInsets.only(
                  top: ((MediaQuery.of(context).size.height * 0.2) -
                      _progress * 50),
                ),
                child: Container(
                  height: 200,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _pokemonStore.pokeApi.pokemon.length,
                    onPageChanged: (index) {
                      _pokemonStore.setCurrentPokemon(index);
                    },
                    itemBuilder: (context, index) {
                      Pokemon _pokemonItem =
                          _pokemonStore.getPokemon(index: index);
                      return Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          PokeballAnimatedRotation(
                            animation: _animation,
                            pokemonItem: _pokemonItem,
                            pokeApiStore: _pokemonStore,
                            index: index,
                          ),
                          PokeAnimatedWidget(
                            index: index,
                            pokemonItem: _pokemonItem,
                            pokemonStore: _pokemonStore,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _setTypes(List<String> types) {
    List<Widget> _list = [];
    types.forEach((pokemonTypeName) {
      _list.add(Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromARGB(80, 255, 255, 255)),
            child: Padding(
              padding: EdgeInsets.all(6),
              child: Text(
                pokemonTypeName.trim(),
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
          ),
          SizedBox(
            width: 8,
          ),
        ],
      ));
    });

    return Row(
      children: _list,
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }
}
