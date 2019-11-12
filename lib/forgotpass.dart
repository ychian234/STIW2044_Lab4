import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:my_helper/loginscreen.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';

String urlUpload = "http://mobilehost2019.com/MyPlumber2/php/forgotpassword.php";
final TextEditingController _namecontroller = TextEditingController();
final TextEditingController _emcontroller = TextEditingController();
final TextEditingController _phcontroller = TextEditingController();
final TextEditingController _passcontroller = TextEditingController();
String _name, _email,_phone,_password;

class ForgotPass extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
      const ForgotPass({Key key, File image}) : super(key: key);
}
  
  class _ForgotPasswordState extends State<ForgotPass> {
    @override
    void initState() {
      super.initState();
    }
  
    @override
    Widget build(BuildContext context) {
      return WillPopScope(
        onWillPop: _onBackPressAppBar,
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            title: Text('Forgot Password'),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
              child: ForgotWidget(),
            ),
          ),
        ),
      );
    }
  Future<bool> _onBackPressAppBar() async {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ));
    return Future.value(false);
  }
  }
  
  class ForgotWidget extends StatefulWidget {
    @override
    ForgotWidgetState createState() => ForgotWidgetState();
  }
  
  class ForgotWidgetState extends State<ForgotWidget> {
    @override
    Widget build(BuildContext context) {
      return Column(
        children: <Widget>[
          TextField(
              controller: _emcontroller,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Registered Email',
                icon: Icon(Icons.email),
              )),
          TextField(
              controller: _namecontroller,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Registered Name',
                icon: Icon(Icons.person),
              )),
              TextField(
            controller: _phcontroller,
            keyboardType: TextInputType.phone,
            decoration:
                InputDecoration(labelText: 'Phone', icon: Icon(Icons.phone))),
              TextField(
          controller: _passcontroller,
          decoration:
              InputDecoration(labelText: 'New Password', icon: Icon(Icons.lock)),
          obscureText: true,
        ),
          SizedBox(
            height: 10,
          ),
          MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
            minWidth: 300,
            height: 50,
            child: Text('Submit'),
            color: Color.fromRGBO(159, 30, 99, 1),
            textColor: Colors.white,
            elevation: 15,
            onPressed: _onSubmit,
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
              onTap: _onBackPress,
              child: Text('Back to Login', style: TextStyle(fontSize: 16))),
        ],
      );
    }
  
    void _onSubmit() {
      print('onSubmit Button from ForgotPass()');
      uploadData();
    }
  
    void _onBackPress() {
      print('onBackpress from ForgotPass');
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
    }
  
    void uploadData() {
      _name = _namecontroller.text;
      _email = _emcontroller.text;
      _phone = _phcontroller.text;
      _password = _passcontroller.text;
  
      if ((_isEmailValid(_email)) &&
          (_name != null) && (_phone != null)) {
        ProgressDialog pr = new ProgressDialog(context,
            type: ProgressDialogType.Normal, isDismissible: false);
        pr.style(message: "Changing password..");
        pr.show();
  
        http.post(urlUpload, body: {
          "name": _name,
          "email": _email,
          "phone": _phone,
          "password": _password,
        }).then((res) {
          print(res.statusCode);
          Toast.show(res.body, context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
          _namecontroller.text = '';
          _emcontroller.text = '';
          _phcontroller.text = '';
          pr.dismiss();
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
        }).catchError((err) {
          print(err);
        });
      } else {
        Toast.show("Failed to change password.", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    }
  
    bool _isEmailValid(String email) {
      return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
    }
  }