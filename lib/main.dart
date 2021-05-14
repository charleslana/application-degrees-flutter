import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MeuAplicativo());

class MeuAplicativo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PrimeiraRota(),
      routes: {
        RotaGenerica.caminhoDaRota: (context) => RotaGenerica(),
      },
    );
  }
}

class PrimeiraRota extends StatelessWidget {

  final temperaturaCelsiusController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Graus Celsius'),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(children: [
          Container(
            child: TextField(
              controller: temperaturaCelsiusController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () => temperaturaCelsiusController.clear(),
                    icon: Icon(Icons.clear),
                  ),
                  border: OutlineInputBorder(),
                  labelText: 'Temperate em graus celsius'),
            ),
            margin: EdgeInsets.all(10),
          ),
          Container(
            child: ElevatedButton(
              child: Padding(
                  padding: EdgeInsets.all(10.0), child: Text('Converter')),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  RotaGenerica.caminhoDaRota,
                  arguments: ArgumentosDaRota(
                    'Graus Fahrenheit',
                    double.parse(temperaturaCelsiusController.text)
                  ),
                );
              },
            ),
            margin: EdgeInsets.all(10),
          ),
        ]),
      ),
    );
  }
}

class RotaGenerica extends StatelessWidget {
  static const caminhoDaRota = '/conversao';

  @override
  Widget build(BuildContext context) {
    ArgumentosDaRota argumentos =
        ModalRoute.of(context).settings.arguments as ArgumentosDaRota;

    return Scaffold(
      appBar: AppBar(
        title: Text(argumentos.titulo),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              child: Text(
                'Graus Celsius: ${argumentos.celsius.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.green,
                ),
              ),
              margin: EdgeInsets.all(100),
            ),
            Container(
              child: Text(
                'Graus Fahrenheit: ${argumentos.converter(argumentos.celsius).toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.red,
                ),
              ),
              margin: EdgeInsets.all(50),
            )
          ],
        ),
      ),
    );
  }
}

class ArgumentosDaRota {
  String titulo;
  double celsius;

  ArgumentosDaRota(this.titulo, this.celsius);

  converter(double celsius) => celsius * 1.8 + 32;
}
