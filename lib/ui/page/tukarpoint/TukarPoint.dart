import 'package:flutter/material.dart';
import 'package:bpulsa/logic/bloc/TukarPointBloc.dart';
import 'package:bpulsa/model/TukarPointModel.dart';
import 'package:bpulsa/ui/widgets/common_scaffold.dart';
import 'package:flushbar/flushbar.dart';
import 'package:bpulsa/config.dart';
import 'package:bpulsa/utils/uidata.dart';
import 'package:http/http.dart' as http;
import 'package:bpulsa/database/DatabaseHelper.dart';
import 'dart:convert';
import 'package:bpulsa/database/model/account.dart';
class TukarPoint extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String email,password,passwordConfirm,nama,nomorTelepon = "";
  String oldEmail ;
  int saldoMember;
  ConfigClass configClass = new ConfigClass();
  var databaseHelper = new  DatabaseHelper() ;

  void getDataAccount() async{
    var dbClient = await databaseHelper.db;
        List<Map> list = await dbClient.rawQuery('SELECT * FROM tabel_account');
        email = list[0]["email"];
        nama = list[0]["nama"];
        oldEmail = list[0]["email"];
        password = list[0]["password"];
        passwordConfirm = list[0]["password"];
        nomorTelepon = list[0]["nomor_telepon"]; 
        saldoMember = list[0]["saldo"]; 
  }
  //stack1
  Widget imageStack(String img) => Image.network(
        img,
        fit: BoxFit.cover,
      );

  //stack2
  Widget descStack(TukarPointModel tukarPoint) => Positioned(
        bottom: 0.0,
        left: 0.0,
        right: 0.0,
        child: Container(
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Text(
                    tukarPoint.name,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Text(tukarPoint.price,
                    style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold))
              ],
            ),
          ),
        ),
      );

  //stack3
  Widget ratingStack(String rating) => Positioned(
        top: 0.0,
        left: 0.0,
        child: Container(
          padding: EdgeInsets.all(4.0),
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.9),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0))),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.star,
                color: Colors.cyanAccent,
                size: 10.0,
              ),
              SizedBox(
                width: 2.0,
              ),
              Text(
                rating.toString(),
                style: TextStyle(color: Colors.white, fontSize: 10.0),
              )
            ],
          ),
        ),
      );

  Widget tukarPointGrid(List<TukarPointModel> tukarPointModels,context) => GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        children: tukarPointModels
            .map((tukarPoint) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    splashColor: Colors.yellow,
                    onTap: () => showFlushBar(tukarPoint,context),
                    child: Material(
                      elevation: 2.0,
                      child: Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          imageStack(tukarPoint.image),
                          descStack(tukarPoint),
                          ratingStack(tukarPoint.rating),
                        ],
                      ),
                    ),
                  ),
                ))
            .toList(),
      );

  Widget bodyData(context) {
    TukarPointBloc tukarPointBloc = TukarPointBloc();
    return StreamBuilder<List<TukarPointModel>>(
        stream: tukarPointBloc.tukarPointItems,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? tukarPointGrid(snapshot.data,context)
              : Center(child: CircularProgressIndicator());
        });
  }

  void showFlushBar(arrayTukarPoint,context) {
          Flushbar(
            flushbarPosition: FlushbarPosition.BOTTOM, //Immutable
            reverseAnimationCurve: Curves.decelerate, //Immutable
            forwardAnimationCurve: Curves.elasticOut, //Immutable
            
          )
            ..title = arrayTukarPoint.name
            ..message = arrayTukarPoint.description
            ..duration = Duration(seconds: 3)
            ..backgroundColor = Colors.red
            ..backgroundColor = Colors.red
            ..shadowColor = Colors.blue[800]
            ..isDismissible = true
            ..mainButton = FlatButton(
              onPressed: () {
                configClass.showLoading(context);
                (() async {
                  await getDataAccount();
                  var dataPost = {
                  "email":email, 
                  "idTradePoint": arrayTukarPoint.id_trade_point,
                  }; 
                    http.post(configClass.tradePoint(), body: dataPost).then((response) {
                     configClass.closeLoading(context);

                      List dataResult;
                      List dataContent;
                      var extractdata = JSON.decode(response.body);
                      dataResult = extractdata["result"];
                      dataContent = dataResult[0]["content"];
                      if(dataResult[0]["err"] == ''){
                        var db = new DatabaseHelper();
                        var dataAccount = new Account(
                          email,
                          password,
                          nama,
                          nomorTelepon,
                          saldoMember -  int.tryParse(arrayTukarPoint.price),
                          1,
                        );
                        db.updateAccount(dataAccount);
                        AlertDialog dialog = new AlertDialog(
                          content: new Text("Tukar Point Berhasil, tunggu konfirmasi dari kami")
                        );
                        showDialog(context: context,child: dialog);
                      }else{
                        AlertDialog dialog = new AlertDialog(
                          content: new Text( dataResult[0]["err"] )
                        );
                        showDialog(context: context,child: dialog);
                        print("babi kau ");

                      }
                        
                      
                    });
                   
               


                })();
                

              },
              child: Text(
                "TUKAR",
                style: TextStyle(color: Colors.amber),
              ),
            )
            ..backgroundGradient = new LinearGradient(colors: [Colors.blue,Colors.black])
            ..icon = Icon(
              Icons.shopping_cart,
              color: Colors.greenAccent,
            )
            ..linearProgressIndicator = LinearProgressIndicator(
              backgroundColor: Colors.blueGrey,
            )
            ..show(context);
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      scaffoldKey: scaffoldKey,
      appTitle: "Tukar Point",
      showDrawer: false,
      showFAB: false,
      actionFirstIcon: Icons.shopping_cart,
      bodyData: bodyData(context),
    );
  }
}
