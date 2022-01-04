import 'package:flutter/material.dart';
import 'package:fleet/models/usuario.dart';
import 'package:fleet/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  final Usuario user;

  HomeScreen({required this.user});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rowing App'),
      ),
      body: _getBody(),
      drawer: _getMenu(),
    );
  }

  Widget _getBody() {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 60),
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
        child: Column(
          children: [
            Image.asset(
              "assets/logo.png",
              height: 200,
            ),
            Text(
              'Bienvenido/a ${widget.user.apellidonombre}',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ));
  }

  Widget _getMenu() {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff8c8c94),
              Color(0xff8c8c94),
            ],
          ),
        ),
        child: ListView(
          children: <Widget>[
            DrawerHeader(
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
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Image(
                    image: AssetImage('assets/logo.png'),
                    width: 200,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      Text(
                        "Usuario: ",
                        style: (TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                      Text(
                        widget.user.apellidonombre!,
                        style: (TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.white,
              height: 1,
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.white,
              ),
              title: Text('Inicio',
                  style: TextStyle(fontSize: 15, color: Colors.white)),
              tileColor: Color(0xff8c8c94),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.construction,
                color: Colors.white,
              ),
              title: Text('Obras',
                  style: TextStyle(fontSize: 15, color: Colors.white)),
              tileColor: Color(0xff8c8c94),
              onTap: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => ObrasScreen(
                //               user: widget.user,
                //             )));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.handyman,
                color: Colors.white,
              ),
              title: Text('Medidores',
                  style: TextStyle(fontSize: 15, color: Colors.white)),
              tileColor: Color(0xff8c8c94),
              onTap: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => MedidoresScreen()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.engineering,
                color: Colors.white,
              ),
              title: Text('Seguridad e Higiene',
                  style: TextStyle(fontSize: 15, color: Colors.white)),
              tileColor: Color(0xff8c8c94),
              onTap: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => SeguridadScreen()));
              },
            ),
            Divider(
              color: Colors.white,
              height: 1,
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              tileColor: Color(0xff8c8c94),
              title: Text('Cerrar Sesión',
                  style: TextStyle(fontSize: 15, color: Colors.white)),
              onTap: () {
                _logOut();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isRemembered', false);
    await prefs.setString('userBody', '');
    await prefs.setString('date', '');
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
