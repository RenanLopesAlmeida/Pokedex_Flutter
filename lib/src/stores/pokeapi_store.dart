import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pokedex/src/consts/consts_app.dart';
import 'package:http/http.dart' as http;
import 'package:mobx/mobx.dart';

import 'package:flutter_pokedex/src/consts/consts_api.dart';
import 'package:flutter_pokedex/src/models/pokeapi.dart';

part 'pokeapi_store.g.dart';

class PokeApiStore = _PokeApiStoreBase with _$PokeApiStore;

abstract class _PokeApiStoreBase with Store {
  @observable
  PokeApi _pokeAPI;

  @observable
  Pokemon _currentPokemon;

  @observable
  Color _currentPokemonColor;

  @observable
  int currentPosition;

  @computed
  PokeApi get pokeApi => _pokeAPI;

  @computed
  Pokemon get currentPokemon => _currentPokemon;

  @computed
  Color get currentPokemonColor => _currentPokemonColor;

  Pokemon getPokemon({int index}) {
    return _pokeAPI.pokemon[index];
  }

  @action
  setCurrentPokemon(int index) {
    _currentPokemon = _pokeAPI.pokemon[index];
    _currentPokemonColor = ConstsApp.getColorType(
      type: _currentPokemon.type[0],
    );
    currentPosition = index;
  }

  @action
  Widget getImage({String pokemonNumber}) {
    return CachedNetworkImage(
      placeholder: (context, url) => Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.grey,
          strokeWidth: 1.8,
          valueColor: AlwaysStoppedAnimation<Color>(
            Colors.deepPurpleAccent,
          ),
        ),
      ),
      alignment: Alignment.bottomRight,
      imageUrl:
          'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/$pokemonNumber.png',
    );
  }

  @action
  fetchPokemonList() {
    _pokeAPI = null;

    loadPokeAPI().then((pokeList) {
      _pokeAPI = pokeList;
    });
  }

  Future<PokeApi> loadPokeAPI() async {
    try {
      final response = await http.get(ConstsAPI.pokeApi);
      var decodeJson = jsonDecode(response.body);

      return PokeApi.fromJson(decodeJson);
    } catch (error, stacktrace) {
      print('Erro ao carregar lista ${stacktrace.toString()}');
      return null;
    }
  }
}
