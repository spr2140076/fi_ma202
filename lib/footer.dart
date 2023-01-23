import 'package:fi_ma/home_screen.dart';
import 'package:fi_ma/view/deferred_payment/deferred_payment_list.dart';
import 'package:fi_ma/view/register/exin_list.dart';
import 'package:flutter/material.dart';

class Footer extends StatefulWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  State<Footer> createState() => _Footer();
}

class _Footer extends State<Footer> {
  static const _screens = [
    HomeScreen(),
    ExpenseList(),
    DeferredPaymentList(),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'ホーム'),
            BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'カレンダー'),
            BottomNavigationBarItem(icon: Icon(Icons.attach_money), label: '後払い'),
          ],
          type: BottomNavigationBarType.fixed,
        ));
  }
}
