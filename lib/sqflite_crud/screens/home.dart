import 'package:flutter/material.dart';

class SqfLiteHome extends StatelessWidget {
  const SqfLiteHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {},
            child: const Text('Create'),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Fetch'),
          ),
        ],
      ),
    );
  }
}
