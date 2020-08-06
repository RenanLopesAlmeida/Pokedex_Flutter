import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_pokedex/src/stores/app_store.dart';
import 'package:get_it/get_it.dart';

class AppBarHome extends StatefulWidget {
  @override
  _AppBarHomeState createState() => _AppBarHomeState();
}

class _AppBarHomeState extends State<AppBarHome> {
  AppStore _appStore;

  bool _darkTheme;

  @override
  void initState() {
    _darkTheme = false;
    _appStore = GetIt.instance<AppStore>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: Observer(builder: (context) {
        _darkTheme = _appStore.darkMode;

        return Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20, right: 6),
                  child: IconButton(
                    icon: Icon(
                      (_darkTheme)
                          ? Icons.lightbulb_outline
                          : Icons.airline_seat_flat,
                    ),
                    onPressed: () {
                      _appStore.getCurrentTheme();
                    },
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'Pokedex',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ],
            )
          ],
        );
      }),
    );
  }
}
