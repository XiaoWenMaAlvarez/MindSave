import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindsave/testBreveEstadoAnimo/domain/repositories/test_breve_estado_de_animo_repository.dart';
import 'package:mindsave/testBreveEstadoAnimo/infrastructure/datasources/local_datasource.dart';
import 'package:mindsave/testBreveEstadoAnimo/infrastructure/repositories/test_breve_estado_de_animo_repository_impl.dart';

final testBreveEstadoDeAnimoRepositoryProvider = Provider<TestBreveEstadoDeAnimoRepository>((ref) {
  final TestBreveEstadoDeAnimoLocalDatasource localDatasource = TestBreveEstadoDeAnimoLocalDatasource();
  return TestBreveEstadoDeAnimoRepositoryImpl(localDatasource);
});
