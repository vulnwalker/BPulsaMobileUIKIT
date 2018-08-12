import 'package:flutter/material.dart';
import 'package:bpulsa/config.dart';
import 'package:bpulsa/database/DatabaseHelper.dart';
import 'package:bpulsa/utils/uidata.dart';

ConfigClass configClass = new ConfigClass();
class CheckRoute extends StatefulWidget {
  var databaseHelper = new  DatabaseHelper() ;
  @override
  _CheckRouteState createState() => _CheckRouteState();
}

class _CheckRouteState extends State<CheckRoute> {
  @override
  void initState(){
    super.initState();
    // checkLogin();
    (() async {
      this.widget.databaseHelper.initDb();
      var statusLogin =  await this.widget.databaseHelper.accountRowCount() ;
      print("Row Count" + statusLogin.toString());
      if(statusLogin == 0){
      Navigator.of(context).pushReplacementNamed(UIData.loginRoute);
      }else{
      Navigator.of(context).pushReplacementNamed(UIData.homeRoute);
      }
    })();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0,),
          children: <Widget>[
            Center(
              child: Column(
                children: <Widget>[
                  CircularProgressIndicator(
                      backgroundColor: Colors.black,
                  ),
                  new Text("LOADING ..")
                ],
              )
                      
            ),

            
          ],
        ),
      )
    );
  }
}
