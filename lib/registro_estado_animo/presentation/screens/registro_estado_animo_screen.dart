import 'package:flutter/material.dart';
import 'package:mindsave/home/presentation/widgets/widgets.dart';
import 'package:mindsave/registro_estado_animo/presentation/widgets/widgets.dart';
import 'package:mindsave/registro_estado_animo/presentation/views/views.dart';

class RegistroEstadoAnimoScreen extends StatelessWidget {
  final int pageIndex;

  const RegistroEstadoAnimoScreen({
    super.key,
    required this.pageIndex  
  });

  final List<Widget> viewRoutes = const [
    CreateView(),
    //PendingView(),
    //CompleteView(),
  ];

  @override
  Widget build(BuildContext context) {

    final scaffoldKey = GlobalKey<ScaffoldState>();

    int currentIndex = pageIndex;

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