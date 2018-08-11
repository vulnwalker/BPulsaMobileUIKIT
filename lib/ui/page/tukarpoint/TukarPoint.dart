import 'package:flutter/material.dart';
import 'package:bpulsa/logic/bloc/TukarPointBloc.dart';
import 'package:bpulsa/model/TukarPointModel.dart';
import 'package:bpulsa/ui/widgets/common_scaffold.dart';

class TukarPoint extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();

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

  Widget tukarPointGrid(List<TukarPointModel> tukarPointModels) => GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        children: tukarPointModels
            .map((tukarPoint) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    splashColor: Colors.yellow,
                    onDoubleTap: () => showSnackBar(),
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

  Widget bodyData() {
    TukarPointBloc tukarPointBloc = TukarPointBloc();
    return StreamBuilder<List<TukarPointModel>>(
        stream: tukarPointBloc.tukarPointItems,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? tukarPointGrid(snapshot.data)
              : Center(child: CircularProgressIndicator());
        });
  }

  void showSnackBar() {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        "Added to cart.",
      ),
      action: SnackBarAction(
        label: "Undo",
        onPressed: () {},
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      scaffoldKey: scaffoldKey,
      appTitle: "Tukar Point",
      showDrawer: false,
      showFAB: false,
      actionFirstIcon: Icons.shopping_cart,
      bodyData: bodyData(),
    );
  }
}
