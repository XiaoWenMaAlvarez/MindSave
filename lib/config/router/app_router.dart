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
      path: "/testBreveEstadoAnimo/0",
      builder: (context, state) {
        return TestBreveEstadoAnimoCreateScreen();
      }
    ),

    GoRoute(
      path: "/testBreveEstadoAnimo/1",
      builder: (context, state) {
        return TestBreveEstadoAnimoDailyResultsScreen();
      }
    ),

    GoRoute(
      path: "/testBreveEstadoAnimo/2",
      builder: (context, state) {
        return TestBreveEstadoAnimoYearResultsScreen();
      }
    ),

    GoRoute(
      path: "/testBreveEstadoAnimo/3",
      builder: (context, state) {
        return TestBreveEstadoAnimoDetailsYearResultsScreen();
      }
    ),

    GoRoute(
      path: "/registroEstadoAnimo/:page",
      builder: (context, state) {
        final pageIndex = int.parse(state.pathParameters['page'] ?? "0");
        return RegistroEstadoAnimoScreen(pageIndex: pageIndex, registerIndex: 0);
      }
    ),

    GoRoute(
      path: "/registroEstadoAnimo/:page/:idRegistro",
      builder: (context, state) {
        final pageIndex = int.parse(state.pathParameters['page'] ?? "0");
        final registerIndex = int.parse(state.pathParameters['idRegistro'] ?? "0");
        return RegistroEstadoAnimoScreen(pageIndex: pageIndex, registerIndex: registerIndex);
      }
    ),
    
  ]

);
