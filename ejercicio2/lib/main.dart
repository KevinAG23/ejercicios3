import 'package:flutter/material.dart';
import 'paginas/viaje.dart';
import 'paginas/costoviaje.dart';
import 'paginas/calculoviaje.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ViajeScreen(),
    );
  }
}

class ViajeScreen extends StatefulWidget {
  @override
  _ViajeScreenState createState() => _ViajeScreenState();
}

class _ViajeScreenState extends State<ViajeScreen> {
  final _distanciaController = TextEditingController();
  final _personasController = TextEditingController();
  String _tipoAutobus = 'A';
  String _resultado = '';

  void _calcular() {
    double distancia = double.parse(_distanciaController.text);
    int numeroPersonas = int.parse(_personasController.text);

    Viaje viaje = Viaje(tipoAutobus: _tipoAutobus, distanciaKm: distancia, numeroPersonas: numeroPersonas);
    CostoViaje costo = calcularCostoViaje(viaje);

    setState(() {
      _resultado = 'Costo por persona: \$${costo.costoPorPersona.toStringAsFixed(2)}\n'
          'Costo total: \$${costo.costoTotal.toStringAsFixed(2)}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de Costos de Viaje'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _distanciaController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Distancia del viaje (km)'),
              ),
              TextField(
                controller: _personasController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Número de personas'),
              ),
              DropdownButton<String>(
                value: _tipoAutobus,
                onChanged: (String? newValue) {
                  setState(() {
                    _tipoAutobus = newValue!;
                  });
                },
                items: <String>['A', 'B', 'C']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              ElevatedButton(
                onPressed: _calcular,
                child: Text('Calcular'),
              ),
              SizedBox(height: 20),
              Text(
                _resultado,
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
