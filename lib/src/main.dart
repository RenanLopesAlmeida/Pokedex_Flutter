import 'package:flutter/material.dart';
import 'package:flutter_pokedex/src/pages/poke_detail/poke_detail_page.dart';
import 'package:flutter_pokedex/stores/pokeapi_store.dart';
import 'package:get_it/get_it.dart';
import './pages/home_page/home_page.dart';

void main() {
  GetIt getIt = GetIt.instance;
  getIt.registerSingleton<PokeApiStore>(PokeApiStore());
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'home_page': (context) => HomePage(),
        'poke_detail_page': (context) => PokeDetailPage(),
      },
      initialRoute: 'home_page',
      title: 'Pokedex',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
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
              subtitle2: TextStyle(
                fontFamily: 'Google',
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
      ),
    );
  }
}
