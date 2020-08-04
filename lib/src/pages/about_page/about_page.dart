import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_pokedex/stores/pokeapi_store.dart';
import 'package:get_it/get_it.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  PokeApiStore _pokemonStore;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _pokemonStore = GetIt.instance<PokeApiStore>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: Observer(
            builder: (context) {
              return TabBar(
                controller: _tabController,

                labelStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
                indicatorSize: TabBarIndicatorSize.label,
                labelColor: _pokemonStore.currentPokemonColor,
                unselectedLabelColor: Color(0xff5f6368),
                isScrollable: true, //up to your taste
                indicator: MD2Indicator(
                    //it begins here
                    indicatorHeight: 3,
                    indicatorColor: _pokemonStore.currentPokemonColor,
                    indicatorSize: MD2IndicatorSize
                        .normal //3 different modes tiny-normal-full
                    ),
                tabs: <Widget>[
                  Tab(
                    text: "About",
                  ),
                  Tab(
                    text: "Evolution",
                  ),
                  Tab(
                    text: "Status",
                  ),
                ],
              );
            },
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
      ),
    );
  }
}
