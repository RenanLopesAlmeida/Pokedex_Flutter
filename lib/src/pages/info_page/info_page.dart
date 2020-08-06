import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_pokedex/src/pages/info_page/widgets/about_tab.dart';
import 'package:flutter_pokedex/src/stores/pokeapi_v2_store.dart';
import '../../stores/pokeapi_store.dart';
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
  PokeApiV2Store _pokeApiV2Store;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _pokemonStore = GetIt.instance<PokeApiStore>();
    _pokeApiV2Store = GetIt.instance<PokeApiV2Store>();
    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: Observer(
            builder: (context) {
              return TabBar(
                controller: _tabController,
                onTap: (index) {
                  _pageController.animateToPage(
                    index,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
                indicatorSize: TabBarIndicatorSize.label,
                labelColor: _pokemonStore.currentPokemonColor,
                unselectedLabelColor: Color(0xff5f6368),
                isScrollable: true, //up to your taste
                indicator: MD2Indicator(
                  indicatorHeight: 3,
                  indicatorColor: _pokemonStore.currentPokemonColor,
                  indicatorSize: MD2IndicatorSize.normal,
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
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          _tabController.animateTo(
            index,
            duration: Duration(milliseconds: 300),
          );
        },
        children: <Widget>[
          AboutTab(
            pokemonStore: _pokemonStore,
            pokeApiV2Store: _pokeApiV2Store,
          ),
          Container(
            color: Colors.deepPurpleAccent,
          ),
          Container(
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}
