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
      onTap: (value) => context.go("/registroEstadoAnimo/$value"),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.create),
          label: 'Crear',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.pending_actions),
          label: 'Pendientes',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.health_and_safety_outlined),
          label: 'Completados',
        ),
      ],
    );
  }
}