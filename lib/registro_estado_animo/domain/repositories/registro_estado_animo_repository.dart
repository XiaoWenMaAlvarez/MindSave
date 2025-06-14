import 'package:mindsave/registro_estado_animo/domain/entities/entities.dart';

abstract class RegistroEstadoAnimoRepository {
  Future<int> saveRegistroEstadoDeAnimo(RegistroEstadoAnimo registroEstadoAnimo);

  Future<List<RegistroEstadoAnimo>> getRegistroEstadoDeAnimo({int page = 1});

  Future<RegistroEstadoAnimo?> getRegistroEstadoDeAnimoById(int id);

  Future<void> editarRegistroEstadoDeAnimoDeHoy(RegistroEstadoAnimo registroEstadoAnimo);

  Future<void> eliminarRegistroEstadoDeAnimoDeHoy(int id);
  
}