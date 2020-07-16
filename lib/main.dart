import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class AppleSignInAvailable {
  AppleSignInAvailable(this.isAvailable);
  final bool isAvailable;

  static Future<AppleSignInAvailable> check() async {
    return AppleSignInAvailable(await AppleSignIn.isAvailable());
  }
}

class _MyAppState extends State<MyApp> {
  Future<void> initiateSignInWithApple() async {
    try {
      final AuthorizationResult result = await AppleSignIn.performRequests([
        AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
      ]);

      switch (result.status) {
        case AuthorizationStatus.authorized:
          try {
            print("successfull sign in");
            final AppleIdCredential appleIdCredential = result.credential;

            OAuthProvider oAuthProvider =
                new OAuthProvider(providerId: "apple.com");
            final AuthCredential credential = oAuthProvider.getCredential(
              idToken: String.fromCharCodes(appleIdCredential.identityToken),
              accessToken:
                  String.fromCharCodes(appleIdCredential.authorizationCode),
            );

            final AuthResult _res =
                await FirebaseAuth.instance.signInWithCredential(credential);

            FirebaseAuth.instance.currentUser().then((val) async {
              UserUpdateInfo updateUser = UserUpdateInfo();
              updateUser.displayName =
                  "${appleIdCredential.fullName.givenName} ${appleIdCredential.fullName.familyName}";
              updateUser.photoUrl = "define an url";
              await val.updateProfile(updateUser);
            });
          } catch (e) {
            print("error");
          }
          break;
        case AuthorizationStatus.error:
          // do something
          break;

        case AuthorizationStatus.cancelled:
          print('User cancelled');
          break;
      }
    } catch (error) {
      print("error with apple sign in");
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: Colors.grey,
            appBar: AppBar(
              title: const Text('Flutter'),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Login With',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
                AppleSignInButton(
                  style: ButtonStyle.black,
                  type: ButtonType.signIn,
                  onPressed: () {
                    initiateSignInWithApple();
                  },
                )
              ],
            )));
  }
}
