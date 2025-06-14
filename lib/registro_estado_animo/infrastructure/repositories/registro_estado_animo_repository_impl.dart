import 'package:mindsave/registro_estado_animo/domain/datasources/registro_estado_animo_datasource.dart';
import 'package:mindsave/registro_estado_animo/domain/entities/registro_estado_animo.dart';
import 'package:mindsave/registro_estado_animo/domain/repositories/registro_estado_animo_repository.dart';

class RegistroEstadoAnimoRepositoryImpl extends RegistroEstadoAnimoRepository{

  final RegistroEstadoAnimoDatasource datasource;

  RegistroEstadoAnimoRepositoryImpl(this.datasource);

  @override
  Future<List<RegistroEstadoAnimo>> getRegistroEstadoDeAnimo({int page = 1}) {
    return datasource.getRegistroEstadoDeAnimo(page: page);
  }

  @override
  Future<int> saveRegistroEstadoDeAnimo(RegistroEstadoAnimo registroEstadoAnimo) {
    return datasource.saveRegistroEstadoDeAnimo(registroEstadoAnimo);
  }
  
  @override
  Future<void> editarRegistroEstadoDeAnimoDeHoy(RegistroEstadoAnimo registroEstadoAnimo) {
    return datasource.editarRegistroEstadoDeAnimoDeHoy(registroEstadoAnimo);
  }
  
  @override
  Future<void> eliminarRegistroEstadoDeAnimoDeHoy(int id) {
    return datasource.eliminarRegistroEstadoDeAnimoDeHoy(id);
  }
  
  @override
  Future<RegistroEstadoAnimo?> getRegistroEstadoDeAnimoById(int id) {
    return datasource.getRegistroEstadoDeAnimoById(id);
  }

}