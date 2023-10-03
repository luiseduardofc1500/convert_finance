import 'package:flutter/material.dart';
import 'conv_moedas.dart';
import 'financas.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Finanças"),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Conv_moedas()),
                );
              },
              child: Text('Converter Moedas'),
            ),
            SizedBox(height: 16), // Espaço entre os botões
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Financas()),
                );
              },
              child: Text('Finanças'),
            ),
          ],
        ),
      ),
    );
  }
}
