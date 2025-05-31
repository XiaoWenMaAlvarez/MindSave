import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindsave/testBreveEstadoAnimo/presentation/providers/providers.dart';

typedef VerifyTodayTestBreveEstadoDeAnimo = Future<bool> Function();

class IsTestBreveRealizadoHoyNotifier extends StateNotifier<bool> {
  
  Timer? _timer;

  final VerifyTodayTestBreveEstadoDeAnimo _verifyTodayTestBreveEstadoDeAnimo;

  IsTestBreveRealizadoHoyNotifier({
    required VerifyTodayTestBreveEstadoDeAnimo verifyTodayTestBreveEstadoDeAnimo,
  }):
    _verifyTodayTestBreveEstadoDeAnimo = verifyTodayTestBreveEstadoDeAnimo,
    super(false);

  Future<void> setIsTestBreveRealizadoHoy() async {
    final bool result = await _verifyTodayTestBreveEstadoDeAnimo();
    state = result;
  }

  void scheduleNextMidnightCheck() {
    _timer?.cancel();
    final now = DateTime.now();
    final nextMidnight = DateTime(now.year, now.month, now.day+1, 0, 0, 0);
    final durationUntilMidnight = nextMidnight.difference(now);

    if(durationUntilMidnight > Duration.zero) {
      _timer = Timer(durationUntilMidnight, () {
        setIsTestBreveRealizadoHoy();
        scheduleNextMidnightCheck();
      });
    }
  }

} 

final isTestBreveRealizadoHoyProvider = StateNotifierProvider<IsTestBreveRealizadoHoyNotifier, bool>(
  (ref) {
    return IsTestBreveRealizadoHoyNotifier(
      verifyTodayTestBreveEstadoDeAnimo: ref.watch(testBreveEstadoDeAnimoRepositoryProvider).isTestBreveRealizadoHoy,
      );
  }
);