import 'package:flutter/material.dart';

class ErrorPageView extends StatelessWidget {
  const ErrorPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Error :Page Not Entry!'),
      ),
    );
  }
}
