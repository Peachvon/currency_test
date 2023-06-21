import 'package:currency_test/src/view/history_screen.dart';
import 'package:currency_test/src/view/home_screen.dart';
import 'package:go_router/go_router.dart';

// GoRouter configuration
final goRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/history',
      builder: (context, state) => const HistoryScreen(),
    ),
  ],
  debugLogDiagnostics: true,
);
