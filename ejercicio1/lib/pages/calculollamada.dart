import 'llamada.dart';
import 'costollamada.dart';

double calcularPagoPorTiempo(int tiempo) {
  double pago = 0.0;
  if (tiempo <= 5) {
    pago = tiempo * 1.0;
  } else if (tiempo <= 8) {
    pago = 5 * 1.0 + (tiempo - 5) * 0.8;
  } else if (tiempo <= 10) {
    pago = 5 * 1.0 + 3 * 0.8 + (tiempo - 8) * 0.7;
  } else {
    pago = 5 * 1.0 + 3 * 0.8 + 2 * 0.7 + (tiempo - 10) * 0.5;
  }
  return pago;
}

double calcularImpuesto(String tipoDia, String turno) {
  if (tipoDia == 'domingo') {
    return 0.03;
  } else if (tipoDia == 'habil' && turno == 'matutino') {
    return 0.15;
  } else if (tipoDia == 'habil' && turno == 'vespertino') {
    return 0.10;
  } else {
    throw Exception('Tipo de día o turno no válidos');
  }
}

CostoLlamada calcularCostoLlamada(Llamada llamada) {
  double pagoPorTiempo = calcularPagoPorTiempo(llamada.tiempo);
  double porcentajeImpuesto = calcularImpuesto(llamada.tipoDia, llamada.turno);
  double impuesto = pagoPorTiempo * porcentajeImpuesto;
  double total = pagoPorTiempo + impuesto;

  return CostoLlamada(pagoPorTiempo: pagoPorTiempo, impuesto: impuesto, total: total);
}
