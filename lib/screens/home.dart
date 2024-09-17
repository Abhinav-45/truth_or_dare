import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _navigateTo(String route, BuildContext context) {
    context.go(route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50], // Light purple background
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton('Truth', '/home/truth', context),
              SizedBox(height: 16),
              _buildButton('Dare', '/home/dare', context),
              SizedBox(height: 16),
              _buildButton('Would you rather?', '/home/wyr', context),
              SizedBox(height: 16),
              _buildButton('Never have I ever?', '/home/nhie', context),
              SizedBox(height: 16),
              _buildButton('Paranoia Question', '/home/pq', context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(String text, String route, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ElevatedButton(
        onPressed: () => _navigateTo(route, context),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple[700], // Dark purple button
          foregroundColor: Colors.amber[100], // Light gold text
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
