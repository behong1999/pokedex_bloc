import 'package:flutter/material.dart';

Color loadingColor = const Color(0xFF181b1d);

final typeColor = {
  'steel': const Color(0xFFC3C3D9),
  'normal': const Color(0xFFbdbeb0),
  'fire': const Color(0xFFE7614D),
  'water': const Color(0xFF6DACF8),
  'electric': const Color(0xFFF7D02C),
  'grass': const Color(0xFF9CD363),
  'fighting': const Color(0xFFC22E28),
  'ice': const Color(0xFFAFF4FD),
  'poison': const Color(0xFF995E98),
  'psychic': const Color(0xFFE96EB0),
  'bug': const Color(0xFFC5D24A),
  'rock': const Color(0xFFCBBD7C),
  'ghost': const Color(0xFF7774CF),
  'dragon': const Color(0xFF8475F7),
  'dark': const Color(0xFF886958),
  'fairy': const Color(0xFFEEB0FA),
  'ground': const Color(0xFFE3C969),
  'flying': const Color(0xFF81A2F8),
};

 bool isNumericUsingRegularExpression(String string) {
    final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');

    return numericRegex.hasMatch(string);
  }