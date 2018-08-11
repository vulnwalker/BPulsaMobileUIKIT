import 'package:flutter/material.dart';
import 'package:bpulsa/model/login.dart';
import 'package:bpulsa/config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bpulsa/database/DatabaseHelper.dart';
import 'package:bpulsa/database/model/account.dart';
import 'package:bpulsa/utils/uidata.dart';
ConfigClass configClass = new ConfigClass();
class Register extends StatefulWidget {
  @override
   RegisterState createState() => new RegisterState();
}

class RegisterState extends State<Register> {
  String email,password,passwordConfirm,nama,nomorTelepon = "";

  @override
  Widget build(BuildContext context) { 
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.black,
        title: new Text("Register"),
        actions: <Widget>[
          new IconButton(icon: const Icon(Icons.save), onPressed: () {
            if(email!="" && password != "" && passwordConfirm != "" && nama != "" && nomorTelepon != ""){
              if(password != passwordConfirm ){
                AlertDialog dialog = new AlertDialog(
                      content: new Text("Confirm Password Tidak Sama ")
                    );
                showDialog(context : context, child: dialog);
              }else{
                configClass.showLoading(context);
                var dataPost = {
                  "email":email, 
                  "password": passwordConfirm,
                  "nama": nama,
                  "nomorTelepon": nomorTelepon,
                  };
                http.post(configClass.register(), body: dataPost).then((response) {
                    configClass.closeLoading(context);
                    final jsonResponse = json.decode(response.body.toString());
                    String loginResponse ;
                    Resp resp = new Resp.fromJson(jsonResponse);
                    print("Welcome "+ resp.result.content.nama.toString());
                    if(resp.result.err == ''){
                      var db = new DatabaseHelper();
                      var dataAccount = new Account(
                        email,
                        password,
                        resp.result.content.nama,
                        resp.result.content.nomor_telepon,
                        0,
                        1,
                      );
                      db.saveAccount(dataAccount);
                      AlertDialog dialog = new AlertDialog(
                        content: new Text("Register Success")
                      );
                      showDialog(context: context,child: dialog);
                      Navigator.of(context).pushReplacementNamed(UIData.homeRoute);

                    }else{
                      loginResponse = resp.result.err;
                      AlertDialog dialog = new AlertDialog(
                        content: new Text(loginResponse)
                      );
                      showDialog(context: context,child: dialog);
                    }

                  });
              }
            }else{
              AlertDialog dialog = new AlertDialog(
                content: new Text("Semua Kolom Harus Di Isi")
              );
              showDialog(context: context,child: dialog);
            }
            

          })
        ],
      ),
      body: new Column(
        children: <Widget>[
          new ListTile(
            leading: const Icon(Icons.person),
            title: new TextField(
              onChanged: (String text) {
                email = text;
              },
              keyboardType: TextInputType.emailAddress,
              autofocus: false,
              decoration: InputDecoration(
                hintText: 'Email',
              ),
            ),
          ),
           new ListTile(
            leading: const Icon(Icons.security),
            title: new TextField(
              onChanged: (String text) {
                password = text;
              },
              obscureText: true,
              autofocus: false,
              decoration: InputDecoration(
                hintText: 'Password',
              ),
            ),
          ),
           new ListTile(
            leading: const Icon(Icons.security),
            title: new TextField(
              onChanged: (String text) {
                passwordConfirm = text;
              },
              obscureText: true,
              autofocus: false,
              decoration: InputDecoration(
                hintText: 'Confirm Password',
              ),
            ),
          ),
          new ListTile(
            leading: const Icon(Icons.person),
            title: new TextField(
              onChanged: (String text) {
                nama = text;
              },
              keyboardType: TextInputType.text,
              autofocus: false,
              decoration: InputDecoration(
                hintText: 'Name',
              ),
            ),
          ),
          new ListTile(
            leading: const Icon(Icons.phone),
            title: new TextField(
              onChanged: (String text) {
                nomorTelepon = text;
              },
              keyboardType: TextInputType.phone,
              autofocus: false,
              decoration: InputDecoration(
                hintText: 'Phone Number',
              ),
            ),
          ),

        ],
      ),
    );
  }
}
