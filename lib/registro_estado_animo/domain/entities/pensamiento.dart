class Pensamiento {
  String pensamientoNegativo;
  int porcentajeCreenciaPensamientoNegativoAntes;
  int? porcentajeCreenciaPensamientoNegativoDespues;
  List<bool> distorsionesIdentificadas;
  String? pensamientoPositivo;
  int? porcentajeCreenciaPensamientoPositivo;

  static List<String> listaDistorsiones = [
    "Pensamiento todo o nada",
    "Generalización excesiva",
    "Filtro mental",
    "Descargar lo positivo",
    "Saltar a conclusiones (lectura del pensamiento o adivinación del porvenir)",
    "Magnificación o minimización",
    "Razonamiento emocional",
    'Afirmaciones del tipo "debería"',
    "Poner etiquetas",
    "Inculpación (autoinculpación o inculpación de los demás)"
  ];

  static List<String> detalleListaDistorsiones = [
    "usted considera las cosas en categorías absolutas, o blanco o negro.",
    "toma un hecho negativo aislado por una pauta interminable de derrotas: «Esto pasa siempre».",
    "usted da vueltas a lo negativo y pasa por alto lo positivo.",
    "se empeña en que sus cualidades positivas no cuentan.",
    "usted salta a conclusiones que no se justifican con los hechos, da por supuesto que la gente reacciona negativamente ante usted o predice que las cosas saldrán mal.",
    "usted hincha las cosas desproporcionadamente o bien empequeñece su importancia.",
    "razona en función de cómo se siente, diciéndose, por ejemplo: «Me siento idiota, así que debo serlo de verdad».",
    "utiliza verbos del tipo «Debería», «No debería », «Tendría que» y «No tendría que».",
    "en vez de decirse: «He cometido un error», dice: «Soy un idiota » o «Soy un perdedor».",
    "en vez de detectar la causa de un problema, usted asigna culpabilidades. Se culpa a sí mismo de algo que no fue responsabilidad suya o culpa a los demás, negando el papel de usted mismo en el problema.",
  ];

  bool get isPending  { 
    return pensamientoPositivo == null || 
      porcentajeCreenciaPensamientoNegativoDespues == null || 
      porcentajeCreenciaPensamientoPositivo == null;
  }

  Pensamiento({
    required this.pensamientoNegativo,
    required this.porcentajeCreenciaPensamientoNegativoAntes
  }):
    distorsionesIdentificadas = [for(int i = 0; i < listaDistorsiones.length; i++) false];

  Pensamiento.fromMapper({
    required this.pensamientoNegativo,
    required this.distorsionesIdentificadas,
    required this.porcentajeCreenciaPensamientoNegativoAntes,
    required this.porcentajeCreenciaPensamientoNegativoDespues,
    required this.pensamientoPositivo,
    required this.porcentajeCreenciaPensamientoPositivo
  });

  Pensamiento.fromJson(Map<String, dynamic> json) :
    pensamientoNegativo = json["pensamientoNegativo"],
    porcentajeCreenciaPensamientoNegativoAntes = json["porcentajeCreenciaPensamientoNegativoAntes"],
    porcentajeCreenciaPensamientoNegativoDespues = json["porcentajeCreenciaPensamientoNegativoDespues"],
    distorsionesIdentificadas = List<bool>.from(json["distorsionesIdentificadas"].map((x) => x)),
    pensamientoPositivo = json["pensamientoPositivo"],
    porcentajeCreenciaPensamientoPositivo = json["porcentajeCreenciaPensamientoPositivo"];

  Map<String, dynamic> toJson() {
    return {
      'pensamientoNegativo': pensamientoNegativo,
      'porcentajeCreenciaPensamientoNegativoAntes': porcentajeCreenciaPensamientoNegativoAntes,
      'porcentajeCreenciaPensamientoNegativoDespues': porcentajeCreenciaPensamientoNegativoDespues,
      'distorsionesIdentificadas': distorsionesIdentificadas,
      'pensamientoPositivo': pensamientoPositivo,
      'porcentajeCreenciaPensamientoPositivo': porcentajeCreenciaPensamientoPositivo,
    };
  }

  @override
  String toString() {
    return """
Pensamiento.
Pensamiento negativo: $pensamientoNegativo
Porcentaje de creencia del pensamiento negativo (antes): $porcentajeCreenciaPensamientoNegativoAntes
Porcentaje de creencia del pensamiento negativo (después): $porcentajeCreenciaPensamientoNegativoDespues
Distorsiones identificadas: $distorsionesIdentificadas
Pensamiento positivo: $pensamientoPositivo
Porcentaje de creencia del pensamiento positivo: $porcentajeCreenciaPensamientoPositivo
""";
  }

}