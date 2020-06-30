import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'dart:async';

// C.f. this commit: https://github.com/X-Wei/flutter_catalog/commit/48792cbc0de62fc47e0e9ba2cd3718117f4d73d1.
class Chatroom extends StatefulWidget {
  const Chatroom({Key key}) : super(key: key);

  @override
  _ChatroomState createState() =>
      _ChatroomState();
}

class _ChatroomState extends State<Chatroom> {
  FirebaseUser _user;
  DatabaseReference _firebaseMsgDbRef;

  final TextEditingController _textController = TextEditingController();
  bool _isComposing = false;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now().toUtc();
    this._firebaseMsgDbRef = FirebaseDatabase.instance
        .reference().child('message');
//        .child('messages/${now.year}/${now.month}/${now.day}');
//    FirebaseAuth.instance.currentUser().then(
//          (user) => setState(() {
//        this._user = user;
//      }),
//    );
  }

  final _formKey = GlobalKey<FormState>();

  int _selectedGender = 0;

  List<DropdownMenuItem<int>> genderList = [];

//

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
//      appBar: new AppBar(
////        title: new Text(widget.title),
//        actions: <Widget>[
//          new IconButton(icon: const Icon(Icons.save), onPressed: () {})
//        ],
//      ),
      body: new Column(
        children: <Widget>[
          new ListTile(
            leading: const Icon(Icons.person),
            title: new TextField(
              decoration: new InputDecoration(
                hintText: "Destinataires",
              ),
            ),
          ),
          new ListTile(
            leading: const Icon(Icons.mail),
            title: new TextField(
              decoration: new InputDecoration(
                hintText: "Objet",
              ),
            ),
          ),
          new ListTile(
            leading: const Icon(Icons.email),
            title: new TextField(
              decoration: new InputDecoration(
                hintText: "Message",
              ),
            ),
          ),

          const Divider(
            height: 1.0,
          ),
          _buildMessagesList(),
        ],
      ),
    );
  }

//  List<Widget> getFormWidget() {
//    List<Widget> formWidget = new List();
//
//    formWidget.add(new DropdownButton(
//      hint: new Text('Select Gender'),
//      items: genderList,
//      value: _selectedGender,
//      onChanged: (value) {
//        setState(() {
//          _selectedGender = value;
//        });
//      },
//      isExpanded: true,
//    ));
//
//    return formWidget;
//  }

//  void _showNoteDialog(BuildContext context) {
//    showDialog(
//      context: context,
//      builder: (ctx) => AlertDialog(
//        title: Text('Note'),
//        content: Text('This chat room is only for demo purposes.\n\n'
//            'The chat messages are publicly available, and they '
//            'can be deleted at any time by the firebase admin.\n\n'
//            'To send messages, you must log in '
//            'in the "Firebase login" demo.'),
//        actions: <Widget>[
//          FlatButton(
//            child: Text('OK'),
//            onPressed: () => Navigator.of(ctx).pop(),
//          )
//        ],
//      ),
//    );
//  }

  // Builds the list of chat messages.
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

  // Returns the UI of one message from a data snapshot.
  Widget _messageFromSnapshot(
      DataSnapshot snapshot, Animation<double> animation) {
//    final String senderName = snapshot.value['dest'] ?? '?? <unknown>';
    final String msgText = snapshot.value['objet'] ?? '??';
    final sentTime = snapshot.value['msg'] ?? '<unknown timestamp>';
//    final String senderPhotoUrl = snapshot.value['senderPhotoUrl'];
    final messageUI = Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
//          Padding(
//            padding: EdgeInsets.only(right: 8.0),
//            child: senderPhotoUrl != null
//                ? CircleAvatar(
//              backgroundImage: NetworkImage(senderPhotoUrl),
//            )
//                : CircleAvatar(
//              child: Text(senderName[0]),
//            ),
//          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Message: '+sentTime, style: Theme.of(context).textTheme.subhead),
//                Text(
//                  DateTime.fromMillisecondsSinceEpoch(sentTime).toString(),
//                  style: Theme.of(context).textTheme.caption,
//                ),
                Text('Objet: '+msgText),
              ],
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

  // Builds the row for composing and sending message.
  Widget _buildComposeMsgRow() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(color: Theme.of(context).cardColor),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.camera_alt),
              onPressed: () async {

              }
          ),
          Flexible(
            child: TextField(
              keyboardType: TextInputType.multiline,
              // Setting maxLines=null makes the text field auto-expand when one
              // line is filled up.
              maxLines: null,
              maxLength: 200,
              decoration: InputDecoration.collapsed(hintText: "Send a message"),
              controller: _textController,
              onChanged: (String text) =>
                  setState(() => _isComposing = text.length > 0),
              onSubmitted: _onTextMsgSubmitted,
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: _isComposing
                ? () => _onTextMsgSubmitted(_textController.text)
                : null,
          ),
        ],
      ),
    );
  }

  // Triggered when text is submitted (send button pressed).
  Future<Null> _onTextMsgSubmitted(String text) async {
    // Make sure _user is not null.
    if (this._user == null) {
      this._user = await FirebaseAuth.instance.currentUser();
    }
    if (this._user == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Login required'),
          content: Text('To send messages you need to first log in.\n\n'
              'Go to the "Firebase login" example, and log in from there. '
              'You will then be able to send messages.'),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(ctx).pop(),
            )
          ],
        ),
      );
      return;
    }
    // Clear input text field.
    _textController.clear();
    setState(() {
      _isComposing = false;
    });
    // Send message to firebase realtime database.
    _firebaseMsgDbRef.push().set({
      'senderId': this._user.uid,
      'senderName': this._user.email,
      'senderPhotoUrl': this._user.photoUrl,
      'text': text,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });
//    kFirebaseAnalytics.logEvent(name: 'send_message');
  }




}