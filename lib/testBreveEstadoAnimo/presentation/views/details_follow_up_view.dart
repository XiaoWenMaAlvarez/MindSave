import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mindsave/testBreveEstadoAnimo/domain/entities/entities.dart';
import 'package:mindsave/testBreveEstadoAnimo/presentation/providers/providers.dart';
import 'package:mindsave/home/presentation/widgets/widgets.dart';

class DetailsFollowUpView extends StatelessWidget {
  const DetailsFollowUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppbar(),
            centerTitle: true,
          ),
        ),

        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index){
              return _DetailsFollowViewBody();
            },
            childCount: 1,
          ),
        )
      ],
    );
  }
}

class _DetailsFollowViewBody extends ConsumerStatefulWidget {
  const _DetailsFollowViewBody();

  @override
  ConsumerState<_DetailsFollowViewBody> createState() => _DetailsFollowViewState();
}

class _DetailsFollowViewState extends ConsumerState<_DetailsFollowViewBody> {

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

    List<List<TestBreveEstadoDeAnimo>> testsBrevesPorAnio = [
      for(int i = 0; i < 12; i++)
      []
    ];

    for (TestBreveEstadoDeAnimo testBreveEstadoDeAnimo in testsBreveEstadoDeAnimo) {
      int month = testBreveEstadoDeAnimo.fechaCreacion.month - 1;
      testsBrevesPorAnio[month].add(testBreveEstadoDeAnimo);
    }

    Color primaryColor = Theme.of(context).colorScheme.primary;

    return Column(
      children: [
        TitleAndYearDetails(yearSelected: yearSelected, onChanged: (value) {
          setState(() {
            yearSelected = value!;
          });
          ref.read(selectedYearProvider.notifier).state = value!;
          ref.read(testBreveEstadoDeAnimoProvider.notifier).loadTestBreveEstadoDeAnimoByYear(yearSelected);
        }),
        Divider(),
        _MonthsList(primaryColor: primaryColor, yearSelected: yearSelected, testsBrevesPorAnio: testsBrevesPorAnio),
        SizedBox(height: 20)
      ],
    );
  }
}

class _MonthsList extends StatelessWidget {

  final Color primaryColor;
  final int yearSelected;

  final List<List<TestBreveEstadoDeAnimo>> testsBrevesPorAnio;

  final List<String> monthsNames = [
      'Enero',
      'Febrero',
      'Marzo',
      'Abril',
      'Mayo',
      'Junio',
      'Julio',
      'Agosto',
      'Septiembre',
      'Octubre',
      'Noviembre',
      'Diciembre',
    ];

  _MonthsList({
    required this.primaryColor,
    required this.yearSelected,
    required this.testsBrevesPorAnio
  });

  

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < monthsNames.length; i++)
        ...[
          ExpansionTile(
            title: Text(monthsNames[i]),
            children: [
              _DaysList(primaryColor: primaryColor, monthNumber: i+1, yearSelected: yearSelected, testsBrevesPorAnio: testsBrevesPorAnio),
            ],
          ),
          Divider()
        ]
      ],
    );
  }
}

class _DaysList extends StatelessWidget {

  final int monthNumber;
  final Color primaryColor;
  final int yearSelected;
  final List<List<TestBreveEstadoDeAnimo>> testsBrevesPorAnio;

  const _DaysList({
    required this.monthNumber,
    required this.primaryColor,
    required this.yearSelected,
    required this.testsBrevesPorAnio
  });

  @override
  Widget build(BuildContext context) {

    final String monthNumberText =  monthNumber < 10? "0$monthNumber" : "$monthNumber"; 

    List<TestBreveEstadoDeAnimo> testsBrevesPorMes = [];

    for (TestBreveEstadoDeAnimo testBreveEstadoDeAnimo in testsBrevesPorAnio[monthNumber-1]) {
      testsBrevesPorMes.add(testBreveEstadoDeAnimo);
    }

    if(testsBrevesPorMes.isEmpty) {
      return Column(
        children: [
          SizedBox(height: 10),
          Text("No se encontraron registros para este mes", style: TextStyle(color: primaryColor, fontSize: 16),),
          SizedBox(height: 20)
        ],
      );
    }

    return Column(
      children: [
        for(TestBreveEstadoDeAnimo testBreveEstadoDeAnimo in testsBrevesPorMes)
        ListTile(
          title: Text('Día ${testBreveEstadoDeAnimo.fechaCreacion.day}'),
          subtitle: Text("${testBreveEstadoDeAnimo.fechaCreacion.day}/$monthNumberText/$yearSelected"),
          leading: Icon(Icons.date_range_outlined, color: primaryColor),
          trailing: Icon(Icons.arrow_forward_ios_outlined, color: primaryColor),
          onTap: () => openDialog(context, testBreveEstadoDeAnimo),
        )
      ],
    );
  }
}

void openDialog(BuildContext context, TestBreveEstadoDeAnimo testBreveEstadoDeAnimo){

  final int monthNumber = testBreveEstadoDeAnimo.fechaCreacion.month;

  final String monthNumberText =  monthNumber < 10? "0$monthNumber" : "$monthNumber"; 

  final int dayNumber = testBreveEstadoDeAnimo.fechaCreacion.day;

  final String dayNumberText =  dayNumber < 10? "0$dayNumber" : "$dayNumber"; 

  final String fecha = "$dayNumberText/$monthNumberText/${testBreveEstadoDeAnimo.fechaCreacion.year}";

  showDialog(
    context: context, 
    builder: (context) => AlertDialog(
      title: Text("Fecha: $fecha"),
      content: SingleChildScrollView(child: Text(testBreveEstadoDeAnimo.toString())),
      actions: [
        TextButton(onPressed: context.pop, child: Text("Salir"))
      ],
    )
  );
}

class TitleAndYearDetails extends StatelessWidget {

  final int yearSelected;
  final Function(int?) onChanged;

  const TitleAndYearDetails({
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
          Text("Seguimiento en detalle de Tests Breve de Estado de Ánimo", style: titleStyle),
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