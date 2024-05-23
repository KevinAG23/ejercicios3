import 'pedido.dart';
import 'costopedido.dart';
import 'calculocosto.dart';
import 'package:flutter/material.dart';

class PedidoPagina extends StatefulWidget {
  @override
  _PedidoPaginaState createState() => _PedidoPaginaState();
}

class _PedidoPaginaState extends State<PedidoPagina> {
  final _cantidadController = TextEditingController();
  String _tipoHamburguesa = 'SENCILLA';
  bool _usaTarjeta = false;
  String _resultado = '';

  void _calcular() {
    int cantidad = int.tryParse(_cantidadController.text) ?? 0;
    Pedido pedido = Pedido(
      tipoHamburguesa: _tipoHamburguesa,
      cantidad: cantidad,
      usaTarjeta: _usaTarjeta,
    );
    CostoPedido costo = calcularCostoPedido(pedido);

    setState(() {
      if (_usaTarjeta) {
        _resultado = 'Costo total: \$${costo.costoTotal.toStringAsFixed(2)}\n'
            'Costo con tarjeta: \$${costo.costoConTarjeta.toStringAsFixed(2)}';
      } else {
        _resultado = 'Costo total: \$${costo.costoTotal.toStringAsFixed(2)}';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('El náufrago satisfecho'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _cantidadController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Cantidad de hamburguesas',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: _tipoHamburguesa,
              onChanged: (String? newValue) {
                setState(() {
                  _tipoHamburguesa = newValue!;
                });
              },
              alignment: Alignment.center, // Alineación central del menú desplegable
              items: <String>['SENCILLA', 'DOBLE', 'TRIPLE']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text('Usa tarjeta de crédito'),
                Checkbox(
                  value: _usaTarjeta,
                  onChanged: (bool? newValue) {
                    setState(() {
                      _usaTarjeta = newValue!;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
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
