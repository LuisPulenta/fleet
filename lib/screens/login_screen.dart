import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fleet/helpers/constants.dart';
import 'package:fleet/models/response.dart';
import 'package:fleet/components/loader_component.dart';
import 'package:fleet/models/usuario.dart';
import 'package:fleet/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //String _email = 'AVASILE';
  String _email = '';
  String _emailError = '';
  bool _emailShowError = false;

  //String _password = 'AVA123';
  String _password = '';
  String _passwordError = '';
  bool _passwordShowError = false;

  bool _rememberme = true;

  bool _passwordShow = false;

  bool _showLoader = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff8c8c94),
      body: Stack(
        children: <Widget>[
          Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xff242424),
                    Color(0xff8c8c94),
                  ],
                ),
              ),
              child: Image.asset(
                "assets/logo.png",
                height: 200,
              )),
          Transform.translate(
            offset: Offset(0, -60),
            child: Center(
              child: SingleChildScrollView(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  elevation: 15,
                  margin: EdgeInsets.only(
                      left: 20, right: 20, top: 260, bottom: 20),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _showEmail(),
                        _showPassword(),
                        SizedBox(
                          height: 10,
                        ),
                        _showRememberme(),
                        _showButtons(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
          _showLoader
              ? LoaderComponent(
                  text: 'Por favor espere...',
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _showLogo() {
    return Image(
      image: AssetImage('assets/logo.png'),
      width: 300,
    );
  }

  Widget _showEmail() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: 'Usuario...',
            labelText: 'Usuario',
            errorText: _emailShowError ? _emailError : null,
            prefixIcon: Icon(Icons.person),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        onChanged: (value) {
          _email = value;
        },
      ),
    );
  }

  Widget _showPassword() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        obscureText: !_passwordShow,
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: 'Contraseña...',
            labelText: 'Contraseña',
            errorText: _passwordShowError ? _passwordError : null,
            prefixIcon: Icon(Icons.lock),
            suffixIcon: IconButton(
              icon: _passwordShow
                  ? Icon(Icons.visibility)
                  : Icon(Icons.visibility_off),
              onPressed: () {
                setState(() {
                  _passwordShow = !_passwordShow;
                });
              },
            ),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        onChanged: (value) {
          _password = value;
        },
      ),
    );
  }

  _showRememberme() {
    return CheckboxListTile(
      title: Text('Recordarme:'),
      value: _rememberme,
      onChanged: (value) {
        setState(() {
          _rememberme = value!;
        });
      },
    );
  }

  Widget _showButtons() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            child: ElevatedButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.login),
                  SizedBox(
                    width: 20,
                  ),
                  Text('Iniciar Sesión'),
                ],
              ),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF781f1e),
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed: () => _login(),
            ),
          ),
        ],
      ),
    );
  }

  void _login() async {
    setState(() {
      _passwordShow = false;
    });

    if (!validateFields()) {
      return;
    }

    setState(() {
      _showLoader = true;
    });

    Map<String, dynamic> request = {
      'Email': _email,
      'password': _password,
    };

    var url = Uri.parse('${Constants.apiUrl}/Api/Account/GetUserByEmail');
    var response = await http.post(
      url,
      headers: {
        'content-type': 'application/json',
        'accept': 'application/json',
      },
      body: jsonEncode(request),
    );

    if (response.statusCode >= 400) {
      setState(() {
        _passwordShowError = true;
        _passwordError = 'Email o contraseña incorrectos';
      });
      return;
    }

    var body = response.body;
    var decodedJson = jsonDecode(body);
    var user = Usuario.fromJson(decodedJson);

    if (user.usrcontrasena!.toLowerCase() != _password.toLowerCase()) {
      setState(() {
        _showLoader = false;
        _passwordShowError = true;
        _passwordError = 'Email o contraseña incorrectos';
      });
      return;
    }

    // if (user.habilitaAPP != 1) {
    //   setState(() {
    //     _showLoader = false;
    //     _passwordShowError = true;
    //     _passwordError = 'Usuario no habilitado';
    //   });
    //   return;
    // }

    if (_rememberme) {
      _storeUser(body);
    }

    setState(() {
      _showLoader = false;
    });

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => HomeScreen(
                  user: user,
                )));
  }

  bool validateFields() {
    bool isValid = true;

    if (_email.isEmpty) {
      isValid = false;
      _emailShowError = true;
      _emailError = 'Debes ingresar tu Usuario';
    } else {
      _emailShowError = false;
    }

    if (_password.isEmpty) {
      isValid = false;
      _passwordShowError = true;
      _passwordError = 'Debes ingresar tu Contraseña';
    } else if (_password.length < 6) {
      isValid = false;
      _passwordShowError = true;
      _passwordError = 'La Contraseña debe tener al menos 6 caracteres';
    } else {
      _passwordShowError = false;
    }

    setState(() {});

    return isValid;
  }

  void _storeUser(String body) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isRemembered', true);
    await prefs.setString('userBody', body);
    await prefs.setString('date', DateTime.now().toString());
  }
}