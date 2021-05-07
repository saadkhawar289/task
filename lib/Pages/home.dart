import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

Widget _buildDrawer(BuildContext context) {
  return Drawer(
    child: Column(
      children: <Widget>[
        AppBar(
          backgroundColor: Color(0xff36332e),
          automaticallyImplyLeading: false,
          title: Text('Choose'),
        ),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text('Logout'),
          onTap: () {
            Navigator.pushReplacementNamed(context, '/Auth');
          },
        ),
        Divider(),
      ],
    ),
  );
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        drawer: _buildDrawer(context),
        appBar: AppBar(
          title: Text('Welcome To Home'),
          backgroundColor: Color(0xff36332e),
        ),
        body: Center(
          child: Container(
            child: Text(
              'Hello RNS Solutions',
              style: TextStyle(color: Colors.red, fontSize: 25),
            ),
          ),
        ),
      ),
    );
  }
}
