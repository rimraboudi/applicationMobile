import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Repas extends StatefulWidget {
  @override
  _RepasState createState() => _RepasState();
}

class _RepasState extends State<Repas> {
  DatabaseReference _firebaseMsgDbRef;
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  TextEditingController _eventController;
  SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _eventController = TextEditingController();
    _events = {};
    _selectedEvents = [];
    initPrefs();
    this._firebaseMsgDbRef = FirebaseDatabase.instance
        .reference()
        .child('repas');
  }

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
          title: const Text('Repas'),
        ),
        body: Column(
          children: [
            _buildMessagesList(),
          ],
        ),

//      SingleChildScrollView(
//        child: Column(
//        crossAxisAlignment: CrossAxisAlignment.start,
//        children: <Widget>[
//          TableCalendar(
//           // events: _events,
//            initialCalendarFormat: CalendarFormat.week,
//            calendarStyle: CalendarStyle(
//                canEventMarkersOverflow: true,
//                todayColor: Colors.orange,
//                selectedColor: Theme.of(context).primaryColor,
//                todayStyle: TextStyle(
//                    fontWeight: FontWeight.bold,
//                    fontSize: 18.0,
//                    color: Colors.white)),
//            headerStyle: HeaderStyle(
//              centerHeaderTitle: true,
//              formatButtonDecoration: BoxDecoration(
//                color: Colors.orange,
//                borderRadius: BorderRadius.circular(20.0),
//              ),
//              formatButtonTextStyle: TextStyle(color: Colors.white),
//              formatButtonShowsNext: false,
//            ),
//            startingDayOfWeek: StartingDayOfWeek.monday,
//            onDaySelected: (date, events) {
////              setState(() {
////                _selectedEvents = events;
////              });
//            },
//            builders: CalendarBuilders(
//              selectedDayBuilder: (context, date, events) => Container(
//                  margin: const EdgeInsets.all(4.0),
//                  alignment: Alignment.center,
//                  decoration: BoxDecoration(
//                      color: Theme.of(context).primaryColor,
//                      borderRadius: BorderRadius.circular(10.0)),
//                  child: Text(
//                    date.day.toString(),
//                    style: TextStyle(color: Colors.white),
//                  )),
//              todayDayBuilder: (context, date, events) => Container(
//                  margin: const EdgeInsets.all(4.0),
//                  alignment: Alignment.center,
//                  decoration: BoxDecoration(
//                      color: Colors.orange,
//                      borderRadius: BorderRadius.circular(10.0)),
//                  child: Text(
//                    date.day.toString(),
//                    style: TextStyle(color: Colors.white),
//                  )),
//            ),
//            calendarController: _controller,
////            if(date.day.toString()==StartingDayOfWeek.monday){
////
////            }
//          ),
//          ..._selectedEvents.map((event) => ListTile(
//            title: Text(event),
//          )),
        //  SizedBox(height:10,),

//          Column(
//          children: <Widget>[
        // _buildMessagesList(),
//            ],
//          ),
      ),

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
  Widget _messageFromSnapshot(
      DataSnapshot snapshot, Animation<double> animation) {
    final String day = snapshot.value['jour'] ?? '?? <unknown>';
    final String entree = snapshot.value['entree'] ?? '??';
    final String plat = snapshot.value['plat'] ?? "??";
    final String dessert = snapshot.value['dessert'] ?? "??";

    print(snapshot.value);
    final messageUI = Padding(
      padding: EdgeInsets.symmetric(vertical: 50.0,horizontal: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

//      Column(
//      crossAxisAlignment: CrossAxisAlignment.start,
//        children: <Widget>[


//          Text( 'Jour:  '+ day,
//              style: TextStyle(
//                fontSize: 15.0,)
//          ),

//          Row(
//              children: <Widget>[
          /* Expanded(
             // flex: 2,
                child:  Container(
                    child: Container(
                  //  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  *//*  decoration: const BoxDecoration(

//                    border: Border(
//                    top: BorderSide(width: 1.0, color: Color(0xFFFFDFDFDF)),
//                    left: BorderSide(width: 1.0, color: Color(0xFFFFDFDFDF)),
//                    right: BorderSide(width: 1.0, color: Color(0xFFFF7F7F7F)),
//                    bottom: BorderSide(width: 1.0, color: Color(0xFFFF7F7F7F)),
//                    ),
                    color: Color(0xFFBFBFBF),
                        ),*//*
                     child:  Text( 'Jour:  '+ day,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                     // height: 50,
                      color: Color(0xFF000000),
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,)
                    ),
                    ),

                    ),
              ),*/
//              ],
//          ),

          Container(
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Jour:  '+ day),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      icon: Icon(Icons.restaurant_menu, size: 30.0 ,color: Colors.red,),

                    ),
                  ),
                ),
                Container(

                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Padding(
                          padding:
                          const EdgeInsets.all(8.0),
                          child: Text(
                            'entree  '+ entree + '\n' +'plat  '+plat+ '\n' +'dessert  '+dessert,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),

              ],
            ),
          ),





          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                        icon: Icon(
                          Icons.thumb_up,
                          color: Colors.blueAccent,
                          size: 25.0,
                        ),
                        onPressed: () {} ),
                  ),
                ),
                //),
              ],
            ),
          ),
//              ],
//              ),
//],
//      ),



//

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