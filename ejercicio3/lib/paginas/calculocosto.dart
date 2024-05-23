import 'pedido.dart';
import 'costopedido.dart';

double obtenerCostoHamburguesa(String tipoHamburguesa) {
  switch (tipoHamburguesa.toUpperCase()) {
    case 'SENCILLA':
      return 20.0;
    case 'DOBLE':
      return 25.0;
    case 'TRIPLE':
      return 28.0;
    default:
      throw Exception('Tipo de hamburguesa no válido');
  }
}

CostoPedido calcularCostoPedido(Pedido pedido) {
  double costoPorHamburguesa = obtenerCostoHamburguesa(pedido.tipoHamburguesa);
  double costoTotal = pedido.cantidad * costoPorHamburguesa;
  double costoConTarjeta = pedido.usaTarjeta ? costoTotal * 1.05 : costoTotal;

  return CostoPedido(costoTotal: costoTotal, costoConTarjeta: costoConTarjeta);
}
