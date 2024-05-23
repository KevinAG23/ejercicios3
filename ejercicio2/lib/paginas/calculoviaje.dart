import 'viaje.dart';
import 'costoviaje.dart';

double obtenerCostoPorKm(String tipoAutobus) {
  switch (tipoAutobus.toUpperCase()) {
    case 'A':
      return 2.0;
    case 'B':
      return 2.5;
    case 'C':
      return 3.0;
    default:
      throw Exception('Tipo de autobús no válido');
  }
}

CostoViaje calcularCostoViaje(Viaje viaje) {
  int personas = viaje.numeroPersonas >= 20 ? viaje.numeroPersonas : 20;
  double costoPorKm = obtenerCostoPorKm(viaje.tipoAutobus);
  double costoTotal = personas * viaje.distanciaKm * costoPorKm;
  double costoPorPersona = costoTotal / viaje.numeroPersonas;

  return CostoViaje(costoPorPersona: costoPorPersona, costoTotal: costoTotal);
}
