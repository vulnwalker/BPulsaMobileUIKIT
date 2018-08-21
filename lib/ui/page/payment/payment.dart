import 'dart:async';

import 'package:flutter/material.dart';
import 'package:bpulsa/logic/bloc/PaymentBloc.dart';
import 'package:bpulsa/model/PaymentModel.dart';
import 'package:bpulsa/ui/widgets/common_scaffold.dart';
import 'package:flushbar/flushbar.dart';
import 'package:bpulsa/config.dart';
import 'package:bpulsa/utils/uidata.dart';
import 'package:http/http.dart' as http;
import 'package:bpulsa/database/DatabaseHelper.dart';
import 'dart:convert';
import 'package:bpulsa/database/model/account.dart';
class Payment extends StatefulWidget {

  

  @override
  PaymentState createState() {
    return new PaymentState();
  }
}

class PaymentState extends State<Payment> {
    final scaffoldKey = GlobalKey<ScaffoldState>();
  String email,password,passwordConfirm,nama,nomorTelepon = "";
  int limitFrom = 0;
  int limitTo = 10;
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
  
  List<int> items = List.generate(10, (i) => i);
  List<PaymentModel> kolom = [];
  ScrollController _scrollController = new ScrollController();
  bool isPerformingRequest = false;

  @override
  void initState() {
    super.initState();
    (() async {
      await getDataAccount();

    });

    _getMoreData();
    
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        double edge = 50.0;
              double offsetFromBottom = _scrollController.position.maxScrollExtent -
                      _scrollController.position.pixels;
        // if (offsetFromBottom < edge) {
                   
          _scrollController.animateTo(
              _scrollController.offset - (edge - offsetFromBottom),
              duration: new Duration(milliseconds: 500),
              curve: Curves.easeOut
            );
        // }
        //  AlertDialog dialog = new AlertDialog(
        //                   content: new Text("Tukar Point Berhasil, tunggu konfirmasi dari kami")
        //                 );
        //             showDialog(context: context,child: dialog);
        _getMoreData();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  _getMoreData() async {
        await getDataAccount();
         http.post(configClass.daftarPayment(), body: {"email":email,"from" : limitFrom.toString(),"to":limitTo.toString()}).then((response) async{
            List dataResult;
            List dataContent;
            var extractdata = JSON.decode(response.body);
            dataResult = extractdata["result"];
            if(dataResult[0]['err'] == ''){
              dataContent = dataResult[0]["content"];
              for (var i = 0; i < dataContent.length; i++) {
                kolom.add( 
                    PaymentModel(
                            id_payment: dataContent[i]['id'],
                            id_trade_point: dataContent[i]['id_trade_point'],
                            tukar_point_title: dataContent[i]['tukar_point_title'],
                            tanggal: dataContent[i]['tanggal'],
                            jam: dataContent[i]['jam'],
                            status: dataContent[i]['status'],
                        )
                  );     
              }
              limitFrom = limitFrom + dataContent.length ;
              if (!isPerformingRequest) {
                setState(() => isPerformingRequest = true);
                List<int> newEntries = await fakeRequest(
                    items.length, items.length + 10); //returns empty list
                // if (newEntries.isEmpty) {
                //   double edge = 50.0;
                //   double offsetFromBottom = _scrollController.position.maxScrollExtent -
                //       _scrollController.position.pixels;
                //   if (offsetFromBottom < edge) {
                   
                //    await _scrollController.animateTo(
                //         _scrollController.offset - (edge - offsetFromBottom),
                //         duration: new Duration(milliseconds: 500),
                //         curve: Curves.easeOut
                //       );
                //   }
                // }
                setState(() {
                  items.addAll(newEntries);
                  isPerformingRequest = false;
                });
              }
            }
          
        });
   
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(1.0),
      child: new Center(
        child: new Opacity(
          opacity: isPerformingRequest ? 1.0 : 0.0,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

  /// from - inclusive, to - exclusive
  Future<List<int>> fakeRequest(int from, int to) async {
      return List.generate(to - from, (i) => i + from);
  }
  Widget bodyData(context) {
    return  ListView.builder(
        itemCount: kolom.length,
        itemBuilder: (context, index) {
          if (index == items.length) {
            return _buildProgressIndicator();
          } else {
            return ListTile(
              title: new Card(
                color: Colors.black,
              elevation: 1.5,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                verticalDirection: VerticalDirection.down,
                children: <Widget>[
                  Padding(
                        padding: EdgeInsets.all(4.0),
                        child:  new Column(
                        children: [
                          Row(
                            children: <Widget>[
                              new Expanded(
                                child: Text(
                                  "Nomor Penukaran",
                                  style: TextStyle(
                                  fontFamily: UIData.ralewayFont,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.green,
                                  fontSize: 15.0),
                                ),
                                flex: 5,
                              ),
                              new Expanded(
                                child: Text(
                                  ":",
                                  style: TextStyle(
                                  fontFamily: UIData.ralewayFont,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.green,
                                  fontSize: 15.0),
                                  ),
                                flex: -1,
                              ),
                              new Expanded(
                                child: Text(
                                  kolom[index].id_payment,
                                  style: TextStyle(
                                  fontFamily: UIData.ralewayFont,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.green,
                                  fontSize: 15.0),
                                  ),
                                flex: 7,
                              ),
          
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              new Expanded(
                                child: Text(
                                  "Item ",
                                  style: TextStyle(
                                  fontFamily: UIData.ralewayFont,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.green,
                                  fontSize: 15.0),
                                ),
                                flex: 5,
                              ),
                              new Expanded(
                                child: Text(
                                  ":",
                                  style: TextStyle(
                                  fontFamily: UIData.ralewayFont,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.green,
                                  fontSize: 15.0),
                                  ),
                                flex: -1,
                              ),
                              new Expanded(
                                child: Text(
                                  kolom[index].tukar_point_title,
                                  style: TextStyle(
                                  fontFamily: UIData.ralewayFont,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.green,
                                  fontSize: 15.0),
                                  ),
                                flex: 7,
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              new Expanded(
                                child: Text(
                                  "Tanggal ",
                                  style: TextStyle(
                                  fontFamily: UIData.ralewayFont,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.green,
                                  fontSize: 15.0),
                                ),
                                flex: 5,
                              ),
                              new Expanded(
                                child: Text(
                                  ":",
                                  style: TextStyle(
                                  fontFamily: UIData.ralewayFont,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.green,
                                  fontSize: 15.0),
                                  ),
                                flex: -1,
                              ),
                              new Expanded(
                                child: Text(
                                  kolom[index].tanggal,
                                  style: TextStyle(
                                  fontFamily: UIData.ralewayFont,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.green,
                                  fontSize: 15.0),
                                  ),
                                flex: 7,
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              new Expanded(
                                child: Text(
                                  "Jam ",
                                  style: TextStyle(
                                  fontFamily: UIData.ralewayFont,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.green,
                                  fontSize: 15.0),
                                ),
                                flex: 5,
                              ),
                              new Expanded(
                                child: Text(
                                  ":",
                                  style: TextStyle(
                                  fontFamily: UIData.ralewayFont,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.green,
                                  fontSize: 15.0),
                                  ),
                                flex: -1,
                              ),
                              new Expanded(
                                child: Text(
                                  kolom[index].jam,
                                  style: TextStyle(
                                  fontFamily: UIData.ralewayFont,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.green,
                                  fontSize: 15.0),
                                  ),
                                flex: 7,
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              new Expanded(
                                child: Text(
                                  "Status ",
                                  style: TextStyle(
                                  fontFamily: UIData.ralewayFont,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.green,
                                  fontSize: 15.0),
                                ),
                                flex: 5,
                              ),
                              new Expanded(
                                child: Text(
                                  ":",
                                  style: TextStyle(
                                  fontFamily: UIData.ralewayFont,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.green,
                                  fontSize: 15.0),
                                  ),
                                flex: -1,
                              ),
                              new Expanded(
                                child: Text(
                                  kolom[index].status,
                                  style: TextStyle(
                                  fontFamily: UIData.ralewayFont,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.green,
                                  fontSize: 15.0),
                                  ),
                                flex: 7,
                              ),
                            ],
                          ),
                     
                      // CircleAvatar(
                      //   radius: 50.0,
                      //   backgroundColor: Colors.transparent,
                      //   backgroundImage: AssetImage('assets/logo.png'),
                      // ),
                      
                    ],
                  ),
                      ),
                 
                ],
              )
          )
              );
          }
        },
        controller: _scrollController,
      );
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      scaffoldKey: scaffoldKey,
      appTitle: "Payment",
      showDrawer: false,
      showFAB: false,
      actionFirstIcon: Icons.payment,
      bodyData: bodyData(context),
    );
  }
}
