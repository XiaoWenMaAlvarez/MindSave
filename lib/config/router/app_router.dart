import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mindsave/auth/presentation/screens/screens.dart';
import 'package:mindsave/config/router/app_router_notifier.dart';
import 'package:mindsave/test_breve_estado_animo/presentation/screens/screens.dart';
import 'package:mindsave/home/presentation/screens/screens.dart';
import 'package:mindsave/registro_estado_animo/presentation/screens/screens.dart';
import '../../auth/presentation/providers/auth_provider.dart';


List<String> noAuthRequiredPaths = [
  "/login",
  "/register",
  "/forgot-password",
];

bool isNotAuthRequired(String path) {
  if(noAuthRequiredPaths.contains(path)) return true;
  return false;
}

final goRouterProvider = Provider((ref) {

  final goRouterNotifier = ref.read(goRouterNotifierProvider);

  return GoRouter(
    initialLocation: "/splash",

    refreshListenable: goRouterNotifier,
    
    redirect: (BuildContext context, GoRouterState state) {
      final isGoingTo = state.matchedLocation;
      final AuthStatus authStatus = goRouterNotifier.authStatus;

      if(isGoingTo == "/splash" && authStatus == AuthStatus.checking) return null;

      if(authStatus == AuthStatus.notAuthenticated) {
        if(isNotAuthRequired(isGoingTo)) return null;
        return "/login";
      }

      if(authStatus == AuthStatus.authenticated) {
        if(isGoingTo == "/splash" || isNotAuthRequired(isGoingTo)) return "/home";
        return null;
      }

      return null;
    },
    routes: [

      GoRoute(
        path: "/splash",
        builder:(context, state) => const CheckAuthStatusScreen(),
      ),

      GoRoute(
        path: "/login",
        builder:(context, state) => const LoginScreen(),
      ),

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
});
