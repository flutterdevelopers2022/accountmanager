import 'package:accountmanager/dashboard.dart';
import 'package:accountmanager/mycontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:local_auth/local_auth.dart';

class FirstScreen extends StatelessWidget {
  final inputController = InputController();
  String pass = "";
  Future<void> localAuth(BuildContext context) async {
    final localAuth = LocalAuthentication();
    final didAuthenticate = await localAuth.authenticate(
        localizedReason: 'Please authenticate');
    if (didAuthenticate) {

    }
    else{

    }
  }
  @override
  Widget build(BuildContext context) {
    pass = Mycontroller.pref!.getString("pass") ?? "";

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              color: Colors.blueGrey,
              image: DecorationImage(
                  fit: BoxFit.fill, image: AssetImage("image/background.jpg"))),
          child: ScreenLock(
            correctString: '${pass}',
            onUnlocked: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                return DashBoard();
              },));
            },onOpened: () async {
            await localAuth(context);
            },
            onValidate: (input) async{
              print("on validate : $input");
              if(pass==input) {
                return true;
              }else
                {
                  return false;
                }
            },
          ),
        ));
  }
}
