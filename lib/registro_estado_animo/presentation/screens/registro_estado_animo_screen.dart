import 'package:flutter/material.dart';
import 'package:mindsave/home/presentation/widgets/widgets.dart';
import 'package:mindsave/registro_estado_animo/presentation/widgets/widgets.dart';
import 'package:mindsave/registro_estado_animo/presentation/views/views.dart';

class RegistroEstadoAnimoScreen extends StatelessWidget {
  final int pageIndex;
  final int registerIndex;

  const RegistroEstadoAnimoScreen({
    super.key,
    required this.pageIndex,
    required this.registerIndex
  });

  @override
  Widget build(BuildContext context) {

    final List<Widget> viewRoutes = [
      CreateView(),
      PendingView(),
      CompleteView(),
      PendingViewStep4(idRegistroEstadoAnimo: registerIndex),
      PendingViewStep5(idRegistroEstadoAnimo: registerIndex),
      PendingViewStep6(idRegistroEstadoAnimo: registerIndex),
      PendingViewSteps1To3(idRegistroEstadoAnimo: registerIndex),
      CompleteViewDetails(idRegistroEstadoAnimo: registerIndex),
    ];

    final scaffoldKey = GlobalKey<ScaffoldState>();
    int currentIndex = pageIndex;

    if(pageIndex > 2) {
      if(pageIndex == 3 || pageIndex == 4 || pageIndex == 5 || pageIndex == 6) currentIndex = 1;
      if(pageIndex == 7) currentIndex = 2;
    }

    return Scaffold(
      key: scaffoldKey,
      body: IndexedStack(
        index: pageIndex,
        children: viewRoutes,
      ),
      bottomNavigationBar: CustomBottomNavigation(currentIndex: currentIndex),
      endDrawer: SideMenu(scaffoldKey: scaffoldKey),
    );
  }
}