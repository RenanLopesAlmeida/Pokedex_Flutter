import 'dart:convert';
import 'package:flutter_pokedex/src/consts/consts_api.dart';

import 'package:http/http.dart' as http;
import 'package:flutter_pokedex/src/models/pokeapi_v2.dart';
import 'package:flutter_pokedex/src/models/specie.dart';
import 'package:mobx/mobx.dart';
part 'pokeapi_v2_store.g.dart';

class PokeApiV2Store = _PokeApiV2StoreBase with _$PokeApiV2Store;

abstract class _PokeApiV2StoreBase with Store {
  @observable
  Specie specie;

  @observable
  PokeApiV2 pokeApiV2;

  @action
  Future<void> getInfoPokemon(String pokemonName) async {
    try {
      final response =
          await http.get(ConstsAPI.pokeApiV2 + pokemonName.toLowerCase());
      var decodeJson = jsonDecode(response.body);

      pokeApiV2 = PokeApiV2.fromJson(decodeJson);
    } catch (error, stacktrace) {
      print('Failed to load pokemon info ${stacktrace.toString()}');
      return null;
    }
  }

  @action
  Future<void> getInfoSpecie(int pokemonNumber) async {
    try {
      specie = null;

      final response = await http
          .get(ConstsAPI.pokeApiV2SpeciesUrl + pokemonNumber.toString());
      var decodeJson = jsonDecode(response.body);

      specie = Specie.fromJson(decodeJson);
    } catch (error, stacktrace) {
      print('Failed to load pokemon info Specie ${stacktrace.toString()}');
      return null;
    }
  }
}
