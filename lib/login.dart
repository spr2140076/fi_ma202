import 'package:fi_ma/footer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'main.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final googleProvider = ref.watch(googlSignInProvider);

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.orange[50],
        appBar: AppBar(
          title: const Text('Fi-MA', style: TextStyle(fontSize: 30, color: Colors.black),),
          centerTitle: true,
          backgroundColor: Colors.orange,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 300,
                height: 80,
                child: SignInButton(
                  Buttons.Google,
                  onPressed: () async {
                    await googleProvider.googleLogin();
                    if (googleProvider.auth.currentUser != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Footer(),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}