import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart ' as http;

class Authentication extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthenticationPageState();
  }
}

enum AuthMode { Login, SignUp }

class _AuthenticationPageState extends State<Authentication> {
  Color ss = Colors.black;
  final Map<String, dynamic> _formData = {
    'email': null,
    'password': null,
    'acceptTerms': false
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  AuthMode _authMode = AuthMode.Login;

  Widget _buildEmailTextField() {
    return TextFormField(
      key: Key("emailfield"),
      decoration: InputDecoration(
        labelText: "Email",
        prefixIcon: const Icon(
          Icons.mail,
          color: Colors.green,
        ),
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xff36332e),
            width: 4.0,
          ),
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),

      keyboardType: TextInputType.emailAddress,
      controller: _emailController,
      // ignore: missing_return
      validator: (String value) {
        if (_emailController.text.isEmpty ||
            !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(value)) {
          return 'Please enter a valid email';
        }
      },
      onSaved: (String value) {
        _formData['email'] = value;
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      key: Key("passwordfield"),
      decoration: InputDecoration(
        labelText: "Password",
        prefixIcon: const Icon(
          Icons.lock,
          color: Colors.red,
        ),
        focusColor: Colors.red,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xff36332e), width: 4.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),

      obscureText: true,
      controller: _passwordController,
      // ignore: missing_return
      validator: (String value) {
        if (value.isEmpty || value.length < 6) {
          return 'Password invalid';
        }
      },
      onSaved: (String value) {
        _formData['password'] = value;
      },
    );
  }

  Widget _buildPasswordConfirmTextField() {
    return TextFormField(
      key: Key("cnfrmPass"),
      decoration: InputDecoration(
        labelText: "Confirm Password",
        prefixIcon: const Icon(
          Icons.lock,
          color: Colors.red,
        ),
        focusColor: Colors.red,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xff36332e), width: 4.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );
  }

  Widget _buildAcceptSwitch() {
    return SwitchListTile(
      key: Key('acceptterms'),
      activeColor: Colors.green,
      value: _formData['acceptTerms'],
      onChanged: (bool value) {
        setState(() {
          _formData['acceptTerms'] = value;
        });
      },
      title: Text('Accept Terms',
          style: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.bold, color: ss)),
    );
  }

  Future<Map<String, dynamic>> authenticate(
      String email, String password, AuthMode mode) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };
    http.Response response;
    if (mode == AuthMode.Login) {
      response = await http.post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyBYNRW_OYfP_39rqIGPqP0R-wSWhoEFvPM',
        body: json.encode(authData),
        headers: {'Content-type': 'application/json'},
      );
    } else if (mode == AuthMode.SignUp) {
      response = await http.post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyBYNRW_OYfP_39rqIGPqP0R-wSWhoEFvPM',
        body: json.encode(authData),
        headers: {'Content-Type': 'application/json'},
      );
    }

    final Map<String, dynamic> responseData = json.decode(response.body);
    bool hasError = true;
    String message = 'Some thing went wrong';

    if (responseData.containsKey('idToken')) {
      hasError = false;
      message = 'Authentication Successeded';
    } else if (responseData['error']['message'] == 'EMAIL_EXISTS') {
      message = 'Email Exsist';
    } else if (responseData['error']['message'] == 'EMAIL_NOT_FOUND') {
      message = 'Email Dont Exsist!';
    } else if (responseData['error']['message'] == 'INVALID_PASSWORD') {
      message = 'Invalid Password';
    }

    return {'success': !hasError, 'message': message};
  }

  Future _submitForm() async {
    if (!_formKey.currentState.validate() || !_formData['acceptTerms']) {
      setState(() {
        ss = Colors.red;
      });
      return;
    }

    _formKey.currentState.save();
    Map<String, dynamic> successInformation;

    successInformation = await authenticate(
        _formData['email'], _formData['password'], _authMode);

    if (successInformation['success']) {
      if (_authMode == AuthMode.Login) {
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        setState(() {
          _authMode = AuthMode.Login;
        });
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('An Error Occured'),
            content: Text(successInformation['message']),
            actions: [
              TextButton(
                  key: Key('dialog'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Okay'))
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff36332e),
        toolbarHeight: 80,
        title: _authMode == AuthMode.SignUp
            ? Text(
                'Sign-Up',
                style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )
            : Text(
                'Log-In',
                style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(),
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: targetWidth,
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    _buildEmailTextField(),
                    SizedBox(
                      height: 10.0,
                    ),
                    _buildPasswordTextField(),
                    SizedBox(
                      height: 10.0,
                    ),
                    _authMode == AuthMode.SignUp
                        ? _buildPasswordConfirmTextField()
                        : Container(),
                    SizedBox(
                      height: 10.0,
                    ),
                    _buildAcceptSwitch(),
                    SizedBox(
                      height: 10.0, 
                    ),
                    TextButton(
                      key: Key('authenticate'),
                      onPressed: () {
                        setState(() {
                          _authMode = _authMode == AuthMode.Login
                              ? AuthMode.SignUp
                              : AuthMode.Login;
                        });
                      },
                      child: Text(
                          '${_authMode == AuthMode.Login ? 'Register' : 'LogIn'}',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          )),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.black,
                            ),
                            key: Key('registerbtn'),
                            child: _authMode == AuthMode.SignUp
                                ? Text('Register')
                                : Text('LOGIN'),
                            onPressed: () => _submitForm())),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
