import 'package:flutter/material.dart';

void main() {
  runApp(MyAppHomePage());
}

class MyAppHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(home: new LoginScreen());
  }
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.red,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Login With',
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
              FlatButton(
                child: Text(
                  'Apple Sign In',
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
                onPressed: () {},
                color: Colors.white,
              ),
            ],
          ),
        ));
  }
}
