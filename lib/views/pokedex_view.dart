import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:pokedex_bloc/bloc/nav_cubit.dart';
import 'package:pokedex_bloc/const.dart';
import 'package:pokedex_bloc/views/error_view.dart';
import 'package:pokedex_bloc/widgets/scroll_to_hide.dart';
import 'package:pokedex_bloc/widgets/search.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../bloc/pokemon_bloc.dart';

class PokedexView extends StatefulWidget {
  @override
  _PokedexViewState createState() => _PokedexViewState();
}

class _PokedexViewState extends State<PokedexView> {
  var count = 0;
  bool internetStatus = false;
  ConnectivityResult result = ConnectivityResult.none;
  ScrollController controller = ScrollController();

  _scrollLimit() {
    if (controller.offset >= controller.position.maxScrollExtent &&
        controller.position.outOfRange) {
      showSimpleNotification(
          const Text("Reach The Bottom",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 20)),
          background: Colors.red,
          duration: const Duration(seconds: 2));
    }
    if (controller.offset <= controller.position.minScrollExtent) {
      showSimpleNotification(
          const Text("Reach The Top",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 20)),
          background: Colors.red,
          duration: const Duration(seconds: 2));
    }
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(_scrollLimit);
    InternetConnectionChecker().onStatusChange.listen((event) {
      final internetStatus = event == InternetConnectionStatus.connected;
      setState(() {
        this.internetStatus = internetStatus;
      });
      final text = internetStatus == true
          ? "Internet Connected"
          : "Internet Disconnected";
      final color = internetStatus == true ? Colors.green : Colors.purple;
      showSimpleNotification(
          Text(text,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 20)),
          background: color,
          duration: const Duration(seconds: 10));
    });

    // controller = ScrollController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Pokédex'),
      ),
      floatingActionButton: SearchBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: BlocBuilder<PokemonBloc, PokemonState>(
        builder: (context, state) {
          if (state is PokemonInitial) {
            BlocProvider.of<PokemonBloc>(context)
                .add((PokemonPageRequest(count)));
          }
          if (state is PokemonPageLoadFailed) {
            return Center(
              child: ErrorView(count),
            );
          }

          if (state is PokemonPageLoadSuccess) {
            return GridView.builder(
                controller: controller,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemCount: state.pokemonListings.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      BlocProvider.of<NavCubit>(context).showPokemonDetails(
                        state.pokemonListings[index].id,
                      );
                    },
                    child: Card(
                      color: loadingColor,
                      shadowColor: Colors.pink,
                      elevation: 6,
                      child: GridTile(
                        child: Stack(children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: FadeInImage.assetNetwork(
                                  imageScale: 0.5,
                                  placeholder:
                                      'assets/images/loading_pokeball.gif',
                                  image: state.pokemonListings[index].imageUrl),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15)),
                            child: Container(
                              width: double.infinity,
                              color: Colors.redAccent,
                              child: Text(
                                state.pokemonListings[index].name.toUpperCase(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 5,
                            left: 5,
                            child: ClipRRect(
                              child: Container(
                                  padding: const EdgeInsets.all(2),
                                  color: Colors.redAccent,
                                  child: Text(
                                    state.pokemonListings[index].id.toString(),
                                    style: const TextStyle(color: Colors.white),
                                  )),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  );
                });
          }

          //* State is PokemonPageLoading
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      bottomNavigationBar: ScrollToHideWidget(
        controller: controller,
        child: Container(
          height: kBottomNavigationBarHeight,
          color: Colors.red.shade100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  icon: const Icon(Icons.keyboard_arrow_left_sharp),
                  onPressed: count == 0
                      ? null
                      : () {
                          setState(() {
                            count--;
                          });

                          BlocProvider.of<PokemonBloc>(context).add(
                            PokemonPageRequest(count),
                          );
                        }),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/pokeball_icon.png',
                    width: deviceSize.width * 0.1,
                    height: deviceSize.height * 0.05,
                  ),
                  Text(
                    'p.${count + 1}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              IconButton(
                icon: const Icon(Icons.keyboard_arrow_right_sharp),
                onPressed: count == 9
                    ? null
                    : () {
                        setState(() {
                          count++;
                        });

                        BlocProvider.of<PokemonBloc>(context).add(
                          PokemonPageRequest(count),
                        );
                      },
              )
            ],
          ),
        ),
      ),
    );
  }
}
