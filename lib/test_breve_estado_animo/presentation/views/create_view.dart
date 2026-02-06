import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mindsave/test_breve_estado_animo/domain/entities/entities.dart';
import 'package:mindsave/test_breve_estado_animo/presentation/providers/providers.dart';
import 'package:mindsave/test_breve_estado_animo/presentation/widgets/widgets.dart';
import 'package:mindsave/home/presentation/widgets/widgets.dart';


class CreateView extends StatelessWidget {
  const CreateView({super.key});

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
              return _TestBreveForm();
            },
            childCount: 1,
          ),
        )
      ],
    );
  }
}

class _TestBreveForm extends ConsumerStatefulWidget {
  const _TestBreveForm();

  @override
  ConsumerState<_TestBreveForm> createState() => _TestBreveFormState();
}

class _TestBreveFormState extends ConsumerState<_TestBreveForm> {

  late bool isTestBreveRealizadoHoy;

  TestBreveEstadoDeAnimo testBreveEstadoDeAnimo = TestBreveEstadoDeAnimo(
    fechaCreacion: DateTime.now(),
    sentimientosAnsiedadEmocionalTestBreve: SentimientosAnsiedadEmocionalTestBreve(),
    sentimientosAnsiedadFisicaTestBreve: SentimientosAnsiedadFisicaTestBreve(),
    depresionTestBreve: DepresionTestBreve(),
    impulsoSuicidaTestBreve: ImpulsoSuicidaTestBreve(),
  );

  @override
  void initState(){
    ref.read(todayTestBreveEstadoDeAnimoProvider.notifier).setTestBreveRealizadoHoy();
    ref.read(todayTestBreveEstadoDeAnimoProvider.notifier).scheduleNextMidnightCheck();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    isTestBreveRealizadoHoy = ref.watch(todayTestBreveEstadoDeAnimoProvider) != null;
    
    return Column(
      children: [ 
        _TitleAndInstruction(isTestBreveRealizadoHoy),
        SizedBox(height: 30),
        Divider(),
        AnsiedadEmocionalForm(testBreveEstadoDeAnimo.sentimientosAnsiedadEmocionalTestBreve),
        AnsiedadFisicaForm(testBreveEstadoDeAnimo.sentimientosAnsiedadFisicaTestBreve),
        DepresionForm(testBreveEstadoDeAnimo.depresionTestBreve),
        ImpulsoSuicidaForm(testBreveEstadoDeAnimo.impulsoSuicidaTestBreve),

        const SizedBox(height: 20),

        FilledButton.icon(
          icon: const Icon(Icons.save),
          label: const Text('Guardar Test Breve Estado de Ánimo'),
          onPressed: isTestBreveRealizadoHoy ? null : () async {
            testBreveEstadoDeAnimo.fechaCreacion = DateTime.now();
            final String result = await ref.read(testBreveEstadoDeAnimoProvider.notifier).guardarTestBreveEstadoDeAnimo(testBreveEstadoDeAnimo);
            if(result != "OK") {
              if(context.mounted) _showSnackBar(context, "Error al intentar guardar el test de estado de ánimo");
              return;
            }
            if(context.mounted) _showSnackBar(context, 'Test Breve de Estado de Ánimo guardado');
            await ref.read(todayTestBreveEstadoDeAnimoProvider.notifier).setTestBreveRealizadoHoy();
            if(context.mounted) context.push("/testBreveEstadoAnimo/1");
          }, 
        ),

        if(isTestBreveRealizadoHoy) 
          ...[ 
            const Text("Ya ha realizado el test de hoy", style: TextStyle(color: Colors.red, fontSize: 16)),
            const SizedBox(height: 20),
            const Text("Sin embargo puedes:",),
            const SizedBox(height: 10),
            FilledButton.icon(
              icon: const Icon(Icons.edit),
              label: const Text('Editar Test Breve de Estado de Ánimo'),
              onPressed: () => _mostrarMensajeEditarTestBreveEstadoDeAnimo(context, ref, testBreveEstadoDeAnimo),
            ),
            const SizedBox(height: 10),
            const Text("o",),
            const SizedBox(height: 10),
            OutlinedButton.icon(
              label: const Text('Eliminar Test Breve de Estado de Ánimo'),
              icon: const Icon(Icons.delete),
              onPressed: () => _mostrarMensajeEliminarTestBreveEstadoDeAnimo(context, ref), 
            ),
          ],

        SizedBox(height: 20),
      ],
    );
  }
}

