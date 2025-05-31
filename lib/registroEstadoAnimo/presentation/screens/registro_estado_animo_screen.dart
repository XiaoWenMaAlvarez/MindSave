import 'package:flutter/material.dart';
import 'package:mindsave/home/presentation/widgets/widgets.dart';
import 'package:mindsave/registroEstadoAnimo/presentation/widgets/widgets.dart';
import 'package:mindsave/registroEstadoAnimo/presentation/views/views.dart';

class RegistroEstadoAnimoScreen extends StatelessWidget {
  final int pageIndex;

  const RegistroEstadoAnimoScreen({
    super.key,
    required this.pageIndex  
  });

  final List<Widget> viewRoutes = const [
    CreateView(),
    CreateView(),
    CreateView(),
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