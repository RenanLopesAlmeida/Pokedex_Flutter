import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_pokedex/stores/pokeapi_store.dart';
import 'package:get_it/get_it.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class PokeInfoSheet extends StatefulWidget {
  @override
  _PokeInfoSheetState createState() => _PokeInfoSheetState();
}

class _PokeInfoSheetState extends State<PokeInfoSheet> {
  Widget build(BuildContext context) {
    return Container();
  }
  // PokeApiStore _pokeStore;
  // double _multiple, _opacity;

  // @override
  // void initState() {
  //   super.initState();

  //   _pokeStore = GetIt.instance<PokeApiStore>();
  //   _multiple = 1;
  //   _opacity = 1;
  // }

  // // //pega o valor do slidingSheet
  // double interval(double lower, double upper, double progress) {
  //   assert(lower < upper);

  //   if (progress > upper) {
  //     return 1;
  //   }

  //   if (progress < lower) {
  //     return 0;
  //   }

  //   return ((progress - lower) / (upper - lower)).clamp(0, 1);
  // }

  // @override
  // Widget build(BuildContext context) {
  //   SlidingSheet(
  //     listener: (sheetState) {
  //       _progress = sheetState.progress;
  //       _multiple = 1 - interval(0, 0.7, _progress);
  //       _opacity = _multiple;
  //       //_opacity = _multiple = interval(0.55, 1 _progress);
  //     },
  //     elevation: 0,
  //     cornerRadius: 30,
  //     snapSpec: const SnapSpec(
  //       snap: true,
  //       snappings: [0.7, 1.0],
  //       positioning: SnapPositioning.relativeToAvailableSpace,
  //     ),
  //     builder: (context, state) {
  //       return Container(
  //         height: MediaQuery.of(context).size.height,
  //       );
  //     },
  //   );
  // }
}
