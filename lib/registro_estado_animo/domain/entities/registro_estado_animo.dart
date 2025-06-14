import 'package:mindsave/registro_estado_animo/domain/entities/entities.dart';

class RegistroEstadoAnimo {
  int id;
  DateTime fecha;
  String sucesoTrastornador;
  GrupoEmociones grupoEmociones;
  List<Pensamiento> listaPensamientos;

  bool get isPending  {
    bool isPendingPensamientos = listaPensamientos.any((Pensamiento pensamiento) => pensamiento.isPending);
    bool isPendingEmociones = grupoEmociones.isPending;
    return (isPendingPensamientos || isPendingEmociones || isValid != null);
  }

  String? get isValid {
    if(sucesoTrastornador.trim() == "") return "El suceso no debe estar vacío";
    if(grupoEmociones.isIncomplete != null) return grupoEmociones.isIncomplete;
    if(listaPensamientos.isEmpty) return "Debe agregar por lo menos un pensamiento";
    if(listaPensamientos.any((Pensamiento pensamiento) => pensamiento.porcentajeCreenciaPensamientoNegativoAntes == 0)) {
      Pensamiento pensamiento = listaPensamientos.firstWhere((Pensamiento pensamiento) => pensamiento.porcentajeCreenciaPensamientoNegativoAntes == 0);
      if(pensamiento.pensamientoNegativo.length > 10) {
        return 'La creencia del pensamiento "${pensamiento.pensamientoNegativo.substring(0,10)}..." debe estar entre 1 y 100';
      }else {
        return 'La creencia del pensamiento "${pensamiento.pensamientoNegativo}" debe estar entre 1 y 100';
      }
    }
    return null; 
  }

  RegistroEstadoAnimo({
    required this.id,
    required this.fecha,
    required this.sucesoTrastornador,
    required this.grupoEmociones,
    required this.listaPensamientos
  });

  RegistroEstadoAnimo.fromJson(Map<String, dynamic> json) :
    id = json["id"],
    fecha = DateTime.parse(json['fecha']),
    sucesoTrastornador = json["sucesoTrastornador"],
    grupoEmociones = GrupoEmociones.fromJson(json["grupoEmociones"]),
    listaPensamientos = List<Pensamiento>.from(json["listaPensamientos"].map((pensamientoJson) => 
      Pensamiento.fromJson(pensamientoJson)
    ));

    Map<String, dynamic> toJson() {
    return {
      "id": id,
      'fecha': fecha.toIso8601String(),
      'sucesoTrastornador': sucesoTrastornador,
      'grupoEmociones': grupoEmociones.toJson(),
      'listaPensamientos': List<Map<String, dynamic>>.from(listaPensamientos.map((Pensamiento pensamiento) =>  pensamiento.toJson())),
    };
  }

  @override
  String toString() {
    return """
Registro de Estado de Ánimo:
ID: $id
Fecha: $fecha
Suceso trastornador: $sucesoTrastornador
Grupo de emociones: ${grupoEmociones.toString()}
Lista de pensamientos: ${listaPensamientos.map((Pensamiento pensamiento) => pensamiento.toString()) }
""";
  }

}
