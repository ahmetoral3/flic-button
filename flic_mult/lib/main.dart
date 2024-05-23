import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:flic_button/flic_button.dart';

import 'ButtonState.dart';
import 'SecondPage.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ButtonState(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final buttonState = Provider.of<ButtonState>(context);
    //hhdh
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondPage()),
                );
              },
              child: const Text('Go to Second Page'),
            ),
            const SizedBox(height: 20),
            Text(
              'Button Press Count: ${buttonState.no}',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}