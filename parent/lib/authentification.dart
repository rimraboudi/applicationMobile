
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'auth.dart';

//import 'package:flutter_facebook_login/flutter_facebook_login.dart';
//import 'package:provider/provider.dart';

class Authentification1 extends StatefulWidget {


  @override
  _Authentification1State createState() => _Authentification1State();
}

class _Authentification1State extends State<Authentification1> {
  //final String backImg ='images/pict1.png';
  bool formVisible;
  int _formsIndex;
//  final FacebookLogin _facebooklogin = new FacebookLogin();
//  final FirebaseAuth _auth = FirebaseAuth.instance;
//  final facebookLogin = FacebookLogin();
 // bool _isLoggedIn = false;
  Map userProfile;

  @override
  void initState() {
    super.initState();
    formVisible = false;
    _formsIndex = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/pict1.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Stack(
            children: <Widget>[
              Container(
                color: Colors.black54,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: kToolbarHeight + 40),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Bienvenue",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 30.0,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            "Application Mobile  \n Pour Vous",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 18.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: <Widget>[
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: RaisedButton(
                            color: Colors.red,
                            textColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Text("Se connecter"),
                            onPressed: () {
                              setState(() {
                                formVisible = true;
                                _formsIndex = 1;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 10.0),
//                        Expanded(
//                          child: RaisedButton(
//                            color: Colors.blue,
//                            textColor: Colors.white,
//                            elevation: 0,
//                            shape: RoundedRectangleBorder(
//                              borderRadius: BorderRadius.circular(20.0),
//                            ),
////                            icon: Icon(Icons.clear),
//                            child: Text("Se connecter avec Facebook"),
//                            onPressed: () {
////                              providers: [
////                                ChangeNotifierProvider(create: (_) => loginWithFB()),
////                              ];
////                               LoginWithFB();
//                            },
//                          ),
//                        ),

                        const SizedBox(width: 10.0),
                      ],
                    ),
                    const SizedBox(height: 40.0),

                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
              AnimatedSwitcher(
                duration: Duration(milliseconds: 200),
                child: (!formVisible)
                    ? null
                    : Container(
                  color: Colors.black54,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RaisedButton(
                            textColor: _formsIndex == 1
                                ? Colors.white
                                : Colors.black,
                            color:
                            _formsIndex == 1 ? Colors.red : Colors.white,
                            child: Text("Se connecter"),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            onPressed: () {
                              setState(() {
                                _formsIndex = 1;
                              });
                            },
                          ),


                          const SizedBox(width: 10.0),
                          IconButton(
                            color: Colors.white,
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              setState(() {
                                formVisible = false;
                              });
                            },
                          )
                        ],
                      ),
                      Container(
                        child: AnimatedSwitcher(
                          duration: Duration(milliseconds: 300),
                          child:
                         // _formsIndex == 1 ? LoginForm() : SignupForm(),
                          LoginForm(),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }





}

class LoginForm extends StatelessWidget {
  String email;
  String password;
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  authentification _auth1 = new authentification();

  String _validateName(String value) {
    if (value.isEmpty) return 'mot de passe est vide.';
    final RegExp nameExp = RegExp(r'^[A-Za-z ]+$');
    if (!nameExp.hasMatch(value))
      return 'Please enter only alphabetical characters.';
    return null;
  }

  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    // super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          TextFormField(

            decoration: const InputDecoration(
              border: UnderlineInputBorder(),

              icon: Icon(Icons.email),
              hintText: 'Entrer votre email',
              labelText: 'E-mail',
            ),
            keyboardType: TextInputType.emailAddress,
            onSaved: (String value) {
              this.email = value;
              print('email=$email');
            },
            controller: _emailTextController,

          ),
          const SizedBox(height: 10.0),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
                hintText: "Entrer votre mot de passe",
                labelText: 'Mot de passe',
                // border: OutlineInputBorder(),
                icon: new Icon(
                  Icons.lock,
                  color: Colors.grey,
                )
            ),

            validator: _validateName,
            onSaved: (value) => password = value.trim(),
            controller: _passwordTextController,
          ),
          const SizedBox(height: 10.0),
          RaisedButton(
            color: Colors.red,
            textColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text("connexion"),
            //onPressed:
            onPressed: () async {

              dynamic result = await _auth1.login(_emailTextController.text, _passwordTextController.text);
              if (result == null) {
              } else  {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return HomePage();
                    },
                  ),
                );
              }
            },
          ),
          RaisedButton(
            color: Colors.transparent,
            textColor: Colors.grey,
            elevation: 0,
            child: Text("Mot de passe oublié ?"),

            onPressed: () {
              reset_pass(email);
            },
          ),
//          Text(
//            "Mot de passe oublié ?",
//            style: TextStyle(
//              color: Colors.grey,
//              fontSize: 15.0,
//            ),
//            textAlign: TextAlign.center,
//          ),
        ],
      ),
    );
  }




  void signIn(BuildContext context) async {
    try {
      FocusScope.of(context).requestFocus(FocusNode());
      // widget.parentAction(true);
      final FirebaseUser firebaseUser = (await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: _emailTextController.text,
        password: _passwordTextController.text,
      )).user;

      if (firebaseUser != null) {
        Navigator.of(context).push(
            (MaterialPageRoute(builder: (context) => HomePage())));
        //save the firebaseUser in you prefs here
        //to do
      }
      else {
        print('Sign in error');
//         widget.parentAction(false);
      }
    } catch (e) {
      print(e.message);
      // widget.parentAction(false);
    }
  }

  void reset_pass(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
    print("Email à été envoyer avec Succes") ;
  }
}



class SignupForm extends StatelessWidget {
  const SignupForm({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              hintText: "Enter email",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10.0),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: "Enter password",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10.0),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: "Confirm password",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10.0),
          RaisedButton(
            color: Colors.green,
            textColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text("Signup"),
            onPressed: () {
            },
          ),
        ],
      ),
    );
  }
}

