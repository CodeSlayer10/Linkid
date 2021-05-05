import 'dart:developer';
import 'dart:ffi';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:linkid/Services/database.dart';
import 'package:linkid/items/Interest.dart';
import 'package:linkid/models/user.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class MessagePage extends StatefulWidget {
  String text;
  String groupId;
  String interestId;
  MessagePage({
    Key key,
    this.text,
    this.groupId,
    this.interestId
  }) : super(key: key);
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  String message = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff323232),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            StreamBuilder(
              stream: DataBaseService().getChats(widget.interestId, widget.groupId),
              builder: (context, snapshot){
                if (snapshot.hasData) {
                  User user5 = Provider.of<User>(context);
                  return StreamBuilder<UserData>(
                    stream: DataBaseService(uid: user5.uid).userData,
                    builder: (context, snapshot1) {
                      if (snapshot1.hasData)
                      {
                        UserData userData = snapshot1.data;
                        String name = userData.name;
                        String senderID = userData.senderID;
                        return Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: MediaQuery
                                  .of(context)
                                  .size
                                  .height / 9),
                              child: ListView.builder(
                                  itemCount: snapshot.data.documents.length,
                                  itemBuilder: (context, int index) {
                                    var id = snapshot.data.documents[index];
                                    var message = id["message"];

                                    var sender = id["sender"];
                                    // var message = "hello";
                                    return Stack(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: 10),
                                          child: GestureDetector(
                                            child: Bubble(
                                              alignment: sender == senderID
                                                  ? Alignment.topRight
                                                  : Alignment.topLeft,
                                              nip: sender == senderID
                                                  ? BubbleNip.rightBottom
                                                  : BubbleNip.leftBottom,
                                              nipRadius: 4,
                                              color: sender == senderID
                                                  ? Color(0xff29B18D).withOpacity(
                                                  0.7)
                                                  : Color(0xffACB8CB).withOpacity(
                                                  0.8),
                                              child: sender == senderID
                                                  ? AutoSizeText(message)
                                                  : Stack(
                                                children: [
                                                  AutoSizeText(name),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 20),
                                                    child: AutoSizeText(message),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            onLongPress: (){
                                              if (sender == senderID) {
                                                Firestore.instance.collection("Interests").document(widget.interestId).collection("Groups").document(widget.groupId).collection("Messages").document(id.documentID).delete();
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                            ),
                            Container(
                              width: double.infinity,
                              color: Color(0xff323232),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: MediaQuery
                                        .of(context)
                                        .size
                                        .height / 10, left: MediaQuery
                                        .of(context)
                                        .size
                                        .width / 20),
                                    child: GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                            width: MediaQuery
                                                .of(context)
                                                .size
                                                .width / 20,
                                            height: MediaQuery
                                                .of(context)
                                                .size
                                                .height / 20,
                                            child: SvgPicture.asset(
                                                "assets/Back.svg"))),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: MediaQuery
                                        .of(context)
                                        .size
                                        .height / 10, left: MediaQuery
                                        .of(context)
                                        .size
                                        .width / 30),
                                    child: AutoSizeText(widget.text,
                                        style: TextStyle(color: Colors.white),
                                        maxLines: 1,
                                        maxFontSize: 42,
                                        minFontSize: 27),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: MediaQuery
                                  .of(context)
                                  .size
                                  .height / 1.1),
                              width: double.infinity,
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height / 10,
                              color: Color(0xff323232),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: MediaQuery
                                  .of(context)
                                  .size
                                  .height / 1.1, left: MediaQuery
                                  .of(context)
                                  .size
                                  .width / 25),
                              // width: MediaQuery.of(context).size.width / 1,
                              color: Color(0xff323232),
                              child: Container(
                                padding: EdgeInsets.only(left: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 50),
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 1.1,
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height / 15,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Color(0xffc4c4c4).withOpacity(0.4),
                                      width: 5),
                                ),
                                child: TextFormField(

                                  style: TextStyle(color: Colors.white),
                                  // validator: one1 == 1 ? (val) => val.isEmpty ? 'Enter Email' : null : (val) => val.isEmpty ? 'Enter Password' : null,
                                  decoration: InputDecoration(
                                    suffixIcon: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            // print(user5.name);
                                            _sendMessage(name);
                                          });
                                        },
                                        child: SvgPicture.asset(
                                            "assets/Send.svg")),
                                    // labelText: one1 == 1 ? error1.isEmpty ? "Email" : error1 : error1.isEmpty ? "Password" : error1,
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(color: Colors.white),
                                    hintText: "Enter Message",
                                  ),
                                  onChanged: (val) {
                                    message = val;
                                  },
                                  initialValue: message,
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Container();

                      }
                    },

                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
  _sendMessage(String name) {
    if (message.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "message": message,
        "sender": name,
        "time": DateTime.now().millisecondsSinceEpoch,
      };

      DataBaseService().sendMessage(widget.interestId, widget.groupId, chatMessageMap);
      setState(() {
        message = "";
      });
    }
  }

}
