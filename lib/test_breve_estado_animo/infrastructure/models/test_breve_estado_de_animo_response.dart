import 'package:mindsave/test_breve_estado_animo/infrastructure/models/depresion_test_breve_response.dart';
import 'package:mindsave/test_breve_estado_animo/infrastructure/models/impulso_suicida_test_breve_response.dart';
import 'package:mindsave/test_breve_estado_animo/infrastructure/models/sentimientos_ansiedad_emocional_test_breve_response.dart';
import 'package:mindsave/test_breve_estado_animo/infrastructure/models/sentimientos_ansiedad_fisica_test_breve_response.dart';

class TestBreveEstadoDeAnimoResponse {
  final DateTime fecha;
  final SentimientosAnsiedadEmocionalTestBreveResponse ansiedadEmocional;
  final SentimientosAnsiedadFisicaTestBreveResponse ansiedadFisica;
  final DepresionTestBreveResponse depresion;
  final ImpulsoSuicidaTestBreveResponse impulsoSuicida;

  TestBreveEstadoDeAnimoResponse({
    required this.fecha,
    required this.ansiedadEmocional,
    required this.ansiedadFisica,
    required this.depresion,
    required this.impulsoSuicida,
  });

  TestBreveEstadoDeAnimoResponse.fromJson(Map<String, dynamic> json)
      : fecha = DateTime.parse(json['fecha']),
        ansiedadEmocional = SentimientosAnsiedadEmocionalTestBreveResponse.fromJson(json['ansiedadEmocional']),
        ansiedadFisica = SentimientosAnsiedadFisicaTestBreveResponse.fromJson(json['ansiedadFisica']),
        depresion = DepresionTestBreveResponse.fromJson(json['depresion']),
        impulsoSuicida = ImpulsoSuicidaTestBreveResponse.fromJson(json['impulsoSuicida']);
      
  Map<String, dynamic> toJson() {
    return {
      'fecha': fecha.toIso8601String(),
      'ansiedadEmocional': ansiedadEmocional.toJson(),
      'ansiedadFisica': ansiedadFisica.toJson(),
      'depresion': depresion.toJson(),
      'impulsoSuicida': impulsoSuicida.toJson(),
    };
  }
}
