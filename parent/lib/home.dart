library rflutter_alert;
import 'dart:ui';

import 'package:parent/profil.dart';

import 'chat.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'contenupeda.dart';
import 'payment.dart';
import 'repas.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'activite.dart';
import 'sondage.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final fb = FirebaseDatabase.instance;
  final _textEditingController = TextEditingController();


  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    Container(
    decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("images/back.png"), fit: BoxFit.cover)
    ),
    );
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          actions: <Widget>[
          ],
          title: Text('teflii'),
          bottom: TabBar(
            indicatorColor: Colors.red,
            tabs: <Widget>[
              Tab(
                //text: 'Acceuil',
                icon: Icon(Icons.menu, size: 30,),
              ),
              Tab(
                //text: 'Planification',
                icon: Icon(Icons.calendar_view_day, size: 30,),
              ),
              Tab(
                //text: 'contact',
                icon: Icon(Icons.chat, size: 30,),
              ),
              Tab(
                // text: 'Notification',
                icon: Icon(Icons.notifications_none, size: 30,),

                // onTap: () => _showImageDialog(context, mountEverest),
              ),
              Tab(


                child: Hero(
                  tag: 'wifek',
                  child: ClipRRect(
                    child: GestureDetector(
                      //onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Profile_chauffeur()));},
                      child: Container(
                        width: 70.0,
                        height: 70.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('images/pict2.jpg'),
                              fit: BoxFit.cover),
                          color: Colors.white,
                          shape: BoxShape.circle,

                        ),
                      ),
                      onTap: () => _showSecondPage(context),
                    ),


                  ),
                ),
              ),

            ],
          ),

        ),

        body: TabBarView(
          children: <Widget>[
            Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: <Widget>[
                    Card(
                      child: Container(
                        //alignment: Alignment.topLeft,
                          padding: EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
//                            Navigator.push(context, MaterialPageRoute(
//                                builder: (context) => reclam()
//                            ),
//                            );
//                          },
                           // onPressed: () async {
                              // The function showDialog<T> returns Future<T>.
                              // Use Navigator.pop() to return value (of type T).
                               showDialog<String>(
                             // showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                        title: const Text('Votre réclamation'),
                                        content: TextField(

                                          controller: _textEditingController,
                                        ),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text('Cancel'),
                                            onPressed: () =>
                                                Navigator.pop(context, 'Cancel'),
                                          ),
                                          FlatButton(
                                            child: Text('Envoyer'),
                                            onPressed: () {
                                                      fb.reference().child("reclamation").push().set({
                                                      "description": _textEditingController.text,
                                                    });
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      )).then((returnVal) {
                                if (returnVal != null) {
                                  Scaffold.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('You clicked:'),
                                      action: SnackBarAction(
                                          label: 'OK', onPressed: () {}),
                                    ),
                                  );
                                }
                              });
//                setState(() {
//                _selectedEvents = _events[_controller.selectedDay];
//                });

                            },
                            splashColor: Colors.green,
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Icon(Icons.thumb_up, size: 70,
                                    color: Colors.lime,),
                                  Text("Réclamation",
                                      style: new TextStyle(fontSize: 17.0))
                                ],
                              ),
                            ),
                          )
                      ),
                    ),

                    Card(
                      child: Container(
                        //alignment: Alignment.topLeft,
                          padding: EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => Sondage()
                              ),
                              );
                            },
                            splashColor: Colors.green,
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Icon(Icons.help, size: 70, color: Colors.pink,),
                                  Text("Sondage",
                                      style: new TextStyle(fontSize: 17.0))
                                ],
                              ),
                            ),
                          )
                      ),
                    ),
                    Card(
                      child: Container(
                        //alignment: Alignment.topLeft,
                          padding: EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
//                              Navigator.push( context, MaterialPageRoute(
//                                builder: (context) => act()
//                            ),
//                            );
                            },
                            splashColor: Colors.green,
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Icon(Icons.extension, size: 70,
                                    color: Colors.teal,),
                                  Text("Jeux",
                                      style: new TextStyle(fontSize: 17.0))
                                ],
                              ),
                            ),
                          )
                      ),
                    ),
