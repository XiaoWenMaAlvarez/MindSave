import 'package:flutter/material.dart';
import 'package:mindsave/home/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      body: CustomScrollView(
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
                return _HomeScreenBody();
              },
              childCount: 1,
            ),
          )
        ],
      ),
      endDrawer: SideMenu(scaffoldKey: scaffoldKey),
    );
  }
}

class _HomeScreenBody extends StatelessWidget {
  const _HomeScreenBody();

  @override
  Widget build(BuildContext context) {
    return Text("Home screen");
  }
}