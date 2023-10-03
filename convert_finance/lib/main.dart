import 'package:flutter/material.dart';
import 'ui/home.dart'; // Importe a tela principal

void main() async {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
    theme: ThemeData(hintColor: Colors.blue, primaryColor: Colors.blue),
  ));
}
