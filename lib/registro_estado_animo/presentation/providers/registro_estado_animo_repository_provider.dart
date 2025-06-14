import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindsave/registro_estado_animo/domain/datasources/registro_estado_animo_datasource.dart';
import 'package:mindsave/registro_estado_animo/domain/repositories/registro_estado_animo_repository.dart';
import 'package:mindsave/registro_estado_animo/infrastructure/datasources/local_datasource.dart';
import 'package:mindsave/registro_estado_animo/infrastructure/repositories/registro_estado_animo_repository_impl.dart';

final registroEstadoAnimoRepositoryProvider = Provider<RegistroEstadoAnimoRepository>((ref) {
  final RegistroEstadoAnimoDatasource localDatasource = RegistroEstadoDeAnimoLocalDatasource();
  return RegistroEstadoAnimoRepositoryImpl(localDatasource);
});