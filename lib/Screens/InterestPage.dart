import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:linkid/Screens/MessagePage.dart';
import 'package:linkid/Services/database.dart';
import 'package:linkid/items/Interest.dart';
import 'package:linkid/models/user.dart';
import 'package:provider/provider.dart';

class InterestPage extends StatefulWidget {
  int color;
  String text;
  String docid;
  InterestPage({
    Key key,
    this.text,
    this.color,
    this.docid,
  }) : super(key: key);
  @override
  _InterestPageState createState() => _InterestPageState();
}

class _InterestPageState extends State<InterestPage> {
  bool selected = false;
  bool selected2 = false;
  var docid;
  String groupN = "";
  @override
  Widget build(BuildContext context) {

    User user = Provider.of<User>(context);
    // List<String> interests = <String>["History", "Computer Science", "Philosophy", "Coins", "Science", "Ancient Astronaut Theory"];
    return Scaffold(
      backgroundColor: Color(0xff323232),
      body: Stack(
        children: [
          StreamBuilder(
              stream: Firestore.instance.collection("Interests").document(widget.docid).collection("Groups").snapshots(),
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                  return Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 10),
                        child: ListView.builder(
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (context, int index){
                              var id = snapshot.data.documents[index];
                              var group = id["Group"];
                              var creator = id["creator"];
                              docid = id.documentID;
                              return Stack(
                                children: [
                                  GestureDetector(
                                    child: Interest(
                                      color: widget.color,
                                      text: group,
                                    ),
                                    onTap: (){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => MessagePage(
                                          text: group,
                                          interestId: widget.docid,
                                          groupId: id.documentID,
                                        )),
                                      );
                                    },
                                    onLongPress: () async {
                                     if (await updoz(user.uid) == creator)
                                     {
                                       Firestore.instance.collection("Interests").document(widget.docid).collection("Groups").document(docid).delete();
                                     }
                                    },
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
                            Container(
                              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 10, left: MediaQuery.of(context).size.width / 20),
                              child: GestureDetector(
                                  onTap: (){
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                      width: MediaQuery.of(context).size.width / 20,
                                      height: MediaQuery.of(context).size.height / 20,
                                      child: SvgPicture.asset("assets/Back.svg"))),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 10, left: MediaQuery.of(context).size.width / 30),
                              child: AutoSizeText(widget.text, style: TextStyle(color: Colors.white), maxLines: 1, maxFontSize: 42, minFontSize: 27),
                            ),

                          ],
                        ),
                      ),
                      GestureDetector(
                          onTap: (){
                            setState(() {
                              selected2 = !selected2;
                            });
                          },
                          child: Container(
                              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 1.15, left: MediaQuery.of(context).size.width / 1.4),
                              width: MediaQuery.of(context).size.width / 10,
                              height: MediaQuery.of(context).size.height / 10,
                              child: SvgPicture.asset("assets/Plus.svg"))),
                      if(selected2)
                        Container(
                          // padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 40),
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 5, left: MediaQuery.of(context).size.width / 6),
                          width: MediaQuery.of(context).size.width / 1.6,
                          height: MediaQuery.of(context).size.height / 6,
                          decoration: BoxDecoration(
                              color: Color(0xff5A6872),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 40),
                                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/ 60),
                                width: MediaQuery.of(context).size.width / 1.8,
                                height: MediaQuery.of(context).size.height / 10,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Color(0xffc4c4c4).withOpacity(0.4), width: 5),
                                ),
                                child: TextFormField(
                                  maxLength: 25,
                                  maxLines: 2,
                                  style: TextStyle(color: Colors.white),
                                  // validator: one1 == 1 ? (val) => val.isEmpty ? 'Enter Email' : null : (val) => val.isEmpty ? 'Enter Password' : null,
                                  decoration: InputDecoration(
                                    counterStyle: TextStyle(color: Colors.white),
                                    contentPadding: EdgeInsets.only(right: MediaQuery.of(context).size.width / 30),
                                    // labelText: one1 == 1 ? error1.isEmpty ? "Email" : error1 : error1.isEmpty ? "Password" : error1,
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(color: Colors.white),
                                    hintText: "Enter Group Name...",
                                  ),
                                  onChanged: (val) {
                                    groupN = val;
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: MediaQuery.of(context).size.width / 2),
                                child: GestureDetector(
                                    onTap:  () async {
                                      await DataBaseService(uid: user.uid).createGroup(groupN, widget.docid, await updoz(user.uid));
                                      setState(() {
                                        selected2 = !selected2;
                                      });
                                    },
                                    child: SvgPicture.asset("assets/Send.svg")),
                              ),
                            ],
                          ),
                        ),
                    ],
                  );
                } else {
                  return Container(

                  );
                }
          }),
        ],
      ),
    );
  }
}
