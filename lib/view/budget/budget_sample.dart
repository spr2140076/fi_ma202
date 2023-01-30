import 'package:flutter/material.dart';

class BudgetSample extends StatefulWidget {
  const BudgetSample({Key? key}) : super(key: key);
  @override
  State<BudgetSample> createState() => _BudgetSample();
}

class _BudgetSample extends State<BudgetSample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('予算', style: TextStyle(fontSize: 25),),
        centerTitle: true,
      ),
    );
  }
}