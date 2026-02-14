import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindsave/auth/presentation/providers/auth_provider.dart';
import 'package:mindsave/test_breve_estado_animo/domain/datasources/test_breve_estado_de_animo_datasource.dart';
import 'package:mindsave/test_breve_estado_animo/domain/repositories/test_breve_estado_de_animo_repository.dart';
import 'package:mindsave/test_breve_estado_animo/infrastructure/repositories/test_breve_estado_de_animo_repository_impl.dart';
import '../../infrastructure/datasources/api_datasource.dart';

final testBreveEstadoDeAnimoRepositoryProvider = Provider<TestBreveEstadoDeAnimoRepository>((ref) {
  final String accessToken = ref.watch(authProvider).user?.token ?? "";
  final TestBreveEstadoDeAnimoDatasource localDatasource = TestBreveEstadoDeAnimoAPIDatasource(accessToken: accessToken);
  return TestBreveEstadoDeAnimoRepositoryImpl(localDatasource);
});
