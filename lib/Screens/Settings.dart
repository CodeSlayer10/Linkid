import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:linkid/Services/auth.dart';
import 'package:linkid/Services/database.dart';
import 'package:linkid/models/user.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {

  Settings({
    Key key,
  }) : super(key: key);
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  AuthService _auth = AuthService();
  int index1 = 0;
  // List<bool> selectedZ = <bool>[false, false, false, false, false, false, false];
  // List<String> interests = <String>["Computer Science", "History", "Coins", "Science", "Biology", "Ancient Astronaut Theory", "Other"];
  List<String> texts = <String>["Movie", "TV Show", "Comic"];
  final userRef = Firestore.instance.collection("Names");
  List<String> interests = <String>[];
  List<bool> indexZ2 = <bool>[];
  String _currentName = '';
  String genreR = '';
  String error = '';
  bool selectedT = false;
  String newI = '';
  @override

  Widget build(BuildContext context) {
    // ignore: unnecessary_statements
    User user5 = Provider.of<User>(context);
    List snapL = [];
    return Scaffold(
      backgroundColor: Color(0xff323232),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 4.7, left: MediaQuery.of(context).size.width / 7),
              child: AutoSizeText(error, style: TextStyle(color: Colors.red), maxLines: 1, maxFontSize: 25, minFontSize: 20),
            ),
            StreamBuilder<UserData>(
              stream: DataBaseService(uid: user5 != null ? user5.uid : "hello").userData,
                builder: (context, snapshot){
                  if(snapshot.hasData) {
                    User user5 = Provider.of<User>(context);
                    String uid = user5.uid;
                    UserData userData = snapshot.data;
                    List selectedZ = userData.indexZ;
                    int index2 = userData.index;
                    String genre = userData.genre;
                    String name = userData.name;

                    snapL = userData.interests;
                    snapL.forEach((element) {
                      if(!interests.contains(element))
                      {

                        interests.add(element);

                      }
                    });
                    // print(interests);
                    selectedZ.forEach((element1) {
                      indexZ2.add(element1);
                    });

                    // print("$selectedZ hello");
                    return Stack(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            var al = await updo(_currentName);
                            setState(() {
                              if (_currentName.length != 0)
                              {
                                if (al == true)
                                {
                                  indexZ2 = indexZ2.sublist(0, interests.length);
                                  CollectionReference collection = Firestore
                                      .instance
                                      .collection("Names");
                                  collection.document(uid).updateData({
                                    'indexZ': indexZ2,
                                    'index': index1,
                                    'interests': interests,
                                    'genre': genreR.length == 0 ? genre : genreR,
                                    'name': _currentName.length == 0
                                        ? name
                                        : _currentName,
                                  });
                                } else
                                {
                                  error = "Name Taken";
                                }
                              } else {
                                CollectionReference collection = Firestore
                                    .instance
                                    .collection("Names");
                                collection.document(uid).updateData({
                                  'indexZ': indexZ2,
                                  'index': index1,
                                  'interests': interests,
                                  'genre': genreR.length == 0 ? genre : genreR,
                                  'name': _currentName.length == 0
                                      ? name
                                      : _currentName,
                                });
                              }
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 10, left: MediaQuery.of(context).size.width / 10),
                            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 600, left: MediaQuery.of(context).size.width / 25),
                            width: MediaQuery.of(context).size.width / 5,
                            height: MediaQuery.of(context).size.height / 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Color(0xffEB6B56),
                            ),
                            child: AutoSizeText("Save", style: TextStyle(color: Colors.white), maxLines: 1, maxFontSize: 25, minFontSize: 20,),
                          ),
                        ),
                        Row(
                          children: [

                            Padding(
                              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 8, left: MediaQuery.of(context).size.width / 10),
                              child: AutoSizeText("Personal Info", style: TextStyle(color: Colors.white), maxLines: 2, maxFontSize: 42, minFontSize: 38),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 8, left: MediaQuery.of(context).size.width / 20),
                              child: GestureDetector(
                                  onTap: () async {
                                    await _auth.signOut();
                                  },
                                  child: Container(
                                      width: MediaQuery.of(context).size.width / 10,
                                      height: MediaQuery.of(context).size.height / 10,
                                      child: SvgPicture.asset("assets/SignOut.svg"))),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3.8, left: MediaQuery.of(context).size.width / 10),
                          child: textFormField("UserName", genre, false, name),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 2.755, left: MediaQuery.of(context).size.width / 10),
                          child: AutoSizeText("Favorite", style: TextStyle(color: Colors.white), maxLines: 1, maxFontSize: 22, minFontSize: 18),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 2.78, left: MediaQuery.of(context).size.width / 4),
                          width: MediaQuery.of(context).size.width / 1.4,
                          height: MediaQuery.of(context).size.height / 1,
                          child:ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 3,
                                  itemBuilder: (context, int index){
                                    return Stack(
                                      children: [
                                        GestureDetector(
                                          child: Container(
                                            margin: EdgeInsets.only(left: MediaQuery.of(context).size.width / 18),
                                            padding: EdgeInsets.only(left: index == 1 ? MediaQuery.of(context).size.width / 42 : MediaQuery.of(context).size.width / 24, top: MediaQuery.of(context).size.height / 140),
                                            width: MediaQuery.of(context).size.width / 5.5,
                                            height: MediaQuery.of(context).size.height / 30,
                                            decoration: BoxDecoration(
                                              color: Color(index1 == index ? 0xff95B8D1 : 0xffc4c4c4).withOpacity(0.4),
                                              borderRadius: BorderRadius.circular(30),
                                            ),
                                            child: AutoSizeText(texts[index], style: TextStyle(color: Colors.white), maxLines: 1, minFontSize: 14, maxFontSize: 16),
                                          ),
                                          onTap: (){
                                            setState(() {
                                              index1 = index;
                                            });
                                          },
                                        ),
                                      ],
                                    );
                                  }),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 2.45, left: MediaQuery.of(context).size.width / 10),
                          child: textFormField("", genre, true, name),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 2, left: MediaQuery.of(context).size.width / 10),
                          child: AutoSizeText("Areas of Interest", style: TextStyle(color: Colors.white), maxLines: 1, maxFontSize: 22, minFontSize: 18,),
                        ),

                        Container(
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 1.85, left: MediaQuery.of(context).size.width / 10),
                          width: MediaQuery.of(context).size.width / 1,
                          height: MediaQuery.of(context).size.height / 1,
                            child: Wrap(
                                spacing: 5,
                                runSpacing: 0,
                                children: interests.map((s) {
                                  return Fliter(s, snapL.indexOf(s), userData, uid, indexZ2);
                                }).toList(),
                              ),


                        ),
                        GestureDetector(
                          child: Container(
                            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 1.2, left: MediaQuery.of(context).size.width / 10),
                            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 200, left: MediaQuery.of(context).size.width / 30),
                            width: MediaQuery.of(context).size.width / 2.5,
                            height: MediaQuery.of(context).size.height / 16,
                            decoration: BoxDecoration(
                                color: Color(0xffc4c4c4).withOpacity(0.4),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: AutoSizeText("SignUp", style: TextStyle(color: Colors.white), maxLines: 1, maxFontSize: 36, minFontSize: 34,),
                          ),
                        ),
                        if(selectedT)
                          Container(
                            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 40),
                            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 5, left: MediaQuery.of(context).size.width / 4.6),
                            width: MediaQuery.of(context).size.width / 1.8,
                            height: MediaQuery.of(context).size.height / 5,
                            decoration: BoxDecoration(
                                color: Color(0xff5A6872),
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: TextFormField(
                              maxLines: 6,
                              style: TextStyle(color: Colors.white),
                              // validator: one1 == 1 ? (val) => val.isEmpty ? 'Enter Email' : null : (val) => val.isEmpty ? 'Enter Password' : null,
                              decoration: InputDecoration(
                                // labelText: one1 == 1 ? error1.isEmpty ? "Email" : error1 : error1.isEmpty ? "Password" : error1,
                                border: InputBorder.none,
                                hintStyle: TextStyle(color: Colors.white),
                                hintText: "Enter Interest...",

                                suffixIcon: Padding(
                                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 6.3),

                                  child: GestureDetector(
                                      onTap: () async {
                                        interests.add(newI);
                                        await DataBaseService(uid: uid).addI(interests);
                                        setState(() {
                                          selectedT = !selectedT;
                                        });
                                      },
                                      child: SvgPicture.asset("assets/Send.svg")),
                                ),
                              ),
                              onChanged: (val) {
                                newI = val;
                              },
                            ),
                          ),
                      ],
                    );
                  } else {
                    return Container();
                  }
                }),
          ],
        ),
      ),
    );
  }
  Widget textFormField(String text, String genre, bool one, String name){
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 80, left: MediaQuery.of(context).size.width / 50),
      width: MediaQuery.of(context).size.width / 1.5,
      height: MediaQuery.of(context).size.height / 17,
      decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xffc4c4c4).withOpacity(0.4), width: 5),
      ),
      child: TextFormField(

        initialValue: one ? genre : name,
        style: TextStyle(color: Colors.white),
        // validator: one1 == 1 ? (val) => val.isEmpty ? 'Enter Email' : null : (val) => val.isEmpty ? 'Enter Password' : null,
        decoration: InputDecoration(
          // enabled: one,
          // labelText: one1 == 1 ? error1.isEmpty ? "Email" : error1 : error1.isEmpty ? "Password" : error1,
          border: InputBorder.none,
          hintStyle: TextStyle(color: Colors.white),
          hintText: text,
        ),
        onChanged: (val){
          // print(one);
          setState(() {
            if (one) {
              genreR = val;
               // print(genreR);
            } else {
              _currentName = val;
              // print(_currentName);
            }
          });
        },
      ),
    );
  }
  Widget Fliter(String chipName, int index, UserData snapshot, String uid, List selectedZ) {
    return FilterChip(
        checkmarkColor: Colors.white,
        label: Text(chipName),
        labelStyle: TextStyle(color: Colors.white,fontSize: 16.0,fontWeight: FontWeight.bold),
        selected: selectedZ[index],
        shape:RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0)),
        backgroundColor: Color(0xff6c6c6c),
        onSelected: (isSelected) {
          setState(() {
            selectedZ[index] = isSelected;
            if (chipName == "Other") {
              selectedT = !selectedT;
            }
          });
        },
        selectedColor: Color(0xff5A6872));
  }
}

