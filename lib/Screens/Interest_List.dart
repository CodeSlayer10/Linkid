import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:linkid/Screens/InterestPage.dart';
import 'package:linkid/items/Interest.dart';

class InterestList extends StatefulWidget {

  InterestList({
    Key key,
  }) : super(key: key);
  @override
  _InterestListState createState() => _InterestListState();
}

class _InterestListState extends State<InterestList> {
  List<String> interests = <String>["History", "Computer Science", "Philosophy", "Coins", "Science", "Ancient Astronaut Theory"];
  List<int> colors = <int>[0xff84FCB4, 0xff63CCCA, 0xffF67CBB, 0xff0FFFF5, 0xffE4C1F9, 0xffD0F4DE];
  bool selected = false;
  bool selected2 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff323232),
      body: Stack(
        children: [
          StreamBuilder(
              stream: Firestore.instance. collection("Interests").snapshots(),
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
                          var interest = id["Name"];
                          var color = id["Color"];
                          var docid = id.documentID;
                          return Stack(
                            children: [
                              GestureDetector(
                                child: Interest(
                                  color: color,
                                  text: interest,
                                ),
                                onTap: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => InterestPage(
                                      color: color,
                                      text: interest,
                                      docid: docid,
                                    )),
                                  );
                                },
                              )
                            ],
                          );
                        }),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 10, left: MediaQuery.of(context).size.width / 30),
                    width: double.infinity,
                    color: Color(0xff323232),
                    // height: MediaQuery.of(context).size.width,
                    child: AutoSizeText("Interest List", style: TextStyle(color: Colors.white), maxLines: 1, maxFontSize: 42, minFontSize: 38),
                  ),
              ],
            );
          } else {
                return Container();
              }
            }
          ),
        ],
      ),
    );
  }
}
