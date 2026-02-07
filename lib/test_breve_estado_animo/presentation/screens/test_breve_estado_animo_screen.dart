import 'package:flutter/material.dart';
import 'package:mindsave/test_breve_estado_animo/presentation/views/views.dart';
import 'package:mindsave/test_breve_estado_animo/presentation/widgets/widgets.dart';
import 'package:mindsave/home/presentation/widgets/widgets.dart';

class TestBreveEstadoAnimoCreateScreen extends StatelessWidget {

  const TestBreveEstadoAnimoCreateScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      body: CreateView(),
      bottomNavigationBar: CustomBottomNavigation(currentIndex: 0),
      endDrawer: SideMenu(scaffoldKey: scaffoldKey),
    );
  }
}

class TestBreveEstadoAnimoDailyResultsScreen extends StatelessWidget {

  const TestBreveEstadoAnimoDailyResultsScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      body: DailyResultView(),
      bottomNavigationBar: CustomBottomNavigation(currentIndex: 1),
      endDrawer: SideMenu(scaffoldKey: scaffoldKey),
    );
  }
}


class TestBreveEstadoAnimoYearResultsScreen extends StatelessWidget {

  const TestBreveEstadoAnimoYearResultsScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      body: FollowUpView(),
      bottomNavigationBar: CustomBottomNavigation(currentIndex: 2),
      endDrawer: SideMenu(scaffoldKey: scaffoldKey),
    );
  }
}

class TestBreveEstadoAnimoDetailsYearResultsScreen extends StatelessWidget {

  const TestBreveEstadoAnimoDetailsYearResultsScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      body: DetailsFollowUpView(),
      bottomNavigationBar: CustomBottomNavigation(currentIndex: 2),
      endDrawer: SideMenu(scaffoldKey: scaffoldKey),
    );
  }
}

