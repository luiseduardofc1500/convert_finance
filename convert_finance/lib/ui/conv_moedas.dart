import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Conv_moedas extends StatefulWidget {
  @override
  _Conv_moedasState createState() => _Conv_moedasState();
}

class _Conv_moedasState extends State<Conv_moedas> {
  final dolarController = TextEditingController();
  final euroController = TextEditingController();
  final realController = TextEditingController();

  double dolar = 0;
  double euro = 0;

  @override
  void initState() {
    super.initState();
    getData().then((data) {
      dolar = data["results"]["currencies"]["USD"]["buy"];
      euro = data["results"]["currencies"]["EUR"]["buy"];
    });
  }

  Future<Map> getData() async {
    final response = await http.get(Uri.parse(
        "https://api.hgbrasil.com/finance?format=json-cors&key=2a34b926"));
    return json.decode(response.body);
  }

  void _realChange(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double real = double.parse(text);
    dolarController.text = (real / dolar).toStringAsFixed(2);
    euroController.text = (real / euro).toStringAsFixed(2);
  }

  void _dolarChange(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double dolar = double.parse(text);
    realController.text = (dolar * this.dolar).toStringAsFixed(2);
    euroController.text = (dolar * this.dolar / euro).toStringAsFixed(2);
  }

  void _euroChange(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double euro = double.parse(text);
    realController.text = (euro * this.euro).toStringAsFixed(2);
    dolarController.text = (euro * this.euro / dolar).toStringAsFixed(2);
  }

  void _clearAll() {
    realController.text = "";
    dolarController.text = "";
    euroController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Conversor de Moedas"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Icon(
              Icons.monetization_on,
              size: 150.0,
              color: Colors.blue,
            ),
            buildTextFormField("Reais", "R\$", realController, _realChange),
            Divider(),
            buildTextFormField("Dólar", "US\$", dolarController, _dolarChange),
            Divider(),
            buildTextFormField("Euro", "EUR", euroController, _euroChange),
          ],
        ),
      ),
    );
  }

  Widget buildTextFormField(String label, String prefix,
      TextEditingController controller, Function f) {
    return TextField(
      onChanged: (value) => f(value),
      controller: controller,
      decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.blue),
          border: OutlineInputBorder(),
          prefixText: "$prefix "),
      style: TextStyle(color: Colors.blue, fontSize: 25.0),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
    );
  }
}
