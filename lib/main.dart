import 'package:flutter/material.dart';
import 'package:flutter_development_task/screens/login_screen.dart';

import 'model/media_query.dar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ScreenSizeConfig.init(context); // Initialize once
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Development Task',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}
