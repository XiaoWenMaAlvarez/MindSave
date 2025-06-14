import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mindsave/home/presentation/widgets/widgets.dart';
import 'package:mindsave/registro_estado_animo/domain/entities/entities.dart';
import 'package:mindsave/config/helpers/date_helper.dart';
import 'package:mindsave/registro_estado_animo/presentation/providers/providers.dart';
import 'package:mindsave/registro_estado_animo/presentation/widgets/widgets.dart';

class CompleteViewDetails extends StatelessWidget {
  final int idRegistroEstadoAnimo;

  const CompleteViewDetails({required this.idRegistroEstadoAnimo ,super.key});

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
              return _CompleteViewDetailsBody(idRegistroEstadoAnimo);
            },
            childCount: 1,
          ),
        )
      ],
    );
  }
}


class _CompleteViewDetailsBody extends ConsumerStatefulWidget {
  final int idRegistroEstadoAnimo;

  const _CompleteViewDetailsBody(this.idRegistroEstadoAnimo);

  @override
  ConsumerState<_CompleteViewDetailsBody> createState() => _CompleteViewDetailsBodyState();
}

class _CompleteViewDetailsBodyState extends ConsumerState<_CompleteViewDetailsBody> {

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

    List<Emociones> gruposEmociones = [
      registroEstadoAnimo.grupoEmociones.grupo1,
      registroEstadoAnimo.grupoEmociones.grupo2,
      registroEstadoAnimo.grupoEmociones.grupo3,
      registroEstadoAnimo.grupoEmociones.grupo4,
      registroEstadoAnimo.grupoEmociones.grupo5,
      registroEstadoAnimo.grupoEmociones.grupo6,
      registroEstadoAnimo.grupoEmociones.grupo7,
      registroEstadoAnimo.grupoEmociones.grupo8,
      registroEstadoAnimo.grupoEmociones.grupo9,
      registroEstadoAnimo.grupoEmociones.grupo10,
    ];

    final Color primaryColor = Theme.of(context).colorScheme.primary;
    TextStyle titleStyle = Theme.of(context).textTheme.titleLarge!.copyWith(
      color: primaryColor,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );

    return Column(
      children: [
        _TitleAndInstruction(),
        _FechaYSuceso(DateHelper.formatearFecha(registroEstadoAnimo.fecha), registroEstadoAnimo.sucesoTrastornador),
        SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Emociones", style: titleStyle),
              ],
            ),
            SizedBox(height: 10),
            for(int i = 0; i < gruposEmociones.length; i++)
              CustomGrupoEmocionesCompleto(
                title: "Grupo ${i+1}", 
                grupoEmociones: gruposEmociones[i], 
              ),
          ],
        ),
        SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Pensamientos", style: titleStyle),
              ],
            ),
            SizedBox(height: 10),
            for(int i = 0; i < registroEstadoAnimo.listaPensamientos.length; i++)
              ListaPensamientosCompleto(
                title: "Pensamiento negativo ${i+1}", 
                pensamiento: registroEstadoAnimo.listaPensamientos[i], 
              ),
          ],
        ),
        SizedBox(height: 30),
        FilledButton.icon(
          icon: const Icon(Icons.edit),
          label: const Text('Editar registro de estado de ánimo'),
          onPressed: () {
            context.push("/registroEstadoAnimo/6/${widget.idRegistroEstadoAnimo}");
            return;
          }
        ),
        SizedBox(height: 10),
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
        SizedBox(height: 30)
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Registro de estado de ánimo', style: titleStyle),
          const SizedBox(height: 20),
          Text('Puede editar o eliminar este registro de estado de ánimo mediante los botones que se encuentran al final.',
            style: bodyStyle),
            SizedBox(height: 10),
        ],
      ),
    );
  }
}

class _FechaYSuceso extends StatelessWidget {

  final String suceso;
  final String fecha;

  const _FechaYSuceso(this.fecha, this.suceso);

  @override
  Widget build(BuildContext context) {

    final Color primaryColor = Theme.of(context).colorScheme.primary;
    TextStyle titleStyle = Theme.of(context).textTheme.titleLarge!.copyWith(
      color: primaryColor,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );

    TextStyle bodyStyle = Theme.of(context).textTheme.bodyMedium!.copyWith(
      fontSize: 16
    );

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                text: "Fecha del suceso: ", 
                style: titleStyle,
                children: [
                  TextSpan(
                    text: fecha,
                    style: bodyStyle
                  )
                ]
              )
            ),
            SizedBox(height: 10,),
            Text.rich(
              TextSpan(
                text: "Suceso trastornador: ", 
                style: titleStyle,
                children: [
                  TextSpan(
                    text: suceso,
                    style: bodyStyle
                  )
                ]
              )
            ),
          ],
        ),
      ),
    );
  }
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
                context.push("/registroEstadoAnimo/2");
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

  _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