class _TitleAndInstruction extends StatelessWidget {

  final bool isTestBreveRealizadoHoy ;

  const _TitleAndInstruction(this.isTestBreveRealizadoHoy);

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

    final String monthNumberText =  hoy.month < 10? "0${hoy.month}" : "${hoy.month}"; 
    final String dayNumberText =  hoy.day < 10? "0${hoy.day}" : "${hoy.day}"; 

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Test Breve Estado de Ánimo', style: titleStyle),
          const SizedBox(height: 20),
          Text('Escriba su puntuación en cada ítem en los recuadros por debajo de la fecha, sobre la base de cómo se ha sentido últimamente.',
            style: bodyStyle),
          const SizedBox(height: 10),
          Text('Por favor, responda a todos los ítem.', style: bodyStyle),
          const SizedBox(height: 20),
          Text('Fecha de hoy: $dayNumberText/$monthNumberText/${hoy.year}', style: boldBodyStyle),

          if(isTestBreveRealizadoHoy) 
            ...[
              const SizedBox(height: 20),
              Text('Nota: Ya ha realizado el test de hoy, sin embargo puedes editarlo.', style: bodyStyle.copyWith(color: Colors.red, fontSize: 16)),
            ]
        ],
      ),
    );
  }
}

_showSnackBar(BuildContext context, String message) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}

void _mostrarMensajeEliminarTestBreveEstadoDeAnimo(BuildContext context, WidgetRef ref) {
  showDialog(
    context: context, 
    builder: (context) => AlertDialog(
      title: const Text('Eliminar Test Breve de Estado de Ánimo'),
      content: const Text('¿Está seguro que desea eliminar el test breve de estado de ánimo de hoy?'),
      actions: [
        FilledButton(
          onPressed: () async {
            await ref.read(testBreveEstadoDeAnimoProvider.notifier).eliminarTestBreveEstadoDeAnimoDeHoy();
            ref.read(todayTestBreveEstadoDeAnimoProvider.notifier).eliminarTestBreveRealizadoHoy();
            if(context.mounted) {
              _showSnackBar(context, 'Test Breve de Estado de Ánimo eliminado');
              context.pop();
              context.push("/testBreveEstadoAnimo/0");
            } 
          }, 
          child: const Text('Si, eliminar')
        ),

        TextButton(
          onPressed: () => context.pop(), 
          child: const Text('No, cancelar')
        ),
      ],
    )
  );
}

void _mostrarMensajeEditarTestBreveEstadoDeAnimo(BuildContext context, WidgetRef ref, TestBreveEstadoDeAnimo testBreveEstadoDeAnimo) {
  showDialog(
    context: context, 
    builder: (context) => AlertDialog(
      title: const Text('Editar Test Breve de Estado de Ánimo'),
      content: const Text('¿Está seguro que desea sobrescribir el test breve de estado de ánimo de hoy?'),
      actions: [
        FilledButton(
          onPressed: () async {
            await ref.read(testBreveEstadoDeAnimoProvider.notifier).sobrescribirTestBreveEstadoDeAnimoDeHoy(testBreveEstadoDeAnimo);
            await ref.read(todayTestBreveEstadoDeAnimoProvider.notifier).setTestBreveRealizadoHoy();
            if(context.mounted) {
              _showSnackBar(context, 'Test Breve de Estado de Ánimo editado');
              context.pop();
              context.push("/testBreveEstadoAnimo/0");
            } 
          }, 
          child: const Text('Si, editar')
        ),

        TextButton(
          onPressed: () => context.pop(), 
          child: const Text('No, cancelar')
        ),
      ],
    )
  );
}