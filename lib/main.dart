import 'package:coupon/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';

// this is added 02

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ElevatedButton(
            onPressed: () => screenLock(
                context: context, correctString: '1234', canCancel: true),
            child: const Text('pin')),
      ),
    );
  }
}