//                    NotificationIconBuild(),
                    Container(
                      padding: const EdgeInsets.only(right: 50,
                      ),
                    ),


                    FloatingActionButton(
                        child: const Icon(Icons.favorite, size: 35.0,),
                        backgroundColor: Colors.purpleAccent,
                        onPressed: () {
                          Alert(
                           // style: ,
                            context: context,
                            title: "Conseil pour vous",
                            desc: "jouer est absolument indispensable à la construction "
                                "de l'enfant et à son intégration dans la société.",
                            image: Image.asset("images/pict2.jpg"),
                          ).show();
                          // The function showDialog<T> returns Future<T>.
                          // Use Navigator.pop() to return value (of type T).
//                        showDialog<String>(
//                          context: context,
//                          builder: (BuildContext context) =>
//                              AlertDialog(
//                                title: const Text('Dialog title'),
////                                content: Text(
////                                  'Sample alert',
////                                ),
////                                image: AssetImage('images/pict2.jpg'),
//                                actions: <Widget>[
//                                  FlatButton(
//                                    child: Text('Cancel'),
//                                    onPressed: () =>
//                                        Navigator.pop(context, 'Cancel'),
//                                  ),
//                                  FlatButton(
//                                    child: Text('OK'),
//                                    onPressed: () =>
//                                        Navigator.pop(context, 'OK'),
//                                  ),
//                                ],
//                              ),
//                        ).then((returnVal) {
//                          if (returnVal != null) {
//                            Scaffold.of(context).showSnackBar(
//                              SnackBar(
//                                content: Text('You clicked: $returnVal'),
//                                action: SnackBarAction(
//                                    label: 'OK', onPressed: () {}),
//                              ),
//                            );
//                          }
//                        });
                        }
                        ),


                  ],
                ),
              ),
            ),
            Container(
              //color: Colors.grey,
              child: Column(
               // alignment: Alignment.topLeft,
                children: <Widget>[
                  Card(
                    elevation: 0.0,
                   // color: Colors.redAccent,
                    child: Container(
                      height: 200.0,
//                        width: 150.0,
                        //padding: EdgeInsets.all(8.0),
                      child: InkWell(
                      //alignment: Alignment.topLeft,

                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => Activite()
                            ),
                            );
                          },
                          splashColor: Colors.green,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(Icons.calendar_today, size: 70,
                                  color: Colors.redAccent,),
                                Text("Activités",
                                    style: new TextStyle(fontSize: 17.0))
                              ],
                            ),
                          ),
                        )
                    ),
                  ),
                  Card(
                    child: Container(
                        height: 200.0,
                      //alignment: Alignment.topLeft,
                        padding: EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => Repas()
                            ),
                            );
                          },
                          splashColor: Colors.green,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(Icons.fastfood, size: 70,
                                  color: Colors.cyan,),
                                Text("Repas",
                                    style: new TextStyle(fontSize: 17.0))
                              ],
                            ),
                          ),
                        )
                    ),
                  ),



                ],
              ),


            ),

            new Container(

              child: Chatroom(),
//
            ),
            Container(


              ),

            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(
                        left: 12.0, bottom: 9.0, top: 50.0),
                    alignment: Alignment.topLeft,
                    color: Colors.transparent,

                  ),

                 // Card(
//                    child: Container(
//                        decoration: BoxDecoration(
////                          border: ,
//                          borderRadius: BorderRadius.circular(30.0),
//                          color: Colors.white,
//                        ),
//                      //alignment: Alignment.topLeft,
//                        padding: EdgeInsets.all(8.0),
//                        child: InkWell(
//                          onTap: () {
//                            Navigator.push(context, MaterialPageRoute(
//                                builder: (context) => ContenuePeda()
//                            ),
//                            );
//                          },
//                          splashColor: Colors.green,
//                          child: Center(
//                            child: Column(
//                              mainAxisSize: MainAxisSize.min,
//                              children: <Widget>[
//                                Icon(Icons.folder, size: 70,
//                                  color: Colors.black87,),
//                                Text("Contenues Pedagpgiques",
//                                    style: new TextStyle(fontSize: 17.0))
//                              ],
//                            ),
//                          ),
//                        )
//                    ),
//                  ),
                  Card(
//                    color: Colors.green,
                    margin: EdgeInsets.all(20.0),
                    elevation: 0.0,
                    child: Container(
                      height: 70.0,
                      child: InkWell(
                        splashColor: Colors.deepOrange,
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                                builder: (context) => ContenuePeda()
                            ),
                            );
                        },
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.folder, size: 40,
                              color: Colors.black87,),
                            Expanded(
                              child: Text('Contenues Pedagpgiques'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
//                    color: Colors.green,
                    margin: EdgeInsets.all(20.0),
                    elevation: 0.0,
                    child: Container(
                      height: 70.0,
                      child: InkWell(
                        splashColor: Colors.deepOrange,
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => Profile()
                          ),
                          );
                        },
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.person_pin, size: 40,
                              color: Colors.black87,),
                            Expanded(
                              child: Text('Mon profile'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 12.0, bottom: 9.0, top: 50.0),
                    alignment: Alignment.topLeft,
                    color: Colors.transparent,
                  ),
                  Card(
//                    color: Colors.green,
                    margin: EdgeInsets.all(20.0),
                    elevation: 0.0,
                    child: Container(
                      height: 70.0,
                      child: InkWell(
                        splashColor: Colors.deepOrange,
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.power_settings_new, size: 40,
                              color: Colors.black87,),
                            Expanded(
                              child: Text('Déconnexion'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

//Widget NotificationIconBuild() {
//  return Column(
//      children: [
//        IconButton(
//          icon: Icon(Icons.notifications),
//          onPressed: () {},
//        ),
//      ]);
//}
void _showSecondPage(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (ctx) =>
          Scaffold(
            body: Center(
               child: Hero(
                  tag: 'my-hero-animation-tag',
                  child: Image.asset('images/pict2.jpg'),
                ),
          ),
          ),
    ),
  );
}
}