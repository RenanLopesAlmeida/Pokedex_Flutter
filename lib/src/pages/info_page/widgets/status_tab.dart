import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_pokedex/src/models/pokeapi_v2.dart';
import 'package:flutter_pokedex/src/shared/widgets/status_bar_widget.dart';
import 'package:flutter_pokedex/src/stores/pokeapi_store.dart';
import 'package:flutter_pokedex/src/stores/pokeapi_v2_store.dart';

class StatusTab extends StatelessWidget {
  final PokeApiStore pokemonStore;
  final PokeApiV2Store pokeApiV2Store;

  List<int> _getStatusPokemon(PokeApiV2 pokeApiV2) {
    List<int> _statusList = [0, 1, 2, 3, 4, 5, 6];
    int _sum = 0;

    pokeApiV2.stats.forEach((pokemonStatus) {
      _sum += pokemonStatus.baseStat;

      switch (pokemonStatus.stat.name.toLowerCase()) {
        case 'speed':
          _statusList[0] = pokemonStatus.baseStat;
          break;

        case 'special-defense':
          _statusList[1] = pokemonStatus.baseStat;
          break;

        case 'special-attack':
          _statusList[2] = pokemonStatus.baseStat;
          break;

        case 'defense':
          _statusList[3] = pokemonStatus.baseStat;
          break;

        case 'attack':
          _statusList[4] = pokemonStatus.baseStat;
          break;

        case 'hp':
          _statusList[5] = pokemonStatus.baseStat;
          break;
      }
    });
    _statusList[6] = _sum;
    return _statusList;
  }

  StatusTab({@required this.pokemonStore, @required this.pokeApiV2Store});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Speed',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              Text('Sp.Def',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  )),
              Text(
                'Sp.Att',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              Text(
                'Defense',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              Text(
                'Attack',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              Text(
                'HP',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              Text(
                'Total',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Observer(builder: (_) {
              List<int> _statusList =
                  _getStatusPokemon(pokeApiV2Store.pokeApiV2);

              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _statusList[0].toString(),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _statusList[1].toString(),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _statusList[2].toString(),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _statusList[3].toString(),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _statusList[4].toString(),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _statusList[5].toString(),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _statusList[6].toString(),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              );
            }),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 10),
              child: Observer(builder: (_) {
                List<int> _statusList =
                    _getStatusPokemon(pokeApiV2Store.pokeApiV2);

                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    StatusBarWidget(
                      widthFactor: _statusList[0] / 160,
                    ),
                    StatusBarWidget(
                      widthFactor: _statusList[1] / 160,
                    ),
                    StatusBarWidget(
                      widthFactor: _statusList[2] / 160,
                    ),
                    StatusBarWidget(
                      widthFactor: _statusList[3] / 160,
                    ),
                    StatusBarWidget(
                      widthFactor: _statusList[4] / 160,
                    ),
                    StatusBarWidget(
                      widthFactor: _statusList[5] / 160,
                    ),
                    StatusBarWidget(
                      widthFactor:
                          (_statusList[6] / 600) > 1 ? 1 : _statusList[6] / 600,
                    ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
