import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_pokedex/src/consts/consts_app.dart';
import 'package:flutter_pokedex/src/models/pokeapi.dart';
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

  @override
  void initState() {
    super.initState();

    _pokemonStore = GetIt.instance<PokeApiStore>();
    _pokemon = _pokemonStore.currentPokemon;

    _animation = MultiTrackTween([
      Track("rotation").add(Duration(seconds: 5), Tween(begin: 0.0, end: 10.0),
          curve: Curves.linear),
    ]);
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
              return Container(
                color: _pokemonStore.currentPokemonColor,
              );
            },
          ),
          // Container(
          //   height: MediaQuery.of(context).size.height / 3,
          // ),
          SlidingSheet(
            elevation: 0,
            cornerRadius: 30,
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
            padding: EdgeInsets.only(top: 60),
            child: Container(
              height: 200,
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pokemonStore.pokeApi.pokemon.length,
                onPageChanged: (index) {
                  _pokemonStore.setCurrentPokemon(index);
                },
                itemBuilder: (context, index) {
                  Pokemon _pokemonItem = _pokemonStore.getPokemon(index: index);
                  return Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      ControlledAnimation(
                        playback: Playback.LOOP,
                        duration: _animation.duration,
                        tween: _animation,
                        curve: Curves.easeInOutSine,
                        builder: (context, animation) {
                          return Transform.rotate(
                            angle: animation['rotation'],
                            child: Hero(
                              tag: index.toString(),
                              child: Opacity(
                                opacity: 0.2,
                                child: Image.asset(
                                  ConstsApp.whitePokeball,
                                  height: 280,
                                  width: 280,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      Observer(builder: (context) {
                        return AnimatedPadding(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.bounceInOut,
                          padding: EdgeInsets.all(
                            (index == _pokemonStore.currentPosition) ? 0 : 60,
                          ),
                          child: CachedNetworkImage(
                            height: 160,
                            width: 160,
                            color: (index == _pokemonStore.currentPosition)
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
                                'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/${_pokemonItem.num}.png',
                          ),
                        );
                      }),
                    ],
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
