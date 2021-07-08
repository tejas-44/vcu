import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'dart:async';
import 'home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class SignIn extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _SignInState createState() => new _SignInState();
}

class _SignInState extends State<SignIn> {
  String _email, _password, _resetPassEmail;
  final auth = FirebaseAuth.instance;
  bool showSpinner = false;
  var _controllerEmail = TextEditingController();
  var _controllerPass = TextEditingController();


  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 64.0,
        child: Image.asset('assets/images/logo.png'),
      ),
    );

    final email = Material(
      elevation: 10,
      shadowColor: Colors.orangeAccent[100],
      borderRadius: BorderRadius.circular(32),
      child: TextFormField(
        controller: _controllerEmail,
        cursorColor: Colors.orange,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: InputDecoration(
          suffixIcon: _controllerEmail.text.length > 0
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _controllerEmail.clear();
                    });
                  },
                  icon: Icon(Icons.cancel, color: Colors.grey))
              : null,
          focusColor: Colors.orangeAccent[100],
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          prefixIcon: Icon(
            Icons.account_circle,
            color: Colors.orange,
          ),
          hintText: 'Email',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
        ),
        onChanged: (value) {
          setState(() {
            _email = value.toLowerCase().toString().trim();
          });
        },
      ),
    );

    final password = Material(
      borderRadius: BorderRadius.circular(32),
      elevation: 10,
      shadowColor: Colors.orangeAccent[100],
      child: TextFormField(
        controller: _controllerPass,
        cursorColor: Colors.orange,
        textAlign: TextAlign.center,
        autofocus: false,
        obscureText: true,
        decoration: InputDecoration(
          suffixIcon: _controllerPass.text.length > 0
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _controllerPass.clear();
                    });
                  },
                  icon: Icon(Icons.cancel, color: Colors.grey))
              : null,
          focusColor: Colors.orangeAccent[100],
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.orange,
          ),
          hintText: 'Password',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
        onChanged: (value) {
          setState(() {
            _password = value.trim();
          });
        },
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          signInAuth();
        },
        padding: EdgeInsets.all(12),
        color: Colors.orange,
        child: Text('Log In', style: TextStyle(color: Colors.white)),
      ),
    );

    final forgotLabel = FlatButton(
        child: Text(
          'Forgot password?',
          style: TextStyle(color: Colors.black54),
        ),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(
                      'Please enter your email id for resetting the password'),
                  content: TextField(
                    onChanged: (value) {
                      setState(() {
                        _resetPassEmail = value.toString().toLowerCase().trim();
                      });
                    },
                    textInputAction: TextInputAction.go,
                    keyboardType: TextInputType.emailAddress,
                    decoration:
                        InputDecoration(hintText: "Enter Your Email Id"),
                  ),
                  actions: <Widget>[
                    new FlatButton(
                      child: new Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    new FlatButton(
                      child: new Text('Reset'),
                      onPressed: () {
                        print(Text('Pressed reset'));
                          forgetPassword();
                      },
                    )
                  ],
                );
              });
        });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 24.0),
            loginButton,
            forgotLabel
          ],
        ),
      ),
    );
  }

  var errorMessage;
  var errorCode;
  var errorMessageFp;

  void signInAuth() async {
    if (_email != null && _password != null) {
      try {
        await auth
            .signInWithEmailAndPassword(email: _email, password: _password)
            .then((_) {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (c, a1, a2) => HomePage(),
              transitionsBuilder: (c, anim, a2, child) =>
                  FadeTransition(opacity: anim, child: child),
              transitionDuration: Duration(milliseconds: 1000),
            ),
          );
        });
      } on FirebaseAuthException catch (e) {
        errorMessage = e.message;
        errorCode = e.code.toString();
        if (errorMessage != null) {
          _showAlertSignin(context);
        }
        if (errorCode == '12699') {
          errorMessage = 'Enter Email And Password';
          _showAlertSignin(context);
        } else {
          print(errorMessage);
        }
      }
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Login Failed'),
                content: Text('Please enter Email ID or Password'),
                actions: <Widget>[
                  FlatButton(
                    child: new Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ));
    }
  }


  void forgetPassword() async {
    print(Text('initializing fp'));
if(_resetPassEmail!=null) {
  try  {
    print(Text(' fp'));
    await auth
        .sendPasswordResetEmail(
        email: _resetPassEmail.toString())
        .then((_) => showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Email Reset Link Sent'),
            content: Text(
                'Please check your email id so that you can reset the password.'),
            actions: <Widget>[
              FlatButton(
                child: new Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }));

  } on FirebaseAuthException catch (error) {
    errorMessage = error.message;
    errorCode = error.code.toString();
    if (errorMessage != null) {
      _showAlertFP(context);
    }
    else {
      print(error.message);
      print(errorMessage);
    }
  }
}
else {
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Login Failed'),
      content: Text('Please enter valid email address'),
      actions: <Widget>[
        FlatButton(
          child: new Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    ));

}


  }

  void _showAlertSignin(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Login Failed'),
              content: Text(errorMessage),
              actions: <Widget>[
                FlatButton(
                  child: new Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }

  void _showAlertFP(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Link Not Sent'),
          content: Text(errorMessage),
          actions: <Widget>[
            FlatButton(
              child: new Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ));
  }
}
