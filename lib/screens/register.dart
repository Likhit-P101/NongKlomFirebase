import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nongklomfirebase/screens/my_service.dart';

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
          uploadValueToFirebase(context);
        }
      },
    );
  }

  void uploadValueToFirebase(BuildContext context) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth
        .createUserWithEmailAndPassword(email: strEmail, password: strPassword)
        .then((objValue) {
      print('Success Register');

      // get Uid from FirebaseAuth => Success
      String strUid = objValue.uid.toString();
      print('Uid => $strUid');

      //send uid to database method
      updateDatabase(strUid, context);
    }).catchError((errorObj) {
      String strError = errorObj.message;
      print('Error {uploadValueToFirebase} => $strError');

      showAlertDialog('Cannot Registed', strError);
    });
  }

  void updateDatabase(String strUid, BuildContext context) async {
    FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;

    // set Value to map
    Map<String, String> map = Map();
    map['Uid'] = strUid;
    map['Name'] = strName;
    map['Email'] = strEmail;

    await firebaseDatabase
        .reference()
        .child('User')
        .child(strUid)
        .set(map)
        .then((objValue) {
      
      //Move to MyService
      var serviceRoute =
          MaterialPageRoute(builder: (BuildContext context) => MyService());
      Navigator.of(context)
          .pushAndRemoveUntil(serviceRoute, (Route<dynamic> route) => false);
    });
  }

  void showAlertDialog(String strTitle, String strMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(strTitle),
          content: Text(strMessage),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
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
