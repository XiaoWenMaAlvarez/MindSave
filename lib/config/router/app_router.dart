import 'package:go_router/go_router.dart';
import 'package:mindsave/test_breve_estado_animo/presentation/screens/screens.dart';
import 'package:mindsave/home/presentation/screens/screens.dart';
import 'package:mindsave/registro_estado_animo/presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: "/home",
  routes: [

    GoRoute(
      path: "/home",
      builder:(context, state) => const HomeScreen(),
    ),

    GoRoute(
      path: "/testBreveEstadoAnimo/:page",
      builder: (context, state) {
        final pageIndex = int.parse(state.pathParameters['page'] ?? "0");
        return TestBreveEstadoAnimoScreen(pageIndex: pageIndex);
      }
    ),

    GoRoute(
      path: "/registroEstadoAnimo/:page",
      builder: (context, state) {
        final pageIndex = int.parse(state.pathParameters['page'] ?? "0");
        return RegistroEstadoAnimoScreen(pageIndex: pageIndex);
      }
    ),
    
  ]

);
