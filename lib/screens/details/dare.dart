import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DareScreen extends StatelessWidget {
  const DareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Go for truth!'),
        centerTitle: true,
        backgroundColor: Colors.purple[50],
        leading: IconButton(
            onPressed: () => context.pop(context),
            icon: Icon(Icons.arrow_back_ios)),
      ),
      backgroundColor: Colors.purple[50],
    );
  }
}
