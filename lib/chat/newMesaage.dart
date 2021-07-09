
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helpy/Doctor/doctor_profile.dart';

class NewMessages extends StatefulWidget {
  String iD;
  NewMessages(this.iD);
  _NewMessagesState createState() => _NewMessagesState();
}

class _NewMessagesState extends State <NewMessages> {
  final _controller = TextEditingController();
  String _enteredMessage = "";




  _sendMessage() async {
    FocusScope.of(context).unfocus();
    //Add messages by userID
    FirebaseFirestore.instance.collection('chat').doc(instance.currentUser.email).collection('messages').doc(widget.iD)
        .collection('docmess').add({
      'text'  : _enteredMessage ,
      'createdAt'  : Timestamp.now() ,
      'Reciever' : widget.iD,
      'sender' : instance.currentUser.email,
    });
    //Add Messages by doctorID
    FirebaseFirestore.instance.collection('chat').doc(widget.iD).collection('messages').doc(instance.currentUser.email).
    collection('docmess').add({
      'text'  : _enteredMessage ,
      'createdAt'  : Timestamp.now() ,
      'Reciever' : widget.iD,
      'sender' : instance.currentUser.email,
    });
    FirebaseFirestore. instance.collection('UsersChat').doc(widget.iD).collection('Room').doc(instance.currentUser.email)
    .get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
      print('Document exists on the database');
      }else{
        FirebaseFirestore.instance.collection('UsersChat').doc(widget.iD).collection('Room').doc(instance.currentUser.email).set({
          'Email': instance.currentUser.email,
        });
      }
    });

    FirebaseFirestore. instance.collection('UsersChat').doc(instance.currentUser.email).collection('Room').doc(widget.iD)
    .get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document exists on the database');
      }else{
        FirebaseFirestore.instance.collection('UsersChat').doc(instance.currentUser.email).collection('Room').doc(widget.iD).set({
          'Email': widget.iD,
        });
      }
    });

    _controller.clear();
    setState(() {
      _enteredMessage = "";
    });
  }
  @override
  Widget build(BuildContext context) {
    return
      Container(
      margin: EdgeInsets.only(top : 10),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
              child: TextField(
                autocorrect: true,
                enableSuggestions: true,
                textCapitalization: TextCapitalization.sentences,
                controller: _controller,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).primaryColor)
                  ),
                  hintText: 'Send a Message...',
                  hintStyle: TextStyle(color: Theme.of(context).primaryColor),
                ),
                onChanged: (val) {
                  setState(() {
                    _enteredMessage = val;
                  });
                },
              ),
          ),

          IconButton(
              color: Theme.of(context).primaryColor,
              disabledColor: Colors.blueGrey,
              icon: Icon(Icons.send),
              onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage , )
        ],
      ),
    );
  }
}
