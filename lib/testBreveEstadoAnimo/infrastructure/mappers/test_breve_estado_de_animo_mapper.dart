import 'package:mindsave/testBreveEstadoAnimo/domain/entities/entities.dart';
import 'package:mindsave/testBreveEstadoAnimo/infrastructure/models/models.dart';

class TestBreveEstadoDeAnimoMapper {

  static TestBreveEstadoDeAnimo testBreveEstadoDeAnimoDBToEntity(TestBreveEstadoDeAnimoResponse testBreveEstadoDeAnimoResponse) {
    return TestBreveEstadoDeAnimo(
      fechaCreacion: testBreveEstadoDeAnimoResponse.fechaCreacion,
      sentimientosAnsiedadEmocionalTestBreve: sentimientosAnsiedadEmocionalTestBreveDBToEntity(testBreveEstadoDeAnimoResponse.sentimientosAnsiedadEmocionalTestBreve),
      sentimientosAnsiedadFisicaTestBreve: sentimientosAnsiedadFisicaTestBreveDBToEntity(testBreveEstadoDeAnimoResponse.sentimientosAnsiedadFisicaTestBreve),
      depresionTestBreve: depresionTestBreveDBToEntity(testBreveEstadoDeAnimoResponse.depresionTestBreve),
      impulsoSuicidaTestBreve: impulsoSuicidaTestBreveDBToEntity(testBreveEstadoDeAnimoResponse.impulsoSuicidaTestBreve),
    );
  }

  static DepresionTestBreve depresionTestBreveDBToEntity(DepresionTestBreveResponse depresionTestBreveResponse) {
    return DepresionTestBreve(
      tristeza: depresionTestBreveResponse.tristeza,
      desesperanza: depresionTestBreveResponse.desesperanza,
      bajaAutoestima: depresionTestBreveResponse.bajaAutoestima,
      faltaDeValor: depresionTestBreveResponse.faltaDeValor,
      perdidaDeSatisfaccion: depresionTestBreveResponse.perdidaDeSatisfaccion,
    );
  }

  static ImpulsoSuicidaTestBreve impulsoSuicidaTestBreveDBToEntity(ImpulsoSuicidaTestBreveResponse depresionTestBreveResponse) {
    return ImpulsoSuicidaTestBreve(
      pensamientosSuicidas: depresionTestBreveResponse.pensamientosSuicidas,
      deseosDeMorir: depresionTestBreveResponse.deseosDeMorir,
    );
  }

  static SentimientosAnsiedadEmocionalTestBreve sentimientosAnsiedadEmocionalTestBreveDBToEntity(SentimientosAnsiedadEmocionalTestBreveResponse sentimientosAnsiedadEmocionalTestBreveResponse) {
    return SentimientosAnsiedadEmocionalTestBreve(
      angustiado: sentimientosAnsiedadEmocionalTestBreveResponse.angustiado,
      nervioso: sentimientosAnsiedadEmocionalTestBreveResponse.nervioso,
      preocupado: sentimientosAnsiedadEmocionalTestBreveResponse.preocupado,
      asustado: sentimientosAnsiedadEmocionalTestBreveResponse.asustado,
      tenso: sentimientosAnsiedadEmocionalTestBreveResponse.tenso,
    );
  }

  static SentimientosAnsiedadFisicaTestBreve sentimientosAnsiedadFisicaTestBreveDBToEntity(SentimientosAnsiedadFisicaTestBreveResponse sentimientosAnsiedadFisicaTestBreveResponse) {
    return SentimientosAnsiedadFisicaTestBreve(
      palpitaciones: sentimientosAnsiedadFisicaTestBreveResponse.palpitaciones,
      sudoracion: sentimientosAnsiedadFisicaTestBreveResponse.sudoracion,
      temblores: sentimientosAnsiedadFisicaTestBreveResponse.temblores,
      dificultadRespirar: sentimientosAnsiedadFisicaTestBreveResponse.dificultadRespirar,
      ahogo: sentimientosAnsiedadFisicaTestBreveResponse.ahogo,
      dolorPecho: sentimientosAnsiedadFisicaTestBreveResponse.dolorPecho,
      nauseas: sentimientosAnsiedadFisicaTestBreveResponse.nauseas,
      mareos: sentimientosAnsiedadFisicaTestBreveResponse.mareos,
      sensacionIrrealidad: sentimientosAnsiedadFisicaTestBreveResponse.sensacionIrrealidad,
      inestabilidadHormigueos: sentimientosAnsiedadFisicaTestBreveResponse.inestabilidadHormigueos,
    );
  }

}
