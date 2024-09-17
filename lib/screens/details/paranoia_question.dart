import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ParanoiaQuestionScreen extends StatelessWidget {
  const ParanoiaQuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Go for truth!'),
        backgroundColor: Colors.purple[50],
        centerTitle: true,
        leading: IconButton(
            onPressed: () => context.pop(context), icon: Icon(Icons.arrow_back_ios)),
      ),
      backgroundColor: Colors.purple[50],
    );
  }
}