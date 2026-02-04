import 'package:mindsave/test_breve_estado_animo/infrastructure/models/depresion_test_breve_response.dart';
import 'package:mindsave/test_breve_estado_animo/infrastructure/models/impulso_suicida_test_breve_response.dart';
import 'package:mindsave/test_breve_estado_animo/infrastructure/models/sentimientos_ansiedad_emocional_test_breve_response.dart';
import 'package:mindsave/test_breve_estado_animo/infrastructure/models/sentimientos_ansiedad_fisica_test_breve_response.dart';

class TestBreveEstadoDeAnimoResponse {
  final DateTime fechaCreacion;
  final SentimientosAnsiedadEmocionalTestBreveResponse ansiedadEmocional;
  final SentimientosAnsiedadFisicaTestBreveResponse ansiedadFisica;
  final DepresionTestBreveResponse depresion;
  final ImpulsoSuicidaTestBreveResponse impulsoSuicida;

  TestBreveEstadoDeAnimoResponse({
    required this.fechaCreacion,
    required this.ansiedadEmocional,
    required this.ansiedadFisica,
    required this.depresion,
    required this.impulsoSuicida,
  });

  TestBreveEstadoDeAnimoResponse.fromJsonEntity(Map<String, dynamic> json)
      : fechaCreacion = DateTime.parse(json['fechaCreacion']),
        ansiedadEmocional = SentimientosAnsiedadEmocionalTestBreveResponse.fromJson(json['sentimientosAnsiedadEmocionalTestBreve']),
        ansiedadFisica = SentimientosAnsiedadFisicaTestBreveResponse.fromJson(json['sentimientosAnsiedadFisicaTestBreve']),
        depresion = DepresionTestBreveResponse.fromJson(json['depresionTestBreve']),
        impulsoSuicida = ImpulsoSuicidaTestBreveResponse.fromJson(json['impulsoSuicidaTestBreve']);
      
  Map<String, dynamic> toJsonAPI() {
    return {
      'fechaCreacion': fechaCreacion.toIso8601String(),
      'ansiedadEmocional': ansiedadEmocional.toJson(),
      'ansiedadFisica': ansiedadFisica.toJson(),
      'depresion': depresion.toJson(),
      'impulsoSuicida': impulsoSuicida.toJson(),
    };
  }
}
