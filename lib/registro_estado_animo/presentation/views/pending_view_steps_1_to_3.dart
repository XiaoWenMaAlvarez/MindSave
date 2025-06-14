import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mindsave/home/presentation/widgets/widgets.dart';
import 'package:mindsave/registro_estado_animo/domain/entities/entities.dart';
import 'package:mindsave/config/helpers/date_helper.dart';
import 'package:mindsave/registro_estado_animo/presentation/providers/providers.dart';
import 'package:mindsave/registro_estado_animo/presentation/widgets/widgets.dart';

class PendingViewSteps1To3 extends StatelessWidget {
  final int idRegistroEstadoAnimo;

  const PendingViewSteps1To3({required this.idRegistroEstadoAnimo ,super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          leading: SizedBox(),
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppbar(),
            centerTitle: true,
          ),
        ),

        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index){
              return _PendingViewSteps1To3Body(idRegistroEstadoAnimo);
            },
            childCount: 1,
          ),
        )
      ],
    );
  }
}


class _PendingViewSteps1To3Body extends ConsumerStatefulWidget {
  final int idRegistroEstadoAnimo;

  const _PendingViewSteps1To3Body(this.idRegistroEstadoAnimo);

  @override
  ConsumerState<_PendingViewSteps1To3Body> createState() => _PendingViewSteps1To3BodyState();
}

class _PendingViewSteps1To3BodyState extends ConsumerState<_PendingViewSteps1To3Body> {

  @override
  void initState(){
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(registroEstadoDeAnimoProvider.notifier).cargarRegistrosEstadoDeAnimoById(widget.idRegistroEstadoAnimo);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final RegistroEstadoAnimo? registroEstadoAnimo = ref.watch(registroEstadoDeAnimoProvider.notifier).getRegistroEstadoDeAnimoById(widget.idRegistroEstadoAnimo);

    if(registroEstadoAnimo == null){
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    final formKeyPaso1 = GlobalKey<FormState>();
    final formKeyPaso2 = GlobalKey<FormState>();
    final formKeyPaso3 = GlobalKey<FormState>();

    return Column(
      children: [
        _TitleAndInstruction(),
        SizedBox(height: 30),
        Divider(),
        RegistroEstadoAnimoPaso1(registroEstadoAnimo, formKeyPaso1),
        SizedBox(height: 30),
        RegistroEstadoAnimoPaso2(registroEstadoAnimo, formKeyPaso2),
        SizedBox(height: 30),
        RegistroEstadoAnimoPaso3(registroEstadoAnimo, formKeyPaso3),
        SizedBox(height: 30),
        FilledButton.icon(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.red),
            foregroundColor: WidgetStatePropertyAll(Colors.white)
          ),
          icon: const Icon(Icons.delete_outline),
          label: const Text('Eliminar registro de estado de ánimo'),
          onPressed: () async {
            await _preguntarSiDeseaEliminarRegistro(context, registroEstadoAnimo, ref);
            return;
          }
        ),
        SizedBox(height: 10),
        FilledButton.icon(
          icon: const Icon(Icons.arrow_forward),
          iconAlignment: IconAlignment.end,
          label: const Text('Avanzar al siguiente paso'),
          onPressed: () async {
            String mensaje = "";
            if(formKeyPaso1.currentState != null && !formKeyPaso1.currentState!.validate()) mensaje = "Error en la sección de suceso trastornador";
            if(formKeyPaso2.currentState != null && !formKeyPaso2.currentState!.validate()) mensaje = "Error en la sección de emociones";
            if(formKeyPaso3.currentState != null &&!formKeyPaso3.currentState!.validate()) mensaje = "Error en la sección de pensamientos negativos";
            if(registroEstadoAnimo.isValid != null) mensaje = registroEstadoAnimo.isValid ?? "";

            if(formKeyPaso1.currentState != null && formKeyPaso2.currentState != null && formKeyPaso3.currentState != null  
              && formKeyPaso1.currentState!.validate() && formKeyPaso2.currentState!.validate() && formKeyPaso3.currentState!.validate() 
              && registroEstadoAnimo.isValid == null ){
              await _preguntarSiDeseaGuardarCambio(context, registroEstadoAnimo, ref);
              if(context.mounted) context.push("/registroEstadoAnimo/3/${widget.idRegistroEstadoAnimo}");
              return;
            }
            if(mensaje != "") _showSnackBar(context, mensaje);
          }, 
        ),
        SizedBox(height: 30),
      ],
    );
    
  }
}

class _TitleAndInstruction extends StatelessWidget {

  const _TitleAndInstruction();

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).colorScheme.primary;
    TextStyle titleStyle = Theme.of(context).textTheme.titleLarge!.copyWith(
      color: primaryColor,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );

    TextStyle bodyStyle = Theme.of(context).textTheme.bodyMedium!.copyWith(
      fontSize: 16,
    );

    TextStyle boldBodyStyle = Theme.of(context).textTheme.bodyLarge!.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );

    final DateTime hoy = DateTime.now();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Registro de Estado de Ánimo', style: titleStyle),
          const SizedBox(height: 20),
          Text('El registro diario de estado de ánimo es la piedra angular de la terapia, este le ayudará a detectar y a cambiar los pensamientos que desencadenan la ansiedad y la depresión.',
            style: bodyStyle),
          const SizedBox(height: 10),
          Text('Fecha de hoy: ${DateHelper.formatearFecha(hoy)}', style: boldBodyStyle),
        ],
      ),
    );
  }
}

_showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

Future<void> _preguntarSiDeseaGuardarCambio(BuildContext context, RegistroEstadoAnimo registroEstadoAnimo, WidgetRef ref) async {
    await showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: const Text('¿Desea guardar los progresos?'),
        content: Text('¿Quiere guardar o descartar los cambios realizados?'),
        actions: [
          FilledButton(
            onPressed: () async {
              await ref.read(registroEstadoDeAnimoProvider.notifier).editarRegistroEstadoDeAnimo(registroEstadoAnimo);
              if(context.mounted) {
                _showSnackBar(context, 'Cambios guardados');
                context.pop();
              } 
            }, 
            child: const Text('Guardar')
          ),

          TextButton(
            onPressed: () => context.pop(), 
            child: const Text('No guardar')
          ),
        ],
      )
    );
  }

Future<void> _preguntarSiDeseaEliminarRegistro(BuildContext context, RegistroEstadoAnimo registroEstadoAnimo, WidgetRef ref) async {
    await showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: const Text('¿Desea eliminar el registro de estado de ánimo?'),
        content: Text('Advertencia: Esta acción NO se puede deshacer'),
        actions: [
          FilledButton(
            onPressed: () async {
              await ref.read(registroEstadoDeAnimoProvider.notifier).eliminarRegistroEstadoDeAnimo(registroEstadoAnimo.id);
              if(context.mounted) {
                _showSnackBar(context, 'Registro eliminado con éxito');
                context.pop();
                context.push("/registroEstadoAnimo/1");
              } 
            }, 
            child: const Text('Si, eliminar')
          ),

          TextButton(
            onPressed: () => context.pop(), 
            child: const Text('No, conservar')
          ),
        ],
      )
    );
  }
