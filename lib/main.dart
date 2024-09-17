import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:truth_or_dare/screens/details/dare.dart';
import 'package:truth_or_dare/screens/details/never_have_i_ever.dart';
import 'package:truth_or_dare/screens/details/paranoia_question.dart';
import 'package:truth_or_dare/screens/details/truth.dart';
import 'package:truth_or_dare/screens/details/would_you_rather.dart';
import 'package:truth_or_dare/screens/home.dart';
import 'package:truth_or_dare/screens/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GoRouter _router = GoRouter(routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
            path: 'truth',
            builder: (context, state) => TruthScreen(),
          ),
          GoRoute(
            path: 'dare',
            builder: (context, state) => const DareScreen(),
          ),
          GoRoute(
            path: 'wyr',
            builder: (context, state) => const WouldYouRatherScreen(),
          ),
          GoRoute(
            path: 'nhie',
            builder: (context, state) => const NeverHaveIEverScreen(),
          ),
          GoRoute(
            path: 'pq',
            builder: (context, state) => const ParanoiaQuestionScreen(),
          ),
        ]),
  ], initialLocation: '/splash');

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: _router);
  }
}
