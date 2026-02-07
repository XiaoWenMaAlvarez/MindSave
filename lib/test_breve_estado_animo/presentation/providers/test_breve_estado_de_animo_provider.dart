import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindsave/test_breve_estado_animo/domain/entities/entities.dart';
import 'package:mindsave/test_breve_estado_animo/domain/repositories/test_breve_estado_de_animo_repository.dart';
import 'providers.dart';


typedef GetTestBreveEstadoDeAnimoByYearCallback = Future<List<TestBreveEstadoDeAnimo>> Function(int year);
typedef SaveTestBreveEstadoDeAnimo = Future<void> Function(TestBreveEstadoDeAnimo nvoTestBreveEstadoDeAnimo);
typedef DeleteTodayTestBreveEstadoDeAnimo = Future<void> Function();
typedef EditarTestBreveEstadoDeAnimoDeHoy = Future<void> Function(TestBreveEstadoDeAnimo nvoTestBreveEstadoDeAnimo);


class TestBreveEstadoDeAnimoNotifier extends StateNotifier<List<TestBreveEstadoDeAnimo>> {
  final GetTestBreveEstadoDeAnimoByYearCallback _fetchTestBreveEstadoDeAnimoByYear;
  final SaveTestBreveEstadoDeAnimo _saveTestBreveEstadoDeAnimo;
  final DeleteTodayTestBreveEstadoDeAnimo _deleteTodayTestBreveEstadoDeAnimo;
  final EditarTestBreveEstadoDeAnimoDeHoy _editarTestBreveEstadoDeAnimoDeHoy;
  final SetIsLoading _setIsLoading;

  TestBreveEstadoDeAnimoNotifier({
    required GetTestBreveEstadoDeAnimoByYearCallback fetchTestBreveEstadoDeAnimoByYear,
    required SaveTestBreveEstadoDeAnimo saveTestBreveEstadoDeAnimo,
    required DeleteTodayTestBreveEstadoDeAnimo deleteTodayTestBreveEstadoDeAnimo,
    required EditarTestBreveEstadoDeAnimoDeHoy editarTestBreveEstadoDeAnimoDeHoy,
    required SetIsLoading setIsLoading,
  }): 
    _fetchTestBreveEstadoDeAnimoByYear = fetchTestBreveEstadoDeAnimoByYear,
    _saveTestBreveEstadoDeAnimo = saveTestBreveEstadoDeAnimo,
    _deleteTodayTestBreveEstadoDeAnimo = deleteTodayTestBreveEstadoDeAnimo,
    _editarTestBreveEstadoDeAnimoDeHoy = editarTestBreveEstadoDeAnimoDeHoy,
    _setIsLoading = setIsLoading,
    super([]);

  Future<void> loadTestBreveEstadoDeAnimoByYear(int year) async {
    if(state.isNotEmpty && state.any((test) => test.fechaCreacion.year == year)) {
      return;
    }
    _setIsLoading(true);
    final List<TestBreveEstadoDeAnimo> newTestsBreveEstadoDeAnimo = await _fetchTestBreveEstadoDeAnimoByYear(year);
    state = [
      ...state,
      ...newTestsBreveEstadoDeAnimo,
    ];
    _setIsLoading(false);
  }

  Future<String> guardarTestBreveEstadoDeAnimo(TestBreveEstadoDeAnimo nvoTestBreveEstadoDeAnimo) async {
    try {
      _setIsLoading(true);
      await _saveTestBreveEstadoDeAnimo(nvoTestBreveEstadoDeAnimo);

      if(state.isNotEmpty) {
        if(state.first.fechaCreacion.year == DateTime.now().year) {
          state = [
            ...state,
            nvoTestBreveEstadoDeAnimo,
          ];
        }
      }
      _setIsLoading(false);
      return "OK";
    } catch (e) {
      _setIsLoading(false);
      return e.toString();
    }
    
  }

  Future<void> eliminarTestBreveEstadoDeAnimoDeHoy() async {
    _setIsLoading(true);
    await _deleteTodayTestBreveEstadoDeAnimo();

    if(state.isNotEmpty) {
      if(state.first.fechaCreacion.year == DateTime.now().year) {
        state = state.where((TestBreveEstadoDeAnimo testBreveEstadoDeAnimo) {
          return !(testBreveEstadoDeAnimo.fechaCreacion.year == DateTime.now().year 
          && testBreveEstadoDeAnimo.fechaCreacion.month == DateTime.now().month
          && testBreveEstadoDeAnimo.fechaCreacion.day == DateTime.now().day);
        }).toList();
      }
    }

    _setIsLoading(false);
    
  }

  Future<void> sobrescribirTestBreveEstadoDeAnimoDeHoy(TestBreveEstadoDeAnimo nvoTestBreveEstadoDeAnimo) async {
    _setIsLoading(true);
    await _editarTestBreveEstadoDeAnimoDeHoy(nvoTestBreveEstadoDeAnimo);

    if(state.isNotEmpty) {
      if(state.first.fechaCreacion.year == DateTime.now().year) {
        state = state.where((TestBreveEstadoDeAnimo testBreveEstadoDeAnimo) {
          return !(testBreveEstadoDeAnimo.fechaCreacion.year == DateTime.now().year 
          && testBreveEstadoDeAnimo.fechaCreacion.month == DateTime.now().month
          && testBreveEstadoDeAnimo.fechaCreacion.day == DateTime.now().day);
        }).toList();

        state = [
          ...state,
          nvoTestBreveEstadoDeAnimo,
        ];

      }
    }
    _setIsLoading(false);
  }

}

final testBreveEstadoDeAnimoProvider = StateNotifierProvider<TestBreveEstadoDeAnimoNotifier, List<TestBreveEstadoDeAnimo>>(
  (ref) {
    final TestBreveEstadoDeAnimoRepository testBreveEstadoDeAnimoRepository = ref.watch(testBreveEstadoDeAnimoRepositoryProvider);
    bool setIsLoading(bool value) => ref.read(isLoadingProvider.notifier).state = value;
    return TestBreveEstadoDeAnimoNotifier(
      fetchTestBreveEstadoDeAnimoByYear: testBreveEstadoDeAnimoRepository.getTestBreveEstadoDeAnimoByYear,
      saveTestBreveEstadoDeAnimo: testBreveEstadoDeAnimoRepository.saveTestBreveEstadoDeAnimo,
      deleteTodayTestBreveEstadoDeAnimo: testBreveEstadoDeAnimoRepository.eliminarTestBreveEstadoDeAnimoDeHoy,
      editarTestBreveEstadoDeAnimoDeHoy: testBreveEstadoDeAnimoRepository.editarTestBreveEstadoDeAnimoDeHoy,
      setIsLoading: setIsLoading,
      );
  }
);