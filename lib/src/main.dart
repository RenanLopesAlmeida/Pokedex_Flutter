import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_pokedex/src/pages/poke_detail/poke_detail_page.dart';
import 'package:flutter_pokedex/src/stores/app_store.dart';
import 'package:flutter_pokedex/src/stores/pokeapi_v2_store.dart';
import './stores/pokeapi_store.dart';
import 'package:get_it/get_it.dart';
import './pages/home_page/home_page.dart';

void main() {
  GetIt getIt = GetIt.instance;
  getIt.registerSingleton<PokeApiStore>(PokeApiStore());
  getIt.registerSingleton<PokeApiV2Store>(PokeApiV2Store());
  getIt.registerSingleton<AppStore>(AppStore());
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppStore _appStore = GetIt.instance<AppStore>();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      bool _darkTheme = _appStore.darkMode;

      return MaterialApp(
        routes: {
          'home_page': (context) => HomePage(),
          'poke_detail_page': (context) => PokeDetailPage(),
        },
        initialRoute: 'home_page',
        title: 'Pokedex',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: (_darkTheme) ? Brightness.dark : Brightness.light,
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'Google',
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                headline5: TextStyle(
                  fontFamily: 'Google',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                bodyText1: TextStyle(
                  fontFamily: 'Google',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                bodyText2: TextStyle(
                  fontFamily: 'Google',
                  fontSize: 14,
                  color: Colors.black87,
                ),
                subtitle2: TextStyle(
                  fontFamily: 'Google',
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                headline4: TextStyle(
                  fontFamily: 'Google',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
                headline3: TextStyle(
                  fontFamily: 'Google',
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
        ),
      );
    });
  }
}
