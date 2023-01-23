import 'package:fi_ma/home_screen.dart';
import 'package:fi_ma/view/deferred_payment/deferred_payment_list.dart';
import 'package:fi_ma/view/register/exin_list.dart';
import 'package:flutter/material.dart';
import 'footer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      // home: const MyHomePage(title: '', id: null,),
      routes: <String, WidgetBuilder>{
        '/': (_) => Footer(),
      },
      // home: Scaffold(
      //   bottomNavigationBar: Footer(),
      // ),
    );
  }
}
