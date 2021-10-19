import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_bloc/bloc/pokemon_bloc.dart';
import 'package:pokedex_bloc/widgets/warning.dart';

class ErrorView extends StatefulWidget {
  int currentIndex;
  ErrorView(this.currentIndex);

  @override
  _ErrorViewState createState() => _ErrorViewState();
}

class _ErrorViewState extends State<ErrorView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WarningIcon(),
              Text(
                " WARNING ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              WarningIcon()
            ],
          ),
          Image.asset(
            'assets/images/NoResult.png',
            fit: BoxFit.cover,
          ),
          Text(
            "No Internet Connection",
            style: TextStyle(fontStyle: FontStyle.italic, fontSize: 18),
          ),
          SizedBox(height: 30),
          ElevatedButton(
              onPressed: () => BlocProvider.of<PokemonBloc>(context)
                  .add(PokemonPageRequest(widget.currentIndex)),
              child: Text(
                'Try Again',
                style: TextStyle(fontWeight: FontWeight.bold),
              ))
        ],
      ),
    );
  }
}
