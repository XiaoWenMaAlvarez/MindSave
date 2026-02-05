import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindsave/test_breve_estado_animo/domain/datasources/test_breve_estado_de_animo_datasource.dart';
import 'package:mindsave/test_breve_estado_animo/domain/repositories/test_breve_estado_de_animo_repository.dart';
import 'package:mindsave/test_breve_estado_animo/infrastructure/datasources/local_datasource.dart';
import 'package:mindsave/test_breve_estado_animo/infrastructure/repositories/test_breve_estado_de_animo_repository_impl.dart';

final testBreveEstadoDeAnimoRepositoryProvider = Provider<TestBreveEstadoDeAnimoRepository>((ref) {
  //TODO cambiar datasource local a datasource de Postgres
  final TestBreveEstadoDeAnimoDatasource localDatasource = TestBreveEstadoDeAnimoLocalDatasource();
  return TestBreveEstadoDeAnimoRepositoryImpl(localDatasource);
});
