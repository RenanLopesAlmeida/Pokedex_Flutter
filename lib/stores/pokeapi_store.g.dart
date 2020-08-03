// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokeapi_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PokeApiStore on _PokeApiStoreBase, Store {
  Computed<PokeApi> _$pokeApiComputed;

  @override
  PokeApi get pokeApi =>
      (_$pokeApiComputed ??= Computed<PokeApi>(() => super.pokeApi,
              name: '_PokeApiStoreBase.pokeApi'))
          .value;
  Computed<Pokemon> _$currentPokemonComputed;

  @override
  Pokemon get currentPokemon => (_$currentPokemonComputed ??= Computed<Pokemon>(
          () => super.currentPokemon,
          name: '_PokeApiStoreBase.currentPokemon'))
      .value;
  Computed<Color> _$currentPokemonColorComputed;

  @override
  Color get currentPokemonColor => (_$currentPokemonColorComputed ??=
          Computed<Color>(() => super.currentPokemonColor,
              name: '_PokeApiStoreBase.currentPokemonColor'))
      .value;

  final _$_pokeAPIAtom = Atom(name: '_PokeApiStoreBase._pokeAPI');

  @override
  PokeApi get _pokeAPI {
    _$_pokeAPIAtom.reportRead();
    return super._pokeAPI;
  }

  @override
  set _pokeAPI(PokeApi value) {
    _$_pokeAPIAtom.reportWrite(value, super._pokeAPI, () {
      super._pokeAPI = value;
    });
  }

  final _$_currentPokemonAtom = Atom(name: '_PokeApiStoreBase._currentPokemon');

  @override
  Pokemon get _currentPokemon {
    _$_currentPokemonAtom.reportRead();
    return super._currentPokemon;
  }

  @override
  set _currentPokemon(Pokemon value) {
    _$_currentPokemonAtom.reportWrite(value, super._currentPokemon, () {
      super._currentPokemon = value;
    });
  }

  final _$_currentPokemonColorAtom =
      Atom(name: '_PokeApiStoreBase._currentPokemonColor');

  @override
  Color get _currentPokemonColor {
    _$_currentPokemonColorAtom.reportRead();
    return super._currentPokemonColor;
  }

  @override
  set _currentPokemonColor(Color value) {
    _$_currentPokemonColorAtom.reportWrite(value, super._currentPokemonColor,
        () {
      super._currentPokemonColor = value;
    });
  }

  final _$currentPositionAtom = Atom(name: '_PokeApiStoreBase.currentPosition');

  @override
  int get currentPosition {
    _$currentPositionAtom.reportRead();
    return super.currentPosition;
  }

  @override
  set currentPosition(int value) {
    _$currentPositionAtom.reportWrite(value, super.currentPosition, () {
      super.currentPosition = value;
    });
  }

  final _$_PokeApiStoreBaseActionController =
      ActionController(name: '_PokeApiStoreBase');

  @override
  dynamic setCurrentPokemon(int index) {
    final _$actionInfo = _$_PokeApiStoreBaseActionController.startAction(
        name: '_PokeApiStoreBase.setCurrentPokemon');
    try {
      return super.setCurrentPokemon(index);
    } finally {
      _$_PokeApiStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  Widget getImage({String pokemonNumber}) {
    final _$actionInfo = _$_PokeApiStoreBaseActionController.startAction(
        name: '_PokeApiStoreBase.getImage');
    try {
      return super.getImage(pokemonNumber: pokemonNumber);
    } finally {
      _$_PokeApiStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic fetchPokemonList() {
    final _$actionInfo = _$_PokeApiStoreBaseActionController.startAction(
        name: '_PokeApiStoreBase.fetchPokemonList');
    try {
      return super.fetchPokemonList();
    } finally {
      _$_PokeApiStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentPosition: ${currentPosition},
pokeApi: ${pokeApi},
currentPokemon: ${currentPokemon},
currentPokemonColor: ${currentPokemonColor}
    ''';
  }
}
