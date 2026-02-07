import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindsave/test_breve_estado_animo/domain/entities/entities.dart';
import 'package:mindsave/test_breve_estado_animo/presentation/providers/providers.dart';

typedef GetTodayTestBreveEstadoDeAnimo = Future<TestBreveEstadoDeAnimo?> Function();

class TodayTestBreveEstadoDeAnimoNotifier extends StateNotifier<TestBreveEstadoDeAnimo?> {
  
  Timer? _timer;
  final GetTodayTestBreveEstadoDeAnimo _getTodayTestBreveEstadoDeAnimo;
  final SetIsLoading _setIsLoading;

  TodayTestBreveEstadoDeAnimoNotifier({
    required GetTodayTestBreveEstadoDeAnimo getTodayTestBreveEstadoDeAnimo,
    required SetIsLoading setIsLoading,
  }):
    _getTodayTestBreveEstadoDeAnimo = getTodayTestBreveEstadoDeAnimo,
    _setIsLoading = setIsLoading,
    super(null);

  Future<void> setTestBreveRealizadoHoy() async {
    if(state != null) return;
    _setIsLoading(true);
    final TestBreveEstadoDeAnimo? result = await _getTodayTestBreveEstadoDeAnimo();
    _setIsLoading(false);
    state = result;
  }

  void localSetTestBreveRealizadoHoy(TestBreveEstadoDeAnimo nvoTest) {
    state = nvoTest;
  }

  void eliminarTestBreveRealizadoHoy() {
    state = null;
  }

  void scheduleNextMidnightCheck() {
    _timer?.cancel();
    final now = DateTime.now();
    final nextMidnight = DateTime(now.year, now.month, now.day+1, 0, 0, 0);
    final durationUntilMidnight = nextMidnight.difference(now);

    if(durationUntilMidnight > Duration.zero) {
      _timer = Timer(durationUntilMidnight, () {
        setTestBreveRealizadoHoy();
        scheduleNextMidnightCheck();
      });
    }
  }

} 

final todayTestBreveEstadoDeAnimoProvider = StateNotifierProvider<TodayTestBreveEstadoDeAnimoNotifier, TestBreveEstadoDeAnimo?>(
  (ref) {
    bool setIsLoading(bool value) => ref.read(isLoadingProvider.notifier).state = false;
    return TodayTestBreveEstadoDeAnimoNotifier(
      getTodayTestBreveEstadoDeAnimo: ref.watch(testBreveEstadoDeAnimoRepositoryProvider).getTodayTestBreveEstadoDeAnimo,
      setIsLoading: setIsLoading,
    );
  }
);