import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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

  @computed
  PokeApi get pokeApi => _pokeAPI;

  @computed
  Pokemon get currentPokemon => _currentPokemon;

  @action
  getPokemon({int index}) {
    return _pokeAPI.pokemon[index];
  }

  @action
  setCurrentPokemon(int index) {
    _currentPokemon = _pokeAPI.pokemon[index];
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
      final response = await http.get(ConstsAPI.baseURL);
      var decodeJson = jsonDecode(response.body);

      return PokeApi.fromJson(decodeJson);
    } catch (error, stacktrace) {
      print('Erro ao carregar lista ${stacktrace.toString()}');
      return null;
    }
  }
}
