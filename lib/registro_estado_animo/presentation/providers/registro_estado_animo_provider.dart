import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'registro_estado_animo_repository_provider.dart';
import 'package:mindsave/registro_estado_animo/domain/entities/entities.dart';
import 'package:mindsave/registro_estado_animo/domain/repositories/registro_estado_animo_repository.dart';

typedef SaveRegistroEstadoDeAnimo = Future<int> Function(RegistroEstadoAnimo registroEstadoAnimo);
typedef GetRegistroEstadoDeAnimo = Future<List<RegistroEstadoAnimo>> Function({int page});
typedef EditarRegistroEstadoDeAnimo = Future<void> Function(RegistroEstadoAnimo registroEstadoAnimo);
typedef EliminarRegistroEstadoDeAnimo = Future<void> Function(int id);
typedef CargarRegistroEstadoDeAnimoPorId = Future<RegistroEstadoAnimo?> Function(int id);

class RegistroEstadoDeAnimoNotifier extends StateNotifier<List<RegistroEstadoAnimo>> {
  final SaveRegistroEstadoDeAnimo _saveRegistroEstadoDeAnimo;
  final GetRegistroEstadoDeAnimo _getRegistroEstadoDeAnimo;
  final EditarRegistroEstadoDeAnimo _editarRegistroEstadoDeAnimo;
  final EliminarRegistroEstadoDeAnimo _eliminarRegistroEstadoDeAnimo;
  final CargarRegistroEstadoDeAnimoPorId _cargarRegistroEstadoDeAnimoPorId;

  RegistroEstadoDeAnimoNotifier({
    required SaveRegistroEstadoDeAnimo saveRegistroEstadoDeAnimo,
    required GetRegistroEstadoDeAnimo getRegistroEstadoDeAnimo,
    required EditarRegistroEstadoDeAnimo editarRegistroEstadoDeAnimo,
    required EliminarRegistroEstadoDeAnimo eliminarRegistroEstadoDeAnimo,
    required CargarRegistroEstadoDeAnimoPorId cargarRegistroEstadoDeAnimoPorId
  }): 
    _saveRegistroEstadoDeAnimo = saveRegistroEstadoDeAnimo,
    _getRegistroEstadoDeAnimo = getRegistroEstadoDeAnimo,
    _editarRegistroEstadoDeAnimo = editarRegistroEstadoDeAnimo,
    _eliminarRegistroEstadoDeAnimo = eliminarRegistroEstadoDeAnimo,
    _cargarRegistroEstadoDeAnimoPorId = cargarRegistroEstadoDeAnimoPorId,
    super([]);


  Future<void> cargarRegistrosEstadoDeAnimoByPage({int page = 1}) async {
    final List<RegistroEstadoAnimo> newRegistrosEstadoDeAnimo = await _getRegistroEstadoDeAnimo(page: page);
    state = [
      ...newRegistrosEstadoDeAnimo,
    ];
  }

  Future<void> cargarRegistrosEstadoDeAnimoById(int id) async {
    final bool isRegistroCargado = state.any((RegistroEstadoAnimo reg) => reg.id == id);
    if(isRegistroCargado) {
      return;
    }

    try {
      final RegistroEstadoAnimo? registroEstadoAnimoBuscado = await _cargarRegistroEstadoDeAnimoPorId(id);
      if(registroEstadoAnimoBuscado != null) {
        state = [
          ...state,
          registroEstadoAnimoBuscado
        ];
      }
    } catch (e) {
      rethrow;
    }
    

    return;
  }

  RegistroEstadoAnimo? getRegistroEstadoDeAnimoById(int id) {
    if(state.any((RegistroEstadoAnimo reg) => reg.id == id)){
      return state.firstWhere((RegistroEstadoAnimo reg) => reg.id == id);
    }

    return null;
  }


  Future<void> guardarRegistroEstadoDeAnimo(RegistroEstadoAnimo nvoRegistroEstadoAnimo) async {
    nvoRegistroEstadoAnimo.id = await _saveRegistroEstadoDeAnimo(nvoRegistroEstadoAnimo);

    if(state.isNotEmpty) {
      state = [
        ...state,
        nvoRegistroEstadoAnimo,
      ];
    }
  }

  Future<void> eliminarRegistroEstadoDeAnimo(int id) async {
    await _eliminarRegistroEstadoDeAnimo(id);

    if(state.isNotEmpty) {
      state = state.where((RegistroEstadoAnimo registroEstadoAnimo) => !(registroEstadoAnimo.id == id)).toList();
    }
    
  }

  Future<void> editarRegistroEstadoDeAnimo(RegistroEstadoAnimo nvoRegistroEstadoAnimo) async {
    if(state.isNotEmpty) {
      state = state.map((RegistroEstadoAnimo registroEstadoAnimo) {
        if(registroEstadoAnimo.id == nvoRegistroEstadoAnimo.id) return nvoRegistroEstadoAnimo;
        return registroEstadoAnimo;
      }).toList();
    }
    await _editarRegistroEstadoDeAnimo(nvoRegistroEstadoAnimo);
  }

}

final registroEstadoDeAnimoProvider = StateNotifierProvider<RegistroEstadoDeAnimoNotifier, List<RegistroEstadoAnimo>>(
  (ref) {
    final RegistroEstadoAnimoRepository registroEstadoDeAnimoRepository = ref.watch(registroEstadoAnimoRepositoryProvider);
    return RegistroEstadoDeAnimoNotifier(
      saveRegistroEstadoDeAnimo: registroEstadoDeAnimoRepository.saveRegistroEstadoDeAnimo,
      getRegistroEstadoDeAnimo: registroEstadoDeAnimoRepository.getRegistroEstadoDeAnimo,
      editarRegistroEstadoDeAnimo: registroEstadoDeAnimoRepository.editarRegistroEstadoDeAnimoDeHoy,
      eliminarRegistroEstadoDeAnimo: registroEstadoDeAnimoRepository.eliminarRegistroEstadoDeAnimoDeHoy,
      cargarRegistroEstadoDeAnimoPorId: registroEstadoDeAnimoRepository.getRegistroEstadoDeAnimoById
      );
  }
);
