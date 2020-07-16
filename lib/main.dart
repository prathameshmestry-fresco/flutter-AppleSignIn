import 'package:appleSignIn_Demo/apple_signin_available.dart';
import 'package:appleSignIn_Demo/auth_service.dart';
import 'package:appleSignIn_Demo/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  // Fix for: Unhandled Exception: ServicesBinding.defaultBinaryMessenger was accessed before the binding was initialized.
  WidgetsFlutterBinding.ensureInitialized();
  final appleSignInAvailable = await AppleSignInAvailable.check();
  runApp(Provider<AppleSignInAvailable>.value(
    value: appleSignInAvailable,
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AuthService>(
      create: (_) => AuthService(),
      child: MaterialApp(
        title: 'Apple Sign In with Firebase',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: SignInPage(),
      ),
    );
  }
}
