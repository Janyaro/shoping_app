import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_project/Screen/home_screen.dart';
import 'package:shopping_project/cart_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.blue),
        home: HomeScreen(),
      ),
    );
  }
}
