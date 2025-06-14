class Emociones {
  List<String> listaEmociones;
  List<bool> seleccionEmociones;
  int? porcentajeCreenciaAntes;
  int? porcentajeCreenciaDespues;

  Emociones({
    required this.listaEmociones,
    this.seleccionEmociones = const [],
    this.porcentajeCreenciaAntes,
    this.porcentajeCreenciaDespues
  }){
    if(seleccionEmociones.isEmpty) {
      seleccionEmociones = [for(int i = 0; i < listaEmociones.length; i++) false];
    }
  }

  factory Emociones.fromJson(Map<String, dynamic> json) {
    return Emociones(
      listaEmociones: List<String>.from(json['listaEmociones']),
      seleccionEmociones: List<bool>.from(json['seleccionEmociones']),
      porcentajeCreenciaAntes: json['porcentajeCreenciaAntes'],
      porcentajeCreenciaDespues: json['porcentajeCreenciaDespues'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'listaEmociones': listaEmociones,
      'seleccionEmociones': seleccionEmociones,
      'porcentajeCreenciaAntes': porcentajeCreenciaAntes,
      'porcentajeCreenciaDespues': porcentajeCreenciaDespues,
    };
  }

  @override
  String toString() {
    return """
Emociones.
Lista de emociones: $listaEmociones
Selección de emociones: $seleccionEmociones
Porcentaje de creencia (antes): $porcentajeCreenciaAntes
Porcentaje de creencia (después): $porcentajeCreenciaDespues

""";
  }

} 


List<String> grupoEmociones1 = ["Triste", "Melancólico", "Deprimido", "Decaído", "Infeliz"];
List<String> grupoEmociones2 = ["Angustiado", "Preocupado", "Con pánico", "Nervioso", "Asustado"];
List<String> grupoEmociones3 = ["Culpable", "Con remordimiento", "Malo", "Avergonzado"];
List<String> grupoEmociones4 = ["Inferior", "Sin valor", "Inadecuado", "Deficiente", "Incompetente"];
List<String> grupoEmociones5 = ["Solitario", "No querido", "No deseado", "Rechazado", "Solo", "Abandonado"];

List<String> grupoEmociones6 = ["Turbado", "Tonto", "Humillado", "Apurado"];
List<String> grupoEmociones7 = ["Desesperanzado", "Desanimado", "Pesimista", "Descorazonado"];
List<String> grupoEmociones8 = ["Frustrado", "Atascado", "Chasqueado", "Derrotado"];
List<String> grupoEmociones9 = ["Airado", "Enfadado", "Resentido", "Molesto", "Irritado", "Trastornado", "Furioso"];


class GrupoEmociones {
  Emociones grupo1;
  Emociones grupo2;
  Emociones grupo3;
  Emociones grupo4;
  Emociones grupo5;
  Emociones grupo6;
  Emociones grupo7;
  Emociones grupo8;
  Emociones grupo9;
  Emociones grupo10;

  GrupoEmociones():
    grupo1 = Emociones(listaEmociones: grupoEmociones1),
    grupo2 = Emociones(listaEmociones: grupoEmociones2),
    grupo3 = Emociones(listaEmociones: grupoEmociones3),
    grupo4 = Emociones(listaEmociones: grupoEmociones4),
    grupo5 = Emociones(listaEmociones: grupoEmociones5),
    grupo6 = Emociones(listaEmociones: grupoEmociones6),
    grupo7 = Emociones(listaEmociones: grupoEmociones7),
    grupo8 = Emociones(listaEmociones: grupoEmociones8),
    grupo9 = Emociones(listaEmociones: grupoEmociones9),
    grupo10 = Emociones(listaEmociones: []);

  String? get isIncomplete  { 
      if(grupo1.porcentajeCreenciaAntes == null || grupo1.porcentajeCreenciaAntes! < 0 || grupo1.porcentajeCreenciaAntes! > 100) return "Error en el porcentaje de intensidad del grupo de emociones 1";
      if(grupo2.porcentajeCreenciaAntes == null || grupo2.porcentajeCreenciaAntes! < 0 || grupo2.porcentajeCreenciaAntes! > 100) return "Error en el porcentaje de intensidad del grupo de emociones 2";
      if(grupo3.porcentajeCreenciaAntes == null || grupo3.porcentajeCreenciaAntes! < 0 || grupo3.porcentajeCreenciaAntes! > 100) return "Error en el porcentaje de intensidad del grupo de emociones 3";
      if(grupo4.porcentajeCreenciaAntes == null || grupo4.porcentajeCreenciaAntes! < 0 || grupo4.porcentajeCreenciaAntes! > 100) return "Error en el porcentaje de intensidad del grupo de emociones 4";
      if(grupo5.porcentajeCreenciaAntes == null || grupo5.porcentajeCreenciaAntes! < 0 || grupo5.porcentajeCreenciaAntes! > 100) return "Error en el porcentaje de intensidad del grupo de emociones 5";
      if(grupo6.porcentajeCreenciaAntes == null || grupo6.porcentajeCreenciaAntes! < 0 || grupo6.porcentajeCreenciaAntes! > 100) return "Error en el porcentaje de intensidad del grupo de emociones 6";
      if(grupo7.porcentajeCreenciaAntes == null || grupo7.porcentajeCreenciaAntes! < 0 || grupo7.porcentajeCreenciaAntes! > 100) return "Error en el porcentaje de intensidad del grupo de emociones 7";
      if(grupo8.porcentajeCreenciaAntes == null || grupo8.porcentajeCreenciaAntes! < 0 || grupo8.porcentajeCreenciaAntes! > 100) return "Error en el porcentaje de intensidad del grupo de emociones 8";
      if(grupo9.porcentajeCreenciaAntes == null || grupo9.porcentajeCreenciaAntes! < 0 || grupo9.porcentajeCreenciaAntes! > 100) return "Error en el porcentaje de intensidad del grupo de emociones 9";
      if(grupo10.listaEmociones.isNotEmpty && (grupo10.porcentajeCreenciaAntes == null || grupo10.porcentajeCreenciaAntes! < 0 || grupo10.porcentajeCreenciaAntes! > 100)) return "Error en el porcentaje de creencia del grupo de emociones 10";
      
      if(grupo1.porcentajeCreenciaAntes == 0 && grupo1.seleccionEmociones.any((bool seleccion) => seleccion == true)) return "Grupo de emociones 1: Se seleccionó al menos una emoción pero se indicó un 0 en el % de intensidad";
      if(grupo2.porcentajeCreenciaAntes == 0 && grupo2.seleccionEmociones.any((bool seleccion) => seleccion == true)) return "Grupo de emociones 2: Se seleccionó al menos una emoción pero se indicó un 0 en el % de intensidad";
      if(grupo3.porcentajeCreenciaAntes == 0 && grupo3.seleccionEmociones.any((bool seleccion) => seleccion == true)) return "Grupo de emociones 3: Se seleccionó al menos una emoción pero se indicó un 0 en el % de intensidad";
      if(grupo4.porcentajeCreenciaAntes == 0 && grupo4.seleccionEmociones.any((bool seleccion) => seleccion == true)) return "Grupo de emociones 4: Se seleccionó al menos una emoción pero se indicó un 0 en el % de intensidad";
      if(grupo5.porcentajeCreenciaAntes == 0 && grupo5.seleccionEmociones.any((bool seleccion) => seleccion == true)) return "Grupo de emociones 5: Se seleccionó al menos una emoción pero se indicó un 0 en el % de intensidad";
      if(grupo6.porcentajeCreenciaAntes == 0 && grupo6.seleccionEmociones.any((bool seleccion) => seleccion == true)) return "Grupo de emociones 6: Se seleccionó al menos una emoción pero se indicó un 0 en el % de intensidad";
      if(grupo7.porcentajeCreenciaAntes == 0 && grupo7.seleccionEmociones.any((bool seleccion) => seleccion == true)) return "Grupo de emociones 7: Se seleccionó al menos una emoción pero se indicó un 0 en el % de intensidad";
      if(grupo8.porcentajeCreenciaAntes == 0 && grupo8.seleccionEmociones.any((bool seleccion) => seleccion == true)) return "Grupo de emociones 8: Se seleccionó al menos una emoción pero se indicó un 0 en el % de intensidad";
      if(grupo9.porcentajeCreenciaAntes == 0 && grupo9.seleccionEmociones.any((bool seleccion) => seleccion == true)) return "Grupo de emociones 9: Se seleccionó al menos una emoción pero se indicó un 0 en el % de intensidad";
      if(grupo10.listaEmociones.isNotEmpty && grupo10.porcentajeCreenciaAntes == 0) return "Grupo de emociones 10: Se seleccionó al menos una emoción pero se indicó un 0 en el % de intensidad";

      if(grupo1.seleccionEmociones.every((bool seleccion) => seleccion == false) && grupo1.porcentajeCreenciaAntes! > 0) return "Grupo de emociones 1: No se seleccionó ninguna emoción pero se indicó un % mayor a 0 en la intensidad";
      if(grupo2.seleccionEmociones.every((bool seleccion) => seleccion == false) && grupo2.porcentajeCreenciaAntes! > 0) return "Grupo de emociones 2: No se seleccionó ninguna emoción pero se indicó un % mayor a 0 en la intensidad";
      if(grupo3.seleccionEmociones.every((bool seleccion) => seleccion == false) && grupo3.porcentajeCreenciaAntes! > 0) return "Grupo de emociones 3: No se seleccionó ninguna emoción pero se indicó un % mayor a 0 en la intensidad";
      if(grupo4.seleccionEmociones.every((bool seleccion) => seleccion == false) && grupo4.porcentajeCreenciaAntes! > 0) return "Grupo de emociones 4: No se seleccionó ninguna emoción pero se indicó un % mayor a 0 en la intensidad";
      if(grupo5.seleccionEmociones.every((bool seleccion) => seleccion == false) && grupo5.porcentajeCreenciaAntes! > 0) return "Grupo de emociones 5: No se seleccionó ninguna emoción pero se indicó un % mayor a 0 en la intensidad";
      if(grupo6.seleccionEmociones.every((bool seleccion) => seleccion == false) && grupo6.porcentajeCreenciaAntes! > 0) return "Grupo de emociones 6: No se seleccionó ninguna emoción pero se indicó un % mayor a 0 en la intensidad";
      if(grupo7.seleccionEmociones.every((bool seleccion) => seleccion == false) && grupo7.porcentajeCreenciaAntes! > 0) return "Grupo de emociones 7: No se seleccionó ninguna emoción pero se indicó un % mayor a 0 en la intensidad";
      if(grupo8.seleccionEmociones.every((bool seleccion) => seleccion == false) && grupo8.porcentajeCreenciaAntes! > 0) return "Grupo de emociones 8: No se seleccionó ninguna emoción pero se indicó un % mayor a 0 en la intensidad";
      if(grupo9.seleccionEmociones.every((bool seleccion) => seleccion == false) && grupo9.porcentajeCreenciaAntes! > 0) return "Grupo de emociones 9: No se seleccionó ninguna emoción pero se indicó un % mayor a 0 en la intensidad";
      return null;
  }

  bool get isPending  { 
    return 
      grupo1.porcentajeCreenciaDespues == null || 
      grupo2.porcentajeCreenciaDespues == null || 
      grupo3.porcentajeCreenciaDespues == null || 
      grupo4.porcentajeCreenciaDespues == null || 
      grupo5.porcentajeCreenciaDespues == null || 
      grupo6.porcentajeCreenciaDespues == null ||
      grupo7.porcentajeCreenciaDespues == null || 
      grupo8.porcentajeCreenciaDespues == null ||
      grupo9.porcentajeCreenciaDespues == null ||
      (grupo10.listaEmociones.isNotEmpty && grupo10.porcentajeCreenciaDespues == null);
  }

  GrupoEmociones.fromJson(Map<String, dynamic> json) :
    grupo1 = Emociones.fromJson(json["grupo1"]),
    grupo2 = Emociones.fromJson(json["grupo2"]),
    grupo3 = Emociones.fromJson(json["grupo3"]),
    grupo4 = Emociones.fromJson(json["grupo4"]),
    grupo5 = Emociones.fromJson(json["grupo5"]),
    grupo6 = Emociones.fromJson(json["grupo6"]),
    grupo7 = Emociones.fromJson(json["grupo7"]),
    grupo8 = Emociones.fromJson(json["grupo8"]),
    grupo9 = Emociones.fromJson(json["grupo9"]),
    grupo10 = Emociones.fromJson(json["grupo10"]);

  Map<String, dynamic> toJson() {
    return {
      'grupo1': grupo1.toJson(),
      'grupo2': grupo2.toJson(),
      'grupo3': grupo3.toJson(),
      'grupo4': grupo4.toJson(),
      'grupo5': grupo5.toJson(),
      'grupo6': grupo6.toJson(),
      'grupo7': grupo7.toJson(),
      'grupo8': grupo8.toJson(),
      'grupo9': grupo9.toJson(),
      "grupo10": grupo10.toJson()
    };
  }

  @override
  String toString() {
    return """
Grupo de emociones 1: ${grupo1.toString()}
Grupo de emociones 2: ${grupo2.toString()}
Grupo de emociones 3: ${grupo3.toString()}
Grupo de emociones 4: ${grupo4.toString()}
Grupo de emociones 5: ${grupo5.toString()}
Grupo de emociones 6: ${grupo6.toString()}
Grupo de emociones 7: ${grupo7.toString()}
Grupo de emociones 8: ${grupo8.toString()}
Grupo de emociones 9: ${grupo9.toString()}
Grupo de emociones 10: ${grupo10.toString()}
""";
  }


}