import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigation extends StatelessWidget {

  final int currentIndex;

  const CustomBottomNavigation({
    super.key,
    required this.currentIndex
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 1,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      currentIndex: currentIndex,
      onTap: (value) => context.push("/testBreveEstadoAnimo/$value"),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'Crear',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.assignment_outlined),
          label: 'Resultados',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart_outlined),
          label: 'Seguimiento',
        ),
      ],
    );
  }
}