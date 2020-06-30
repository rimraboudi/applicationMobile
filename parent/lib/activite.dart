import 'dart:convert';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_database/firebase_database.dart';


class Activite extends StatefulWidget {
  @override
  _ActiviteState createState() => _ActiviteState();
}

class _ActiviteState extends State<Activite> {

  // final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  DatabaseReference _firebaseMsgDbRef;


  @override
  void initState() {
    super.initState();
    //_checkEmailVerification();
    // _actList = new List();
    this._firebaseMsgDbRef = FirebaseDatabase.instance
        .reference()
        .child('activite');

    _controller = CalendarController();
    _eventController = TextEditingController();
    _events = {};
    _selectedEvents = [];
    initPrefs();
  }



  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  TextEditingController _eventController;
  SharedPreferences prefs;

  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _events = Map<DateTime, List<dynamic>>.from(
          decodeMap(json.decode(prefs.getString("events") ?? "{}")));
    });
  }
  Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
    Map<String, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[key.toString()] = map[key];
    });
    return newMap;
  }

  Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
    Map<DateTime, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[DateTime.parse(key)] = map[key];
    });
    return newMap;
  }

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Activités"),

          ),
          body: Column(
            children: [
              _buildMessagesList(),
            ],
          ),



        )
    );
//    final productProvider = Provider.of<CRUDModel>(context);
    //  final ref = _database.reference();
//    return DefaultTabController(
//        length: 2,
//        child: Scaffold(
//      appBar: AppBar(
//        title: Text('Activités'),
//      ),
//      body:
//        Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: <Widget>[
//            TableCalendar(
//              //events: _events,
//              initialCalendarFormat: CalendarFormat.week,
//              calendarStyle: CalendarStyle(
//                  canEventMarkersOverflow: true,
//                  todayColor: Colors.orange,
//                  selectedColor: Theme.of(context).primaryColor,
//                  todayStyle: TextStyle(
//                      fontWeight: FontWeight.bold,
//                      fontSize: 18.0,
//                      color: Colors.white)),
//              headerStyle: HeaderStyle(
//                centerHeaderTitle: true,
//                formatButtonDecoration: BoxDecoration(
//                  color: Colors.orange,
//                  borderRadius: BorderRadius.circular(20.0),
//                ),
//                formatButtonTextStyle: TextStyle(color: Colors.white),
//                formatButtonShowsNext: false,
//              ),
//              startingDayOfWeek: StartingDayOfWeek.monday,
//              onDaySelected: (date, events) {
//                print(date.toIso8601String());
////                setState(() {
////                  _selectedEvents = events;
////                });
//              },
//              builders: CalendarBuilders(
//                selectedDayBuilder: (context, date, events) => Container(
//                    margin: const EdgeInsets.all(4.0),
//                    alignment: Alignment.center,
//                    decoration: BoxDecoration(
//                        color: Theme.of(context).primaryColor,
//                        borderRadius: BorderRadius.circular(10.0)),
//                    child: Text(
//                      date.day.toString(),
//                      style: TextStyle(color: Colors.white),
//                    )
//
//                ),
//                todayDayBuilder: (context, date, events) => Container(
//                    margin: const EdgeInsets.all(4.0),
//                    alignment: Alignment.center,
//                    decoration: BoxDecoration(
//                        color: Colors.orange,
//                        borderRadius: BorderRadius.circular(10.0)),
//                    child: Text(
//                      date.day.toString(),
//                      style: TextStyle(color: Colors.white),
//                    )),
//              ),
//              calendarController: _controller,
//            ),

    // SizedBox(height: 22,),

//            Column(
//              children: [
    // _buildMessagesList(),
//              ],
//            ),

//
//          ],
//        ),
//
//     // ),
//
//
//),
//
//    );

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

  Widget _messageFromSnapshot(
      DataSnapshot snapshot, Animation<double> animation) {
    final String nom = snapshot.value['nom'] ?? '?? <unknown>';
    final String date = snapshot.value['date'] ?? '??';
    final String heure = snapshot.value['heure'] ?? "??";
    //  thequestion =snapshot.value['Question']??'??';
    final String lieu = snapshot.value['lieu'] ?? "??";
    final String desc = snapshot.value['description'] ?? "??";
    final String type = snapshot.value['type'] ?? "??";
    print(snapshot.value);
    final messageUI = Padding(
      padding: EdgeInsets.symmetric(vertical: 50.0,horizontal: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
//          Column(
//            crossAxisAlignment: CrossAxisAlignment.start,
//            children: <Widget>[
//
//              Text("Nom: "+nom, style: new TextStyle(fontSize: 22.0)),
//
//                  Text("Date: "+date, style: new TextStyle(fontSize: 22.0)),
//                  Text("Heure: "+heure, style: new TextStyle(fontSize: 22.0)),
//
//              Text("Lieu: "+lieu, style: new TextStyle(fontSize: 22.0)),
//              Text("Type: "+type, style: new TextStyle(fontSize: 22.0)),
//            ],
//          ),
//      Row(
//              children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey,
                  width: 5.0,),
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Nom:  "+ nom,
                              style: TextStyle(
                                color: Colors.indigoAccent,
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                              )),
                        )),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          Container(
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.all(8.0),
                                    child: Text( date,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          Container(
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.all(8.0),
                                    child: Text( lieu,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          Container(
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.all(5.0),
                                    child: Text("Type:  "+ type,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(
                                icon: Icon(
                                  Icons.thumb_up,
                                  color: Colors.blue,
                                  size: 25.0,
                                ),
                                onPressed: (){

                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ]),
            ),
          ),


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





