import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mindsave/test_breve_estado_animo/domain/entities/entities.dart';
import 'package:mindsave/test_breve_estado_animo/presentation/providers/providers.dart';
import 'package:mindsave/home/presentation/widgets/widgets.dart';
import 'package:mindsave/test_breve_estado_animo/presentation/widgets/widgets.dart';


class TestBreveEstadoAnimoDailyResultsScreen extends StatelessWidget {

  const TestBreveEstadoAnimoDailyResultsScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      body: _DailyResultView(),
      bottomNavigationBar: CustomBottomNavigation(currentIndex: 1),
      endDrawer: SideMenu(scaffoldKey: scaffoldKey),
    );
  }
}

class _DailyResultView extends StatelessWidget {
  const _DailyResultView();

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
              return _ResultViewBody();
            },
            childCount: 1,
          ),
        )
      ],
    );
  }
}

class _ResultViewBody extends ConsumerStatefulWidget {
  const _ResultViewBody();

  @override
  ConsumerState<_ResultViewBody> createState() => _ResultViewBodyState();
}

class _ResultViewBodyState extends ConsumerState<_ResultViewBody> {
  
  late bool isTestBreveRealizadoHoy;

  @override
  Widget build(BuildContext context) {
    
    bool isLoading = ref.watch(isLoadingProvider);
    if(isLoading) return const Center(child: CircularProgressIndicator());

    isTestBreveRealizadoHoy = ref.watch(todayTestBreveEstadoDeAnimoProvider) != null;

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

    TextStyle bodyStyle = Theme.of(context).textTheme.bodyMedium!.copyWith(
      fontSize: 16,
    );

    if(!isTestBreveRealizadoHoy){
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("No hay resultados para hoy", style: titleStyle),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () => context.go("/testBreveEstadoAnimo/0"), 
              child: const Text("Crear registro")
            )
          ]
        ),
      );
    }

    TestBreveEstadoDeAnimo testBreveEstadoDeAnimoHoy = ref.watch(todayTestBreveEstadoDeAnimoProvider)!;
    final int month = testBreveEstadoDeAnimoHoy.fechaCreacion.month;
    final String monthNumberText =  month < 10? "0$month" : "$month";

    final int day = testBreveEstadoDeAnimoHoy.fechaCreacion.day;
    final String dayNumberText =  day < 10? "0$day" : "$day";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Resultados del Test Breve Estado de Ánimo', style: titleStyle),
          const SizedBox(height: 20),
          Text('Fecha de hoy: $dayNumberText/$monthNumberText/${testBreveEstadoDeAnimoHoy.fechaCreacion.year}', style: boldBodyStyle),
          const SizedBox(height: 10),
          Divider(),

          _ItemTestBreveResults(
            title: "Clave de puntuación: Test de sentimientos de ansiedad emocional",
            score: testBreveEstadoDeAnimoHoy.sentimientosAnsiedadEmocionalTestBreve.totalScore,
            resultDescription: testBreveEstadoDeAnimoHoy.sentimientosAnsiedadEmocionalTestBreve.resultDescription,
          ),

          _ItemTestBreveResults(
            title: "Clave de puntuación: Test de síntomas físicos de ansiedad",
            score: testBreveEstadoDeAnimoHoy.sentimientosAnsiedadFisicaTestBreve.totalScore,
            resultDescription: testBreveEstadoDeAnimoHoy.sentimientosAnsiedadFisicaTestBreve.resultDescription,
          ),

          _ItemTestBreveResults(
            title: "Clave de puntuación: Test de depresión",
            score: testBreveEstadoDeAnimoHoy.depresionTestBreve.totalScore,
            resultDescription: testBreveEstadoDeAnimoHoy.depresionTestBreve.resultDescription,
          ),

          _ItemTestBreveResults(
            title: "Clave de puntuación: Test de impulsos suicidas",
            score: testBreveEstadoDeAnimoHoy.impulsoSuicidaTestBreve.totalScore,
            resultDescription: testBreveEstadoDeAnimoHoy.impulsoSuicidaTestBreve.resultDescription,
          ),

          Text("Recuerde: No es posible sentirse feliz todo el tiempo. La vida puede traer tensiones y todos caemos de vez en cuando en agujeros negros de duda y preocupación. Lo importante es que usted sepa que cuenta con las herramientas necesarias para resolver los cambios dolorosos de estado de ánimo, de modo que no tiene por qué temerlos ni quedarse atrapado en ellos.",
          style: bodyStyle),
          const SizedBox(height: 20),

          Align(
            alignment: Alignment.center,
            child: FilledButton(
              onPressed: () => context.go("/testBreveEstadoAnimo/2"), 
              child: const Text("Visualizar seguimiento")
            ),
          ),

          const SizedBox(height: 20),
        
        ],
      ),
    );
  }
}


class _ItemTestBreveResults extends StatelessWidget {

  final String title;
  final int score;
  final String resultDescription;
  
  const _ItemTestBreveResults({
    required this.title,
    required this.score,
    required this.resultDescription,
  });

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

    return Column(
      children: [
        const SizedBox(height: 20),
        Text( title, style: titleStyle),
        const SizedBox(height: 20),
        Align(
          alignment: Alignment.centerLeft,
          child: Text( "Total de hoy: $score", style: boldBodyStyle),),
        const SizedBox(height: 10),
        Text( "Total de hoy: $resultDescription", style: bodyStyle),
        const SizedBox(height: 10),
        const Divider()
      ],
    );
  }
}