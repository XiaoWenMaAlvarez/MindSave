import 'package:flutter/material.dart';
import 'package:mindsave/test_breve_estado_animo/presentation/views/views.dart';
import 'package:mindsave/test_breve_estado_animo/presentation/widgets/widgets.dart';
import 'package:mindsave/home/presentation/widgets/widgets.dart';

class TestBreveEstadoAnimoScreen extends StatelessWidget {
  final int pageIndex;

  const TestBreveEstadoAnimoScreen({
    super.key,
    required this.pageIndex
  });

  //TODO: PANTALLA DE CARGA Y PROVIDER DE CARGA
  final List<Widget> viewRoutes = const [
    CreateView(),
    DailyResultView(),
    FollowUpView(),
    DetailsFollowUpView()
  ];

  @override
  Widget build(BuildContext context) {

    final scaffoldKey = GlobalKey<ScaffoldState>();

    int currentIndex = pageIndex;

    if(pageIndex >= 3){
      currentIndex = 0;
      if(pageIndex == 3) currentIndex = 2;
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
