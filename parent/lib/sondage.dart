import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';


class Sondage extends StatefulWidget {
  @override
  _SondageState createState() => _SondageState();
}

class _SondageState extends State<Sondage> {
  DatabaseReference _firebaseMsgDbRef;
 //  String thequestion;
  String _group2SelectedValue;


  @override
  void initState() {
    _group2SelectedValue = " ";
    this._firebaseMsgDbRef = FirebaseDatabase.instance
        .reference()
        .child('sondage');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sondage'),
        ),
      body: Column(
//        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//        mainAxisSize: MainAxisSize.max,
//        crossAxisAlignment: CrossAxisAlignment.stretch,
//            child: ListView(
              children: <Widget>[
                _buildMessagesList(),
//                Text("thequestion",
//                    style: new TextStyle(fontSize: 22.0)),
//                ListTile(
//                  title: Text("Oui"),
//                  leading: Radio(
//                      value: "Oui",
//                      groupValue: _group2SelectedValue,
//                      onChanged: _group2Changes),
//                ),
//                ListTile(
//                  title: Text("Non"),
//                  leading: Radio(
//                      value: "Non",
//                      groupValue: _group2SelectedValue,
//                      onChanged: _group2Changes),
//                ),
//
//                Center(
////                    child: RichText(
////                        text: TextSpan(
////                            text: "Votre Réponse : ",
////                            style:TextStyle(fontSize: 24, color: Colors.orange) ,
////                            children: <TextSpan>[
////                              TextSpan(
////                                  text: '$_group2SelectedValue ',
////                                  style: TextStyle(fontSize: 24)),
////                            ]))
////                  child: _buildMessagesList()
//                ),
////
              ],
//            ),
          ),
//          _buildMessagesList(),
      //  ],
    //  ),
    );
  }

  void _group2Changes(String value) {
    setState(() {
      _group2SelectedValue = value;
    });
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
    final String question = snapshot.value['Question'] ?? '?? <unknown>';
    final String reponse1 = snapshot.value['rep1'] ?? '??';
   //  thequestion =snapshot.value['Question']??'??';
    print(snapshot.value);
//    print(reponse1);
//    final sentTime = snapshot.value['timestamp'] ?? '<unknown timestamp>';
    final String reponse2 = snapshot.value['rep2'] ?? "??";
//    print('printing 2');
//    print(reponse2);
    final messageUI = Padding(
      padding: EdgeInsets.symmetric(vertical: 50.0,horizontal: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

//          Flexible(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
//                Expanded(
//                  child: ListView(
//                  children: <Widget>[
                Text("Question: \n"+question+ "?\n",
                    style: new TextStyle(fontSize: 22.0)),
                  //ListTile(
                 Row(
                    children: <Widget>[
                Radio(
                    value: "reponse1",
                    groupValue: _group2SelectedValue,
                    onChanged: _group2Changes),
                Text(reponse1, style: new TextStyle(fontSize: 22.0)),
      ],
                ),
                Row(
                  children: <Widget>[
                    Radio(
                        value: "reponse2",
                        groupValue: _group2SelectedValue,
                        onChanged: _group2Changes),
                    Text(reponse2, style: new TextStyle(fontSize: 22.0)),

                  ],
                ),
              ],
            ),
//    ),
//    ],
//          ),
        //  ),
        ],
      ),
    );
    return SizeTransition(
      sizeFactor: CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut,
      ),
      axisAlignment: 0.0,
      child: messageUI,
    );
  }

}



