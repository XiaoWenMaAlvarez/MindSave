import 'package:mindsave/test_breve_estado_animo/domain/entities/depresion_test_breve.dart';
import 'package:mindsave/test_breve_estado_animo/domain/entities/impulso_suicida_test_breve.dart';
import 'package:mindsave/test_breve_estado_animo/domain/entities/sentimientos_ansiedad_emocional_test_breve.dart';
import 'package:mindsave/test_breve_estado_animo/domain/entities/sentimientos_ansiedad_fisica_test_breve.dart';

class TestBreveEstadoDeAnimo {
  DateTime fechaCreacion;
  SentimientosAnsiedadEmocionalTestBreve sentimientosAnsiedadEmocionalTestBreve;
  SentimientosAnsiedadFisicaTestBreve sentimientosAnsiedadFisicaTestBreve;
  DepresionTestBreve depresionTestBreve;
  ImpulsoSuicidaTestBreve impulsoSuicidaTestBreve;

  TestBreveEstadoDeAnimo({
    required this.fechaCreacion,
    required this.sentimientosAnsiedadEmocionalTestBreve,
    required this.sentimientosAnsiedadFisicaTestBreve,
    required this.depresionTestBreve,
    required this.impulsoSuicidaTestBreve,
  });

  TestBreveEstadoDeAnimo.fromJson(Map<String, dynamic> json)
      : fechaCreacion = DateTime.parse(json['fechaCreacion']),
        sentimientosAnsiedadEmocionalTestBreve = SentimientosAnsiedadEmocionalTestBreve.fromJson(json['sentimientosAnsiedadEmocionalTestBreve']),
        sentimientosAnsiedadFisicaTestBreve = SentimientosAnsiedadFisicaTestBreve.fromJson(json['sentimientosAnsiedadFisicaTestBreve']),
        depresionTestBreve = DepresionTestBreve.fromJson(json['depresionTestBreve']),
        impulsoSuicidaTestBreve = ImpulsoSuicidaTestBreve.fromJson(json['impulsoSuicidaTestBreve']);
      
  Map<String, dynamic> toJson() {
    return {
      'fechaCreacion': fechaCreacion.toIso8601String(),
      'sentimientosAnsiedadEmocionalTestBreve': sentimientosAnsiedadEmocionalTestBreve.toJson(),
      'sentimientosAnsiedadFisicaTestBreve': sentimientosAnsiedadFisicaTestBreve.toJson(),
      'depresionTestBreve': depresionTestBreve.toJson(),
      'impulsoSuicidaTestBreve': impulsoSuicidaTestBreve.toJson(),
    };
  }

  @override
  String toString() {
    return 
"""
${sentimientosAnsiedadEmocionalTestBreve.toString()}

${sentimientosAnsiedadFisicaTestBreve.toString()}

${depresionTestBreve.toString()}

${impulsoSuicidaTestBreve.toString()}
""";
  }
}
