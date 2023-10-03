import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Financas extends StatefulWidget {
  @override
  _FinancasState createState() => _FinancasState();
}

class _FinancasState extends State<Financas> {
  Map<String, dynamic> stocksData = {};
  Set<String> favoriteStocks = {};
  bool showFavorites = false;

  Future<void> fetchStocksData() async {
    final response = await http.get(
      Uri.parse(
          "https://api.hgbrasil.com/finance?format=json-cors&key=2a34b926"),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final stocks = data["results"]["stocks"];
      setState(() {
        stocksData = Map<String, dynamic>.from(stocks);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchStocksData();
  }

  void toggleFavoritesView() {
    setState(() {
      showFavorites = !showFavorites;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> stocksToDisplay =
        showFavorites ? favoriteStocks.toList() : stocksData.keys.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Página de Finanças"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: stocksToDisplay.length,
              itemBuilder: (context, index) {
                final stockName = stocksToDisplay[index];
                final stock = stocksData[stockName];
                final stockPoints = stock["points"];
                final stockVariation = stock["variation"];
                final isFavorite = favoriteStocks.contains(stockName);

                return ListTile(
                  title: Text(stockName),
                  subtitle:
                      Text("Pontos: $stockPoints\nVariação: $stockVariation%"),
                  trailing: IconButton(
                    icon: Icon(
                      isFavorite ? Icons.star : Icons.star_border,
                      color: isFavorite ? Colors.yellow : null,
                    ),
                    onPressed: () {
                      setState(() {
                        if (isFavorite) {
                          favoriteStocks.remove(stockName);
                        } else {
                          favoriteStocks.add(stockName);
                        }
                      });
                    },
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: toggleFavoritesView,
            child: Text(showFavorites ? "Mostrar todas as ações" : "Favoritos"),
          ),
        ],
      ),
    );
  }
}
