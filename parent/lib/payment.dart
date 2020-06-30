import 'package:flutter/material.dart';


class Payment extends StatefulWidget {
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Paiement"),
            actions: <Widget>[

            ],
          ),
          body: Column(
//            child: Column(
//              crossAxisAlignment: CrossAxisAlignment.start,
            children: [
//              TextFormField(
//                validator: (value) {
//                  if (value.isEmpty) {
//                    return 'Veuillez saisir un texte';
//                  }
//                  return null;
//                },
//              ),
//              TextFormField(
//                decoration: InputDecoration(
//                    labelText: 'Enter your username'
//                ),
//              ),
              SizedBox(height: 22,),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
//              prefixIcon: Padding(
//                padding: EdgeInsets.all(0.0),
//                child: Icon(Icons.person,
//                    size: 40.0, color: Colors.white),
//              ),
                    hintText: "Entrer le nom présent sur votre carte" ,
                    hintStyle: TextStyle(color: Colors.black38),
//                    border: OutlineInputBorder(
//                        borderRadius:
//                        BorderRadius.all(new Radius.circular(25.0))),
                    labelStyle: TextStyle(color: Colors.white)),
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                ),
                // controller: host,
//                validator: (value) {
//                  if (value.isEmpty) {
//                    return "Empty value";
//                  }
//                },
              ),

              SizedBox(height: 22,),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
//                    prefixIcon: Padding(
//                      padding: EdgeInsets.all(0.0),
//                      child: Icon(Icons.person,
//                          size: 40.0, color: Colors.white),
//                    ),
                    hintText: "Entrer votre numéro de carte",
                    hintStyle: TextStyle(color: Colors.black38),
//                    border: OutlineInputBorder(
//                        borderRadius:
//                        BorderRadius.all(new Radius.circular(25.0))),
                    labelStyle: TextStyle(color: Colors.white)),
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                ),
                // controller: host,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Empty value";
                  }
                },
              ),
              SizedBox(height: 22,),

              TextFormField(
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
//                    prefixIcon: Padding(
//                      padding: EdgeInsets.all(0.0),
//                      child: Icon(Icons.person,
//                          size: 40.0, color: Colors.white),
//                    ),
                    hintText: "MM/AA",
                    hintStyle: TextStyle(color: Colors.black38),
//                    border: OutlineInputBorder(
//                        borderRadius:
//                        BorderRadius.all(new Radius.circular(25.0))),
                    labelStyle: TextStyle(color: Colors.white, height: 50)),
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black,
                  //height: 50,
                  fontSize: 20.0,
                ),
                // controller: host,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Empty value";
                  }
                },
              ),
              SizedBox(height: 22,),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
//              prefixIcon: Padding(
//                padding: EdgeInsets.all(0.0),
//                child: Icon(Icons.person,
//                    size: 40.0, color: Colors.white),
//              ),

                    hintText: "CVV" ,
                    hintStyle: TextStyle(color: Colors.black38,),
//                    border: OutlineInputBorder(
//                        borderRadius:
//                        BorderRadius.all(new Radius.circular(25.0))),
                   // labelStyle: TextStyle(color: Colors.white)
                ),
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                ),
                // controller: host,

              ),
              SizedBox(height: 22,),
//              Padding(
//                padding: const EdgeInsets.symmetric(vertical: 16.0),
              RaisedButton(
                color: Colors.blue,
                textColor: Colors.white,
                elevation: 0,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),

                ),
                child: Text("Payer"),
                onPressed: () {

                },
              ),
              // ),
            ],
          ),



        )
    );
  }
}