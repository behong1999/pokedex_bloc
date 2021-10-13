import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_bloc/bloc/pokemon_details_cubit.dart';
import 'package:pokedex_bloc/const.dart';
import 'package:pokedex_bloc/data/pokemon_details.dart';

class PokemonDetailsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return BlocBuilder<PokemonDetailsCubit, PokemonDetails>(
      builder: (context, state) {
        Widget PokemonImage(String url) {
          return Image.network(
            url,
            height: deviceSize.height * 0.3,
            width: deviceSize.width * 0.5,
          );
        }

        Widget Spacer() {
          return const SizedBox(height: 10);
        }

        Widget Mearsurement(String str) {
          return Row(
            children: [
              Text(
                '$str:',
                style: const TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 10),
              Text(
                str == 'Height'
                    ? '${(state.height / 10).toStringAsFixed(1)} m'
                    : '${(state.weight / 10).toStringAsFixed(1)} kg',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          );
        }

        return state != null
            ? Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: Text(
                    state.name.toUpperCase(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                body: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/bg.gif"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    CustomScrollView(
                      slivers: [
                        SliverList(
                          delegate: SliverChildListDelegate(
                            [
                              Stack(children: [
                                Container(
                                  width: double.infinity,
                                  height: deviceSize.height * 0.3,
                                  child: Image.asset(
                                    'assets/images/arrow.gif',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    PokemonImage(state.imageUrl),
                                    PokemonImage(state.backImageUrl),
                                  ],
                                ),
                                Positioned(
                                  bottom: 5,
                                  left: deviceSize.width *
                                      (state.types.length > 1 ? 0.38 : 0.42),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/pokeball_icon.png',
                                            width: deviceSize.width * 0.06,
                                            height: deviceSize.height * 0.06,
                                          ),
                                          const SizedBox(width: 1),
                                          Text(
                                            state.id.toString().padLeft(3, '0'),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                          const SizedBox(width: 5),
                                        ],
                                      ),

                                      //* TYPES
                                      Row(
                                        children: state.types
                                            .map(
                                              (type) => Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 2.0),
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(4),
                                                  decoration: BoxDecoration(
                                                      color: typeColor[type],
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  6))),
                                                  child: Text(
                                                    type.toUpperCase(),
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      )
                                    ],
                                  ),
                                ),
                              ]),

                              // Divider(
                              //   color: Colors.redAccent,
                              //   indent: deviceSize.width * 0.05,
                              //   endIndent: deviceSize.width * 0.05,
                              // ),
                              Spacer(),
                              //* MEASUREMENT
                              Container(
                                padding: EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Measurements',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Mearsurement('Height'),
                                    Mearsurement('Weight')
                                  ],
                                ),
                              ),
                              Spacer(),

                              //* DESCRIPTION
                              Card(
                                color: Colors.white30,
                                shadowColor: Colors.grey,
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Description',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        state.description.split('\n').join(' '),
                                        textAlign: TextAlign.left,
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ))
            : Scaffold(
                backgroundColor: loadingColor,
                body: Center(
                  child: Image.asset('assets/images/loading_pokeball.gif'),
                ),
              );
      },
    );
  }
}
