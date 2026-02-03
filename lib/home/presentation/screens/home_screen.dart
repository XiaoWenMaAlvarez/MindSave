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

    final Color primaryColor = Theme.of(context).colorScheme.primary;
    TextStyle titleStyle = Theme.of(context).textTheme.titleLarge!.copyWith(
      color: primaryColor,
      fontSize: 30,
      fontWeight: FontWeight.bold,
    );

    TextStyle bodyStyle = Theme.of(context).textTheme.bodyMedium!.copyWith(
      fontSize: 20,
      fontWeight: FontWeight.bold
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        children: [
          SizedBox(height: 20),
          Text('Bienvenido a Mindsave', style: titleStyle),
          SizedBox(height: 30),
          Image.asset("assets/img/icon.png"),
          SizedBox(height: 30),
          Text(
            'Una aplicación que le ayuda en caso de padecer de timidez, preocupación crónica, ataques de pánico, fobias, ansiedad por miedo a hablar en público, ansiedad por los exámenes, trastorno por estrés postraumático o trastorno obsesivo-compulsivo.', 
            style: bodyStyle,
            textAlign: TextAlign.center,),
        ],
      ),
    );
  }
}