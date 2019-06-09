import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //Obj สำหรับ Class นี้
  final formKey = GlobalKey<FormState>();

  String strName, strEmail, strPassword;

  Widget uploadButton() {
    return IconButton(
      icon: Icon(Icons.cloud_upload),
      onPressed: () {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          print('Name = $strName, Email = $strEmail, Password =$strPassword');
        }
      },
    );
  }

  void uploadValueToFirebase() async{

    FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  }

  Widget nameTextFormField() {
    return Container(
      alignment: Alignment(0, -1),
      child: Container(
        width: 250.0,
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Name :',
            hintText: 'Request',
          ),
          validator: (String valueName) {
            if (valueName.length == 0) {
              return 'Please Fill Name Blank.';
            }
          },
          onSaved: (String valueName) => strName = valueName,
        ),
      ),
    );
  }

  Widget emailTextFormField() {
    return Container(
      alignment: Alignment(0, -1),
      child: Container(
        width: 250.0,
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'E-mail :',
            hintText: 'Request',
          ),
          validator: (String valueEmail) {
            if (!((valueEmail.contains('@')) && (valueEmail.contains('.')))) {
              return 'Please Type Email Format.';
            }
          },
          onSaved: (String valueEmail) {
            strEmail = valueEmail;
          },
        ),
      ),
    );
  }

  Widget passwordTextFormField() {
    return Container(
      alignment: Alignment(0, -1),
      child: Container(
        width: 250.0,
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Password :',
            hintText: 'Request',
          ),
          validator: (String valuePassword) {
            if (valuePassword.length < 6) {
              return 'Please More 6 charactor.';
            }
          },
          onSaved: (String valuePassword) => strPassword = valuePassword,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Register'),
        actions: <Widget>[uploadButton()],
      ),
      body: Form(
        key: formKey,
        child: Container(
            padding: EdgeInsets.only(top: 80.0),
            alignment: Alignment(0, -1),
            child: Column(
              children: <Widget>[
                nameTextFormField(),
                emailTextFormField(),
                passwordTextFormField(),
              ],
            )),
      ),
    );
  }
}
