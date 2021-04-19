import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/HomeView/providers/provider/cart_provider.dart';
import 'features/HomeView/view/home_view.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<CartProvider>(
          create: (context) => CartProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: HomeView(),
    );
  }
}
