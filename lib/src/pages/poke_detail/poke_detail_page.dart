import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_pokedex/src/consts/consts_app.dart';
import 'package:flutter_pokedex/src/models/pokeapi.dart';
import 'package:flutter_pokedex/src/pages/poke_detail/widgets/poke_animated_widget.dart';
import 'package:flutter_pokedex/src/pages/poke_detail/widgets/poke_info_sheet.dart';
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
    _pageController = PageController(initialPage: _index);

    return Scaffold(
      backgroundColor: _pokemonStore.currentPokemonColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: Observer(
          builder: (context) {
            return AppBar(
              backgroundColor: _pokemonStore.currentPokemonColor,
              elevation: 0,
              title: Opacity(
                opacity: _opacityTitleAppBar,
                child: Text(
                  _pokemon.name,
                  style: TextStyle(
                      fontFamily: 'Google',
                      fontSize: 21,
                      fontWeight: FontWeight.bold),
                ),
              ),
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
                            opacity: _opacityTitleAppBar >= 0.2 ? 0.2 : 0,
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
            );
          },
        ),
      ),
      body: Stack(
        children: <Widget>[
          Observer(
            builder: (ctx) {
              return Container(
                color: _pokemonStore.currentPokemonColor,
              );
            },
          ),
          SlidingSheet(
            listener: (sheetState) {
              setState(() {
                _progress = sheetState.progress;
                _multiple = 1 - interval(0, 0.9, _progress);
                _opacity = _multiple;
                _opacityTitleAppBar =
                    _multiple = interval(0.55, 0.9, _progress);
              });
            },
            elevation: 0,
            cornerRadius: 30,
            snapSpec: const SnapSpec(
              snap: true,
              snappings: [0.7, 1],
              positioning: SnapPositioning.relativeToAvailableSpace,
            ),
            builder: (context, state) {
              return Container(
                height: MediaQuery.of(context).size.height,
              );
            },
          ),
          IgnorePointer(
            ignoring: _opacityTitleAppBar == 1,
            child: Opacity(
              opacity: _opacity,
              child: Padding(
                padding: EdgeInsets.only(
                  top: (60 - _progress * 50),
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
}
