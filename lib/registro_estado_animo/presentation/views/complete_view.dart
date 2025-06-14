import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mindsave/home/presentation/widgets/widgets.dart';
import 'package:mindsave/registro_estado_animo/domain/entities/entities.dart';
import 'package:mindsave/config/helpers/date_helper.dart';
import 'package:mindsave/registro_estado_animo/presentation/providers/providers.dart';

class CompleteView extends StatelessWidget {
  const CompleteView({super.key});

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
              return _CompleteViewBody();
            },
            childCount: 1,
          ),
        )
      ],
    );
  }
}


class _CompleteViewBody extends ConsumerStatefulWidget {
  const _CompleteViewBody();

  @override
  ConsumerState<_CompleteViewBody> createState() => _CompleteViewBodyState();
}

class _CompleteViewBodyState extends ConsumerState<_CompleteViewBody> {

  @override
  void initState(){
    WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(registroEstadoDeAnimoProvider.notifier).cargarRegistrosEstadoDeAnimoByPage();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    List<RegistroEstadoAnimo> listaRegistroEstadoAnimo = ref.watch(registroEstadoDeAnimoProvider);
    List<RegistroEstadoAnimo> listaRegistroEstadoAnimoPendientes = listaRegistroEstadoAnimo.where((RegistroEstadoAnimo r) => !r.isPending).toList();

    Color primaryColor = Theme.of(context).colorScheme.primary;

    TextStyle textStyle = Theme.of(context).textTheme.titleLarge!.copyWith(
      color: primaryColor
    );

    if(listaRegistroEstadoAnimoPendientes.isEmpty){
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 100),
            Icon(Icons.error_outline, color: primaryColor, size: 250,),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text("No se encontraron registros de estado de ánimo completados", style: textStyle, textAlign: TextAlign.center,),
            )
          ],
        ),
      );
    }

    return Column(
      children: [
        _TitleAndInstruction(),
        _PendingViewList(listaRegistroEstadoAnimoPendientes)
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
          Text('Registro de Estado de Ánimo Completados', style: titleStyle),
          const SizedBox(height: 10),
          Text('Los registros de estado de ánimo completados aún pueden ser editados o eliminados.',
            style: bodyStyle),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _PendingViewList extends StatelessWidget {

  final List<RegistroEstadoAnimo> listaRegistroEstadoAnimoPendientes;

  const _PendingViewList(this.listaRegistroEstadoAnimoPendientes);

  @override
  Widget build(BuildContext context) {

    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        for(int i = 0; i < listaRegistroEstadoAnimoPendientes.length; i ++)
        ListTile(
          title: Text(DateHelper.formatearFecha(listaRegistroEstadoAnimoPendientes[i].fecha)),
          subtitle: Text(listaRegistroEstadoAnimoPendientes[i].sucesoTrastornador.length > 50 
            ? "${listaRegistroEstadoAnimoPendientes[i].sucesoTrastornador.substring(0, 30)}..."
            : listaRegistroEstadoAnimoPendientes[i].sucesoTrastornador),
          leading: Icon(Icons.assignment_outlined, color: colorScheme.primary),
          trailing: Icon(Icons.arrow_forward_ios_outlined, color: colorScheme.primary),
          onTap: () => context.push("/registroEstadoAnimo/7/${listaRegistroEstadoAnimoPendientes[i].id}"),
        )
      ],
    );
  }
}