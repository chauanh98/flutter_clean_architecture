import 'package:flutter/material.dart';
import 'features/attraction/presentation/pages/attraction_page.dart';
import 'injection_container.dart' as di;

void main() async {
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AttractionPage(),
    );
  }
}

