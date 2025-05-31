import 'package:mindsave/testBreveEstadoAnimo/domain/entities/test_breve_estado_de_animo.dart';

abstract class TestBreveEstadoDeAnimoRepository {

  //CRUD
  
  Future<void> saveTestBreveEstadoDeAnimo(TestBreveEstadoDeAnimo testBreveEstadoDeAnimo);

  Future<List<TestBreveEstadoDeAnimo>> getTestBreveEstadoDeAnimoByYear(int year);

  Future<void> editarTestBreveEstadoDeAnimoDeHoy(TestBreveEstadoDeAnimo testBreveEstadoDeAnimo);

  Future<void> eliminarTestBreveEstadoDeAnimoDeHoy();
  

  //OTROS

  Future<bool> isTestBreveRealizadoHoy();

  Future<TestBreveEstadoDeAnimo?> getTodayTestBreveEstadoDeAnimo();

  
}