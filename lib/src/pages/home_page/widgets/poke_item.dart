import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pokedex/src/consts/consts_app.dart';

class PokeItem extends StatelessWidget {
  final String name;
  final int index;
  final Color color;
  final String num;
  final List<String> types;

  const PokeItem({this.name, this.index, this.color, this.num, this.types});

  Widget _setTypes(BuildContext context) {
    List<Widget> _list = [];
    types.forEach((pokemonTypeName) {
      _list.add(Column(
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
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ));
    });

    return Column(
      children: _list,
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(
            Radius.circular(25),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Stack(
            //alignment: Alignment.bottomRight,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 8),
                child: Text(
                  this.name,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 5,
                  top: 38,
                ),
                child: _setTypes(context),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Opacity(
                  opacity: 0.4,
                  child: Image.asset(ConstsApp.whitePokeball,
                      height: 100, width: 100),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: CachedNetworkImage(
                  alignment: Alignment.bottomRight,
                  height: 90,
                  width: 90,
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
                      'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/$num.png',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
