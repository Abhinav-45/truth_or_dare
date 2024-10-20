import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../services/firebase_service.dart';

class HomeScreen extends StatelessWidget {
  final FirebaseAuthService authService;

  const HomeScreen({super.key, required this.authService});

  void _navigateTo(String route, BuildContext context) {
    context.go(route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.person, color: Colors.black),
          onPressed: () => context.go('/profile'),
        ),
        centerTitle: true,
        title: Text(
          'Truth or Dare',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
            onPressed: () async {
              await authService.signOut(context);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              Text(
                'Choose a Game',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              _buildButton('Truth', '/home/truth', context),
              const SizedBox(height: 16),
              _buildButton('Dare', '/home/dare', context),
              const SizedBox(height: 16),
              _buildButton('Would You Rather?', '/home/wyr', context),
              const SizedBox(height: 16),
              _buildButton('Never Have I Ever', '/home/nhie', context),
              const SizedBox(height: 16),
              _buildButton('Paranoia Question', '/home/pq', context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(String text, String route, BuildContext context) {
    return ElevatedButton(
      onPressed: () => _navigateTo(route, context),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 0,
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
