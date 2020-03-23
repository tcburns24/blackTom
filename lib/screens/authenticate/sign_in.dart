import 'package:blacktom/services/auth.dart';
import 'package:blacktom/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  SignIn({this.toggleView});
  final Function toggleView;

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = new AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String errorText = '';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        elevation: 6.0,
        title: Text('Sign in'),
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 12, bottom: 12), child: Container(child: Text('Sign up for Batjack'))),
                TextFormField(
                  onChanged: (val) {
                    setState(() {
                      email = val;
                    });
                  },
                  validator: (val) => val.isEmpty ? 'Enter your email, dumbass' : null,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  obscureText: true,
                  onChanged: (val) {
                    setState(() {
                      password = val;
                    });
                  },
                  validator: (val) => val.length < 6 ? 'Password\'s gotta be 6+ characters' : null,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                SizedBox(height: 20),
                isLoading
                    ? Padding(padding: EdgeInsets.only(top: 6), child: Loading())
                    : RaisedButton(
                        color: Colors.blueAccent[700],
                        textColor: Colors.white,
                        child: Text('Sign in'),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                errorText = 'No existing user w/ those credentials';
                                isLoading = false;
                              });
                            }
                          }
                        },
                      ),
                SizedBox(height: 12),
                Text(errorText, style: TextStyle(color: Colors.red, fontFamily: 'Avenir')),
                Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Container(
                        child: GestureDetector(
                      child: Text('New to Blacktom? Sign up here.'),
                      onTap: () => widget.toggleView(),
                    )))
              ],
            ),
          )),
    );
  }
}
