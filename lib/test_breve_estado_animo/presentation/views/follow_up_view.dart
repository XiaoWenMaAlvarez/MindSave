import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mindsave/test_breve_estado_animo/domain/entities/entities.dart';
import 'package:mindsave/test_breve_estado_animo/presentation/providers/providers.dart';
import 'package:mindsave/test_breve_estado_animo/presentation/widgets/widgets.dart';
import 'package:mindsave/home/presentation/widgets/widgets.dart';

class FollowUpView extends StatelessWidget {
  const FollowUpView({super.key});

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
              return _FollowUpViewBody();
            },
            childCount: 1,
          ),
        )
      ],
    );
  }
}

class _FollowUpViewBody extends ConsumerStatefulWidget {
  const _FollowUpViewBody();

  @override
  ConsumerState<_FollowUpViewBody> createState() => _FollowUpViewState();
}

class _FollowUpViewState extends ConsumerState<_FollowUpViewBody> {

  int yearSelected = DateTime.now().year;

  @override
  void initState() {
    ref.read(testBreveEstadoDeAnimoProvider.notifier).loadTestBreveEstadoDeAnimoByYear(yearSelected);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    yearSelected = ref.watch(selectedYearProvider);

    List<TestBreveEstadoDeAnimo> testsBreveEstadoDeAnimo = ref.watch(testBreveEstadoDeAnimoProvider);

    TextStyle bodyStyle = Theme.of(context).textTheme.bodyLarge!.copyWith(
      fontSize: 16,
    );

    Color primaryColor = Theme.of(context).colorScheme.primary;

    return Column(
      children: [
        TitleAndYear(yearSelected: yearSelected, onChanged: (value) {
          setState(() {
            yearSelected = value!;
          });
          ref.read(selectedYearProvider.notifier).state = value!;
          ref.read(testBreveEstadoDeAnimoProvider.notifier).loadTestBreveEstadoDeAnimoByYear(yearSelected);
        }),
        SizedBox(height: 20),
        _HistogramaAnsiedadEmocional(testsBreveEstadoDeAnimo),
        Divider(),
        _HistogramaAnsiedadFisica(testsBreveEstadoDeAnimo),
        Divider(),
        _HistogramaDepresion(testsBreveEstadoDeAnimo),
        Divider(),
        _HistogramaImpulsosSuicidas(testsBreveEstadoDeAnimo),
        Divider(),
        SizedBox(height: 10),
        Text("Nota: Para ver los resultados en detalle", style: bodyStyle),
        TextButton(
          child: Text("Haga click aquí", style: bodyStyle.copyWith(color: primaryColor)),
          onPressed: () => context.push("/testBreveEstadoAnimo/3"), 
        )
      ],
    );
  }
}

class TitleAndYear extends StatelessWidget {

  final int yearSelected;
  final Function(int?) onChanged;

  const TitleAndYear({
    super.key,
    required this.yearSelected,
    required this.onChanged
  });

