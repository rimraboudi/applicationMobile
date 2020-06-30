import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import'package:flutter/material.dart';



class ContenuePeda extends StatefulWidget {
  @override
  _ContenuePedaState createState() => _ContenuePedaState();
}

class _ContenuePedaState extends State<ContenuePeda> {
  DatabaseReference _firebaseMsgDbRef;

  @override
  void initState() {
    this._firebaseMsgDbRef = FirebaseDatabase.instance
        .reference()
        .child('contenus');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {


    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Contenue Pedagogiques"),
            actions: <Widget>[

            ],
          ),
          body: Column(
            children: [
              _buildMessagesList(),
            ],
          ),



        )
    );
  }

  Widget _buildMessagesList() {
    return Flexible(
      child: Scrollbar(
        child: FirebaseAnimatedList(
          defaultChild: Center(child: CircularProgressIndicator()),
          query: _firebaseMsgDbRef,
          sort: (a, b) => b.key.compareTo(a.key),
          padding: EdgeInsets.all(8.0),
          reverse: true,
          itemBuilder: (BuildContext ctx, DataSnapshot snapshot,
              Animation<double> animation, int idx) =>
              _messageFromSnapshot(snapshot, animation),
        ),
      ),
    );
  }
//
//  // Returns the UI of one message from a data snapshot.
  Widget _messageFromSnapshot(
      DataSnapshot snapshot, Animation<double> animation) {
    final String nom = snapshot.value['nom'] ?? '?? <unknown>';
    final String doc = snapshot.value['file'] ?? '??';
   // final String heure = snapshot.value['heure'] ?? "??";
    //  thequestion =snapshot.value['Question']??'??';
   // final String lieu = snapshot.value['lieu'] ?? "??";
  //  final String desc = snapshot.value['description'] ?? "??";

   // final String type = snapshot.value['type'] ?? "??";
    print(snapshot.value);
    final messageUI = Padding(
      padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0) ,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Text("Nom: "+nom,
                  style: new TextStyle(fontSize: 22.0)),

              Text("Documents: \n"+doc, style: new TextStyle(fontSize: 22.0)),



//                  Text("Heure: "+heure, style: new TextStyle(fontSize: 22.0)),
//
//              Text("Lieu: "+lieu, style: new TextStyle(fontSize: 22.0)),
//              Text("Type: "+type, style: new TextStyle(fontSize: 22.0)),


            ],
          ),


        ],
      ),
    );
    return SizeTransition(
      sizeFactor: CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut,
      ),
      //axisAlignment: 0.0,
      child: messageUI,
    );
  }
}