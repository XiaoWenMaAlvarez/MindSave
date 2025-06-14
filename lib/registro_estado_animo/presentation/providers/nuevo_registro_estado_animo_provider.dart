import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindsave/registro_estado_animo/domain/entities/entities.dart';
import 'package:mindsave/registro_estado_animo/presentation/providers/providers.dart';

typedef CrearRegistroEstadoDeAnimo = Future<void> Function(RegistroEstadoAnimo registroEstadoAnimo);

class NuevoRegistroEstadoDeAnimoNotifier extends StateNotifier<RegistroEstadoAnimo> {

  final CrearRegistroEstadoDeAnimo _crearRegistroEstadoDeAnimo;
  
  NuevoRegistroEstadoDeAnimoNotifier({
    required CrearRegistroEstadoDeAnimo crearRegistroEstadoDeAnimo,
  }):
    _crearRegistroEstadoDeAnimo = crearRegistroEstadoDeAnimo,
    super(RegistroEstadoAnimo(
      id: 0, 
      fecha: DateTime.now(), 
      sucesoTrastornador: "", 
      grupoEmociones: GrupoEmociones(), 
      listaPensamientos: []
    ));

  Future<void> crearNuevoRegistroEstadoAnimo() async {
    state = RegistroEstadoAnimo(
      id: 0, 
      fecha: DateTime.now(), 
      sucesoTrastornador: "", 
      grupoEmociones: GrupoEmociones(), 
      listaPensamientos: []
    );
  }

  Future<void> guardarRegistroEstadoDeAnimo() async {
    await _crearRegistroEstadoDeAnimo(state);
    crearNuevoRegistroEstadoAnimo();
  }

}


final nuevoRegistroEstadoDeAnimoProvider = StateNotifierProvider<NuevoRegistroEstadoDeAnimoNotifier, RegistroEstadoAnimo>(
  (ref) {
    final CrearRegistroEstadoDeAnimo crearRegistroEstadoDeAnimo = ref.watch(registroEstadoDeAnimoProvider.notifier).guardarRegistroEstadoDeAnimo;
    return NuevoRegistroEstadoDeAnimoNotifier(
      crearRegistroEstadoDeAnimo: crearRegistroEstadoDeAnimo,
    );
  }
);