  @override
  Widget build(BuildContext context) {

    final Color primaryColor = Theme.of(context).colorScheme.primary;
    TextStyle titleStyle = Theme.of(context).textTheme.titleLarge!.copyWith(
      color: primaryColor,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );

    TextStyle boldBodyStyle = Theme.of(context).textTheme.bodyLarge!.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          Text("Seguimiento de Tests Breve de Estado de Ánimo", style: titleStyle),
          SizedBox(height: 20),
          ExpansionTile(
            title: Text("Año seleccionado", style: boldBodyStyle),
            subtitle: Text("$yearSelected"),
            children: [
              for (int i = 2024; i <= DateTime.now().year; i++)
                RadioListTile(
                  title: Text('$i'),
                  value: i, 
                  groupValue: yearSelected, 
                  onChanged: onChanged
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HistogramaAnsiedadEmocional extends StatelessWidget {
  final List<TestBreveEstadoDeAnimo> testsBreveEstadoDeAnimo;

  const _HistogramaAnsiedadEmocional(this.testsBreveEstadoDeAnimo);

  @override
  Widget build(BuildContext context) {

    List<List<int?>> scoreAnsiedadEmocionalPorAnio = [
      for(int i = 0; i < 12; i++)
      [for(int i = 0; i < 31; i++)null]
    ];

    for (TestBreveEstadoDeAnimo testBreveEstadoDeAnimo in testsBreveEstadoDeAnimo) {
      int month = testBreveEstadoDeAnimo.fechaCreacion.month - 1;
      int day = testBreveEstadoDeAnimo.fechaCreacion.day - 1;
      scoreAnsiedadEmocionalPorAnio[month][day] = testBreveEstadoDeAnimo.sentimientosAnsiedadEmocionalTestBreve.totalScore;
    }

    int minScore = SentimientosAnsiedadEmocionalTestBreve.scoreMin;
    int maxScore = SentimientosAnsiedadEmocionalTestBreve.scoreMax;

    String title = "Sentimientos de ansiedad emocional";

    return CustomHistogram(
      title: title,
      minValue: minScore,
      maxValue: maxScore,
      horizontalInterval: 5,
      data: scoreAnsiedadEmocionalPorAnio,
    );
  }
}


class _HistogramaAnsiedadFisica extends StatelessWidget {
  final List<TestBreveEstadoDeAnimo> testsBreveEstadoDeAnimo;

  const _HistogramaAnsiedadFisica(this.testsBreveEstadoDeAnimo);

  @override
  Widget build(BuildContext context) {

    List<List<int?>> scoreAnsiedadFisicaPorAnio = [
      for(int i = 0; i < 12; i++)
      [for(int i = 0; i < 31; i++)null]
    ];

    for (TestBreveEstadoDeAnimo testBreveEstadoDeAnimo in testsBreveEstadoDeAnimo) {
      int month = testBreveEstadoDeAnimo.fechaCreacion.month - 1;
      int day = testBreveEstadoDeAnimo.fechaCreacion.day - 1;
      scoreAnsiedadFisicaPorAnio[month][day] = testBreveEstadoDeAnimo.sentimientosAnsiedadFisicaTestBreve.totalScore;
    }

    int minScore = SentimientosAnsiedadFisicaTestBreve.scoreMin;
    int maxScore = SentimientosAnsiedadFisicaTestBreve.scoreMax;

    String title = "Sentimientos de ansiedad física";

    return CustomHistogram(
      title: title,
      minValue: minScore,
      maxValue: maxScore,
      horizontalInterval: 10,
      data: scoreAnsiedadFisicaPorAnio,
    );
  }
}

class _HistogramaDepresion extends StatelessWidget {
  final List<TestBreveEstadoDeAnimo> testsBreveEstadoDeAnimo;

  const _HistogramaDepresion(this.testsBreveEstadoDeAnimo);

  @override
  Widget build(BuildContext context) {

    List<List<int?>> scoreDepresionPorAnio = [
      for(int i = 0; i < 12; i++)
      [for(int i = 0; i < 31; i++)null]
    ];

    for (TestBreveEstadoDeAnimo testBreveEstadoDeAnimo in testsBreveEstadoDeAnimo) {
      int month = testBreveEstadoDeAnimo.fechaCreacion.month - 1;
      int day = testBreveEstadoDeAnimo.fechaCreacion.day - 1;
      scoreDepresionPorAnio[month][day] = testBreveEstadoDeAnimo.depresionTestBreve.totalScore;
    }

    int minScore = DepresionTestBreve.scoreMin;
    int maxScore = DepresionTestBreve.scoreMax;

    String title = "Depresión";

    return CustomHistogram(
      title: title,
      minValue: minScore,
      maxValue: maxScore,
      horizontalInterval: 5,
      data: scoreDepresionPorAnio,
    );
  }
}

class _HistogramaImpulsosSuicidas extends StatelessWidget {
  final List<TestBreveEstadoDeAnimo> testsBreveEstadoDeAnimo;

  const _HistogramaImpulsosSuicidas(this.testsBreveEstadoDeAnimo);

  @override
  Widget build(BuildContext context) {

    List<List<int?>> scoreImpulsosSuicidasPorAnio = [
      for(int i = 0; i < 12; i++)
      [for(int i = 0; i < 31; i++)null]
    ];

    for (TestBreveEstadoDeAnimo testBreveEstadoDeAnimo in testsBreveEstadoDeAnimo) {
      int month = testBreveEstadoDeAnimo.fechaCreacion.month - 1;
      int day = testBreveEstadoDeAnimo.fechaCreacion.day - 1;
      scoreImpulsosSuicidasPorAnio[month][day] = testBreveEstadoDeAnimo.impulsoSuicidaTestBreve.totalScore;
    }

    int minScore = ImpulsoSuicidaTestBreve.scoreMin;
    int maxScore = ImpulsoSuicidaTestBreve.scoreMax;

    String title = "Impulsos suicidas";

    return CustomHistogram(
      title: title,
      minValue: minScore,
      maxValue: maxScore,
      horizontalInterval: 2,
      data: scoreImpulsosSuicidasPorAnio,
    );
  }
}