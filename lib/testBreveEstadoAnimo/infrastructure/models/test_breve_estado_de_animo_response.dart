import 'package:mindsave/testBreveEstadoAnimo/infrastructure/models/depresion_test_breve_response.dart';
import 'package:mindsave/testBreveEstadoAnimo/infrastructure/models/impulso_suicida_test_breve_response.dart';
import 'package:mindsave/testBreveEstadoAnimo/infrastructure/models/sentimientos_ansiedad_emocional_test_breve_response.dart';
import 'package:mindsave/testBreveEstadoAnimo/infrastructure/models/sentimientos_ansiedad_fisica_test_breve_response.dart';

class TestBreveEstadoDeAnimoResponse {
  final DateTime fechaCreacion;
  final SentimientosAnsiedadEmocionalTestBreveResponse sentimientosAnsiedadEmocionalTestBreve;
  final SentimientosAnsiedadFisicaTestBreveResponse sentimientosAnsiedadFisicaTestBreve;
  final DepresionTestBreveResponse depresionTestBreve;
  final ImpulsoSuicidaTestBreveResponse impulsoSuicidaTestBreve;

  TestBreveEstadoDeAnimoResponse({
    required this.fechaCreacion,
    required this.sentimientosAnsiedadEmocionalTestBreve,
    required this.sentimientosAnsiedadFisicaTestBreve,
    required this.depresionTestBreve,
    required this.impulsoSuicidaTestBreve,
  });

  TestBreveEstadoDeAnimoResponse.fromJson(Map<String, dynamic> json)
      : fechaCreacion = DateTime.parse(json['fechaCreacion']),
        sentimientosAnsiedadEmocionalTestBreve = SentimientosAnsiedadEmocionalTestBreveResponse.fromJson(json['sentimientosAnsiedadEmocionalTestBreve']),
        sentimientosAnsiedadFisicaTestBreve = SentimientosAnsiedadFisicaTestBreveResponse.fromJson(json['sentimientosAnsiedadFisicaTestBreve']),
        depresionTestBreve = DepresionTestBreveResponse.fromJson(json['depresionTestBreve']),
        impulsoSuicidaTestBreve = ImpulsoSuicidaTestBreveResponse.fromJson(json['impulsoSuicidaTestBreve']);
      
  Map<String, dynamic> toJson() {
    return {
      'fechaCreacion': fechaCreacion.toIso8601String(),
      'sentimientosAnsiedadEmocionalTestBreve': sentimientosAnsiedadEmocionalTestBreve.toJson(),
      'sentimientosAnsiedadFisicaTestBreve': sentimientosAnsiedadFisicaTestBreve.toJson(),
      'depresionTestBreve': depresionTestBreve.toJson(),
      'impulsoSuicidaTestBreve': impulsoSuicidaTestBreve.toJson(),
    };
  }
}
