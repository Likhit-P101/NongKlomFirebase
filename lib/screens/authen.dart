import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  double size = 120.0;

  Widget space() {
    //ทำเป็นช่องว่างแล้วนำไปแทรกตาม
    return SizedBox(
      height: 16.0,
      width: 8.0,
    );
  }

  Widget showLogo() {
    return Container(
      width: size,
      height: size,
      alignment: Alignment(0, -1),
      child: Image.asset(
        'images/logo.png',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget showAppName() {
    return Container(
      alignment: Alignment(0, -1),
      child: Text(
        'Boy Firebase',
        style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent),
      ),
    );
  }

  Widget emailTextFromField() {
    return Container(
      width: 250.0,
      alignment: Alignment(0, -1),
      child: TextFormField(
        decoration:
            InputDecoration(labelText: 'Email :', hintText: 'you@email.com'),
      ),
    );
  }

  Widget passwordTextFromField() {
    return Container(
      width: 250.0,
      alignment: Alignment(0, -1),
      child: TextFormField(
        decoration: InputDecoration(
            labelText: 'Password :', hintText: 'More 6 charactor'),
      ),
    );
  }

  Widget signIn() {
    return Expanded(
      child: RaisedButton(
        color: Colors.blueAccent[400],
        child: Text(
          'Sign In',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {},
      ),
    );
  }

  Widget signUp() {
    return Expanded(
      child: RaisedButton(
        color: Colors.blueAccent[100],
        child: Text(
          'Sign Up',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        decoration: BoxDecoration(
            gradient: RadialGradient(
                colors: [Colors.white, Colors.blueAccent[400]],
                center: Alignment(0, 0),
                radius: 1.5)),
        padding: EdgeInsets.only(top: 30.0, left: 50.0, right: 50.0),
        alignment: Alignment(0, -1),
        child: Column(
          children: <Widget>[
            showLogo(),
            space(),
            showAppName(),
            emailTextFromField(),
            passwordTextFromField(),
            space(),
            Container(
              alignment: Alignment(0, -1),
              width: 250.0,
              child: Row(
                children: <Widget>[signIn(), space(), signUp()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
