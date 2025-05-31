
class DateHelper {

  static int calcularUltimoDiaDelMes(DateTime fecha) {
    DateTime primerDiaMesSiguiente = (fecha.month < 12)
        ? DateTime(fecha.year, fecha.month + 1, 1)
        : DateTime(fecha.year + 1, 1, 1);

    DateTime ultimoDia = primerDiaMesSiguiente.subtract(Duration(days: 1));
    return ultimoDia.day;
  }

}