import 'package:flutter/material.dart';
import 'package:my_helper/loginscreen.dart';
 
class TabScreen3 extends StatefulWidget {
  final String apptitle;
  final String email;
  TabScreen3(this.apptitle , this.email);

  @override
  _TabScreen3State createState() => _TabScreen3State();
}

class _TabScreen3State extends State<TabScreen3> {
  @override
  Widget build(BuildContext context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
        MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  minWidth: 300,
                  height: 50,
                  child: Text('Logout'),
                  color: Color.fromRGBO(159, 30, 99, 1),
                  textColor: Colors.white,
                  elevation: 15,
                  onPressed: _onLogout,
                ),]
    );
  }
  void _onLogout() {
    print('onLogout');
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }
}