import 'package:flutter/material.dart';
import 'paginas/pedidopagina.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.red, // Color principal del tema
        fontFamily: 'Roboto', // Fuente del texto
      ),
      home: PedidoPagina(),
    );
  }
}
