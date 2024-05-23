import 'package:flutter/material.dart';
import 'pages/llamada.dart';
import 'pages/costollamada.dart';
import 'pages/calculollamada.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LlamadaScreen(),
    );
  }
}

class LlamadaScreen extends StatefulWidget {
  @override
  _LlamadaScreenState createState() => _LlamadaScreenState();
}

class _LlamadaScreenState extends State<LlamadaScreen> {
  final _tiempoController = TextEditingController();
  String _tipoDia = 'domingo';
  String _turno = 'matutino';
  String _resultado = '';
  String _error = '';

  void _calcular() {
    try {
      setState(() {
        _error = '';
      });

      int tiempo = int.parse(_tiempoController.text);
      if (tiempo < 0) {
        setState(() {
          _error = 'El tiempo debe ser un número positivo';
        });
        return;
      }

      Llamada llamada = Llamada(tiempo: tiempo, tipoDia: _tipoDia, turno: _turno);
      CostoLlamada costo = calcularCostoLlamada(llamada);

      setState(() {
        _resultado = 'Pago por tiempo: \$${costo.pagoPorTiempo.toStringAsFixed(2)}\n'
            'Impuesto: \$${costo.impuesto.toStringAsFixed(2)}\n'
            'Total: \$${costo.total.toStringAsFixed(2)}';
      });
    } catch (e) {
      setState(() {
        _error = 'Entrada no válida. Por favor, ingrese un número entero para el tiempo.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de Costo de Llamada'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _tiempoController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Duración de la llamada (min)',
                errorText: _error.isEmpty ? null : _error,
              ),
            ),
            DropdownButton<String>(
              value: _tipoDia,
              onChanged: (String? newValue) {
                setState(() {
                  _tipoDia = newValue!;
                });
              },
              items: <String>['domingo', 'habil']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            DropdownButton<String>(
              value: _turno,
              onChanged: (String? newValue) {
                setState(() {
                  _turno = newValue!;
                });
              },
              items: <String>['matutino', 'vespertino']
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
    );
  }
}
