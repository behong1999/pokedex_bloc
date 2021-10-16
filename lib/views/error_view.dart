import 'package:flutter/material.dart';
import 'package:pokedex_bloc/widgets/warning.dart';

class ErrorView extends StatefulWidget {
  @override
  _ErrorViewState createState() => _ErrorViewState();
}

class _ErrorViewState extends State<ErrorView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
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
          
          ElevatedButton(
              onPressed: Navigator.of(context).pop,
              child: Text(
                'BACK',
                style: TextStyle(fontWeight: FontWeight.bold),
              ))
        ],
      ),
    );
  }
}
