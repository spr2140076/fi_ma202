import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'footer.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class googlSignInNotifier extends ChangeNotifier {
  final _googleSignIn = GoogleSignIn();
  final _auth = FirebaseAuth.instance;

  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;
  FirebaseAuth get auth => _auth;

  Future googleLogin() async {
    try {
      final googleUser = await _googleSignIn.signIn();

      if (googleUser == null) return;
      _user = googleUser;

      final GoogleSignInAuthentication googlAuth =
      await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googlAuth.accessToken,
        idToken: googlAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
      notifyListeners();
    } catch (e) {
      print('Error: $e');
    }
  }

  Future logout() async {
    await _googleSignIn.signOut();
    FirebaseAuth.instance.signOut();
  }
}

final googlSignInProvider = ChangeNotifierProvider((ref) {
  return googlSignInNotifier();
});

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(ProviderScope(child: MyApp()));
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.orange,
//       ),
//       localizationsDelegates: [
//         GlobalMaterialLocalizations.delegate,
//         GlobalWidgetsLocalizations.delegate,
//       ],
//       routes: <String, WidgetBuilder>{
//         '/': (_) => Footer(),
//       },
//     );
//   }
// }
