import 'package:flutter/material.dart';
import 'package:pharmacy_hub/src/core/helper.dart';

class MyOrderScreen extends StatelessWidget {
  const MyOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Orders',
          style: context.titleSmall,
        ),
      ),
    );
  }
}
