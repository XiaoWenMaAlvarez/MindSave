import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mindsave/home/presentation/widgets/widgets.dart';
import 'package:mindsave/registro_estado_animo/domain/entities/entities.dart';
import 'package:mindsave/config/helpers/date_helper.dart';
import 'package:mindsave/registro_estado_animo/presentation/providers/providers.dart';
import 'package:mindsave/registro_estado_animo/presentation/widgets/widgets.dart';

class PendingViewStep4 extends StatelessWidget {
  final int idRegistroEstadoAnimo;

  const PendingViewStep4({required this.idRegistroEstadoAnimo ,super.key});

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
              return _PendingViewStep4Body(idRegistroEstadoAnimo);
            },
            childCount: 1,
          ),
        )
      ],
    );
  }
}


class _PendingViewStep4Body extends ConsumerStatefulWidget {
  final int idRegistroEstadoAnimo;

  const _PendingViewStep4Body(this.idRegistroEstadoAnimo);

  @override
  ConsumerState<_PendingViewStep4Body> createState() => _PendingViewStep4BodyState();
}

class _PendingViewStep4BodyState extends ConsumerState<_PendingViewStep4Body> {

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

    return Column(
      children: [
        _TitleAndInstruction(),
        _FechaYSuceso(DateHelper.formatearFecha(registroEstadoAnimo.fecha), registroEstadoAnimo.sucesoTrastornador),
        SizedBox(height: 20,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for(int i = 0; i < registroEstadoAnimo.listaPensamientos.length; i++)
              CustomCheckBoxGroupDistorsiones(
                title: "Pensamiento negativo ${i+1}", 
                pensamiento: registroEstadoAnimo.listaPensamientos[i], 
              ),
          ],
        ),
        SizedBox(height: 30),
        OutlinedButton.icon(
          icon: const Icon(Icons.arrow_back),
          label: const Text('Volver al paso anterior'),
          onPressed: () async {
            await _preguntarSiDeseaGuardarCambio(context, registroEstadoAnimo, ref);
            if(context.mounted) context.push("/registroEstadoAnimo/6/${widget.idRegistroEstadoAnimo}");
            return;
          }
        ),
        SizedBox(height: 10),
        FilledButton.icon(
          icon: const Icon(Icons.arrow_forward),
          iconAlignment: IconAlignment.end,
          label: const Text('Avanzar al siguiente paso'),
          onPressed: () async {
            await ref.read(registroEstadoDeAnimoProvider.notifier).editarRegistroEstadoDeAnimo(registroEstadoAnimo);
            if(context.mounted) context.push("/registroEstadoAnimo/4/${widget.idRegistroEstadoAnimo}");
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
          Text('Identificación de distorsiones cognitivas', style: titleStyle),
          const SizedBox(height: 20),
          Text('identifique las distorsiones de cada pensamiento negativo, utilizando la lista de comprobación de distorsiones cognitivas que aparece a continuación:',
            style: bodyStyle),
            SizedBox(height: 10),
            _ListaDistorsionesCognitivas(),
            Text('Identifique dichas distorsiones en sus pensamientos negativos', style: titleStyle),
            SizedBox(height: 20)
        ],
      ),
    );
  }
}

class _ListaDistorsionesCognitivas extends StatelessWidget {
  const _ListaDistorsionesCognitivas();

  @override
  Widget build(BuildContext context) {

    List<String> distorsiones = Pensamiento.listaDistorsiones;
    List<String> detallesDistorsiones = Pensamiento.detalleListaDistorsiones;

    final Color primaryColor = Theme.of(context).colorScheme.primary;
    TextStyle titleStyle = Theme.of(context).textTheme.titleLarge!.copyWith(
      color: primaryColor,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );

    TextStyle bodyStyle = Theme.of(context).textTheme.bodyMedium!.copyWith(
      fontSize: 16
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for(int i = 0; i < distorsiones.length; i ++)
        ...[
          Text.rich(
            TextSpan(
              text: "${i+1}. ${distorsiones[i]}: ", 
              style: titleStyle,
              children: [
                TextSpan(
                  text: detallesDistorsiones[i],
                  style: bodyStyle
                )
              ]
            )
          ),
          SizedBox(height: 5)
        ],
        SizedBox(height: 20)
      ],
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

Future<void> _preguntarSiDeseaGuardarCambio(BuildContext context, RegistroEstadoAnimo registroEstadoAnimo, WidgetRef ref) async {
    await showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: const Text('¿Desea guardar los progresos?'),
        content: Text('Antes de regresar al paso anterior ¿quiere guardar o descartar los avances realizados?'),
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

  _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }