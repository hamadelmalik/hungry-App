import 'package:flutter/material.dart';
import 'package:hungry/features/auth/view/register_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'hungerApp',
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),

      home: RegisterView(),
    );
  }
}
