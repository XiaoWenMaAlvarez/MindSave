import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindsave/test_breve_estado_animo/domain/entities/entities.dart';
import 'package:mindsave/test_breve_estado_animo/presentation/providers/providers.dart';

typedef GetTodayTestBreveEstadoDeAnimo = Future<TestBreveEstadoDeAnimo?> Function();

class TodayTestBreveEstadoDeAnimoNotifier extends StateNotifier<TestBreveEstadoDeAnimo?> {

  final GetTodayTestBreveEstadoDeAnimo _getTodayTestBreveEstadoDeAnimo;

  TodayTestBreveEstadoDeAnimoNotifier({
    required GetTodayTestBreveEstadoDeAnimo getTodayTestBreveEstadoDeAnimo,
  }):
    _getTodayTestBreveEstadoDeAnimo = getTodayTestBreveEstadoDeAnimo,
    super(null);

  Future<void> setTestBreveRealizadoHoy() async {
    final TestBreveEstadoDeAnimo? result = await _getTodayTestBreveEstadoDeAnimo();
    state = result;
  }

} 

final todayTestBreveEstadoDeAnimoProvider = StateNotifierProvider<TodayTestBreveEstadoDeAnimoNotifier, TestBreveEstadoDeAnimo?>(
  (ref) {
    return TodayTestBreveEstadoDeAnimoNotifier(
      getTodayTestBreveEstadoDeAnimo: ref.watch(testBreveEstadoDeAnimoRepositoryProvider).getTodayTestBreveEstadoDeAnimo,
    );
  }
);