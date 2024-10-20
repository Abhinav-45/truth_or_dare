import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../services/firebase_service.dart';
import '../constants/constants.dart';
import '../screens/details/questions.dart';
import '../screens/home.dart';
import '../screens/login.dart';
import '../screens/profile.dart';
import '../screens/splash.dart';

class FadeTransitionPage extends CustomTransitionPage<void> {
  FadeTransitionPage({
    required LocalKey super.key,
    required super.child,
  }) : super(
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        );
}

class SlideTransitionPage extends CustomTransitionPage<void> {
  SlideTransitionPage({
    required LocalKey super.key,
    required super.child,
  }) : super(
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}

class Routing {
  static final FirebaseAuthService _authService = FirebaseAuthService();
  final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => FadeTransitionPage(
          key: state.pageKey,
          child: const SplashScreen(),
        ),
      ),
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) => FadeTransitionPage(
          key: state.pageKey,
          child: LoginScreen(authService: _authService),
        ),
      ),
      GoRoute(
        path: '/profile',
        pageBuilder: (context, state) => SlideTransitionPage(
          key: state.pageKey,
          child: ProfileScreen(authService: _authService),
        ),
      ),
      GoRoute(
        path: '/home',
        pageBuilder: (context, state) => FadeTransitionPage(
          key: state.pageKey,
          child: HomeScreen(authService: _authService),
        ),
        routes: [
          GoRoute(
            path: 'truth',
            pageBuilder: (context, state) => SlideTransitionPage(
              key: state.pageKey,
              child:
                  QuestionScreen(title: 'Truth', endpoint: Constants.getTruth),
            ),
          ),
          GoRoute(
            path: 'dare',
            pageBuilder: (context, state) => SlideTransitionPage(
              key: state.pageKey,
              child: QuestionScreen(title: 'Dare', endpoint: Constants.getDare),
            ),
          ),
          GoRoute(
            path: 'wyr',
            pageBuilder: (context, state) => SlideTransitionPage(
              key: state.pageKey,
              child: QuestionScreen(
                title: 'Would You Rather',
                endpoint: Constants.getWyr,
              ),
            ),
          ),
          GoRoute(
            path: 'nhie',
            pageBuilder: (context, state) => SlideTransitionPage(
              key: state.pageKey,
              child: QuestionScreen(
                title: 'Never Have I Ever',
                endpoint: Constants.getNhie,
              ),
            ),
          ),
          GoRoute(
            path: 'pq',
            pageBuilder: (context, state) => SlideTransitionPage(
              key: state.pageKey,
              child: QuestionScreen(
                title: 'Paranoia Question',
                endpoint: Constants.getParanoia,
              ),
            ),
          ),
          GoRoute(
            path: 'profile',
            pageBuilder: (context, state) => SlideTransitionPage(
              key: state.pageKey,
              child: ProfileScreen(authService: _authService),
            ),
          ),
        ],
      ),
    ],
    initialLocation: '/',
    redirect: (context, state) async {
      final isLoggedIn = await _authService.isUserLoggedIn();
      final isLoggingIn = state.matchedLocation == '/login';
      if (!isLoggedIn && !isLoggingIn) return '/login';
      if (isLoggedIn && isLoggingIn) return '/home';
      return null;
    },
  );
}
