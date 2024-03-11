import 'package:flutter/material.dart';
import 'package:pharmacy_hub/src/core/hepler.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('Hello World ',style: context.titleLarge,),
      ),
    );
  }
}
