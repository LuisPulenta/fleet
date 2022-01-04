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
        title: Text('Fleet App'),
        backgroundColor: Color(0xFF0e4888),
        centerTitle: true,
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
              Color(0xffFFFFFF),
              Color(0xffFFFFFF),
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
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
                    color: Color(0xFF0e4888)),
              ),
            ],
          ),
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
              Color(0xffffffff),
              Color(0xff88a3be),
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
                    Color(0xffffffff),
                    Color(0xffffffff),
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
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        "Usuario: ",
                        style: (TextStyle(
                            color: Color(0xff0e4888),
                            fontWeight: FontWeight.bold)),
                      ),
                      Text(
                        widget.user.apellidonombre!,
                        style: (TextStyle(color: Colors.black)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              color: Color(0xff0e4888),
              height: 1,
            ),
            ListTile(
              leading: Icon(
                Icons.settings_remote,
                color: Color(0xff0e4888),
              ),
              title: Text('Controles Remotos',
                  style: TextStyle(fontSize: 15, color: Color(0xff0e4888))),
              tileColor: Color(0xff0e4888),
              onTap: () {},
            ),
            Divider(
              color: Color(0xff0e4888),
              height: 1,
            ),
            ListTile(
              leading: Icon(
                Icons.router,
                color: Color(0xff0e4888),
              ),
              title: Text('Recuperos Prisma',
                  style: TextStyle(fontSize: 15, color: Color(0xff0e4888))),
              tileColor: Color(0xff0e4888),
              onTap: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => ObrasScreen(
                //               user: widget.user,
                //             )));
              },
            ),
            Divider(
              color: Color(0xff0e4888),
              height: 1,
            ),
            ListTile(
              leading: Icon(
                Icons.router,
                color: Color(0xff0e4888),
              ),
              title: Text('Recuperos Cablevisión',
                  style: TextStyle(fontSize: 15, color: Color(0xff0e4888))),
              tileColor: Color(0xff8c8c94),
              onTap: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => MedidoresScreen()));
              },
            ),
            Divider(
              color: Color(0xff0e4888),
              height: 1,
            ),
            ListTile(
              leading: Icon(
                Icons.satellite,
                color: Color(0xff0e4888),
              ),
              title: Text('Recuperos DTV',
                  style: TextStyle(fontSize: 15, color: Color(0xff0e4888))),
              tileColor: Color(0xff8c8c94),
              onTap: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => SeguridadScreen()));
              },
            ),
            Divider(
              color: Color(0xff0e4888),
              height: 1,
            ),
            ListTile(
              leading: Icon(
                Icons.settings_input_antenna,
                color: Color(0xff0e4888),
              ),
              title: Text('Recuperos Tasa',
                  style: TextStyle(fontSize: 15, color: Color(0xff0e4888))),
              tileColor: Color(0xff8c8c94),
              onTap: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => SeguridadScreen()));
              },
            ),
            Divider(
              color: Color(0xff0e4888),
              height: 1,
            ),
            ListTile(
              leading: Icon(
                Icons.title,
                color: Color(0xff0e4888),
              ),
              title: Text('Recuperos TLC',
                  style: TextStyle(fontSize: 15, color: Color(0xff0e4888))),
              tileColor: Color(0xff8c8c94),
              onTap: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => SeguridadScreen()));
              },
            ),
            Divider(
              color: Color(0xff0e4888),
              height: 1,
            ),
            ListTile(
              leading: Icon(
                Icons.map,
                color: Color(0xff0e4888),
              ),
              title: Text('Mapa',
                  style: TextStyle(fontSize: 15, color: Color(0xff0e4888))),
              tileColor: Color(0xff8c8c94),
              onTap: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => SeguridadScreen()));
              },
            ),
            Divider(
              color: Color(0xff0e4888),
              height: 1,
            ),
            ListTile(
              leading: Icon(
                Icons.equalizer,
                color: Color(0xff0e4888),
              ),
              title: Text('Estadísticas',
                  style: TextStyle(fontSize: 15, color: Color(0xff0e4888))),
              tileColor: Color(0xff8c8c94),
              onTap: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => SeguridadScreen()));
              },
            ),
            Divider(
              color: Color(0xff0e4888),
              height: 1,
            ),
            ListTile(
              leading: Icon(
                Icons.contact_page,
                color: Color(0xff0e4888),
              ),
              title: Text('Contacto',
                  style: TextStyle(fontSize: 15, color: Color(0xff0e4888))),
              tileColor: Color(0xff8c8c94),
              onTap: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => SeguridadScreen()));
              },
            ),
            Divider(
              color: Color(0xff0e4888),
              height: 1,
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Color(0xff0e4888),
              ),
              tileColor: Color(0xff8c8c94),
              title: Text('Cerrar Sesión',
                  style: TextStyle(fontSize: 15, color: Color(0xff0e4888))),
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
