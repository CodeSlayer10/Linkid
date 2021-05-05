import 'dart:ffi';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:linkid/Services/auth.dart';
import 'package:linkid/Services/database.dart';

class InfoPage extends StatefulWidget {
  String pass;
  String email;
  Function toggle1;
  InfoPage({
    Key key,
    this.toggle1,
    this.pass,
    this.email,
  }) : super(key: key);
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  AuthService _auth = AuthService();
  int index1 = 0;
  List<String> texts = <String>["Movie", "TV Show", "Comic"];
  List<bool> selectedZ = <bool>[false, false, false, false, false, false, false];
  List<String> interests = <String>["Computer Science", "History", "Coins", "Science", "Biology", "Pseudoscience", "Other"];
  bool selectedT = false;
  String username = "";
  String genre = "";
  String newI = "";
  String error1 = '';
  String error2 = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff323232),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 5.2, left: MediaQuery.of(context).size.width / 7),
              child: AutoSizeText(error1, style: TextStyle(color: Colors.red), maxLines: 1, maxFontSize: 25, minFontSize: 20),
            ),
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 4.6, left: MediaQuery.of(context).size.width / 7),
              child: AutoSizeText(error2, style: TextStyle(color: Colors.red), maxLines: 1, maxFontSize: 25, minFontSize: 20),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 8, left: MediaQuery.of(context).size.width / 20),
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        widget.toggle1(1);
                      });
                    },
                      child: Container(
                          width: MediaQuery.of(context).size.width / 20,
                          height: MediaQuery.of(context).size.height / 20,
                          child: SvgPicture.asset("assets/Back.svg"))),
                ),
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 8, left: MediaQuery.of(context).size.width / 36),
                  child: AutoSizeText("Personal Info", style: TextStyle(color: Colors.white), maxLines: 2, maxFontSize: 42, minFontSize: 38),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3.8, left: MediaQuery.of(context).size.width / 10),
              child: textFormField("UserName", 0),
            ),
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 2.755, left: MediaQuery.of(context).size.width / 10),
              child: AutoSizeText("Favorite", style: TextStyle(color: Colors.white), maxLines: 1, maxFontSize: 22, minFontSize: 18),
            ),
            Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 2.78, left: MediaQuery.of(context).size.width / 4),
              width: MediaQuery.of(context).size.width / 1.4,
              height: MediaQuery.of(context).size.height / 1,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: texts.length,
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
              child: textFormField("", 1),
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
                  return Fliter(s, interests.indexOf(s),);
                }).toList(),
              ),
            ),
            GestureDetector(
              onTap: () async {
                    var al = await updo(username);
                    if (al == true) {
                    dynamic result = await _auth.Register(widget.email, widget.pass, username, genre, index1, interests, selectedZ);
                    if (result ==  null) {
                      setState(() {
                        error1 = 'Please apply a valid Email';
                      });
                    }
                    } else {
                      setState(() {
                        error2 = 'Username taken';
                      });

                    }

              },
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
                        onTap: (){
                          setState(() {
                              interests.add(newI);
                              selectedZ.add(true);
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
        ),
      ),
    );
  }
  Widget textFormField(String text, int iz){
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 80, left: MediaQuery.of(context).size.width / 50),
      width: MediaQuery.of(context).size.width / 1.5,
      height: MediaQuery.of(context).size.height / 17,
      decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xffc4c4c4).withOpacity(0.4), width: 5),
      ),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        // validator: one1 == 1 ? (val) => val.isEmpty ? 'Enter Email' : null : (val) => val.isEmpty ? 'Enter Password' : null,
        decoration: InputDecoration(
          // labelText: one1 == 1 ? error1.isEmpty ? "Email" : error1 : error1.isEmpty ? "Password" : error1,
          border: InputBorder.none,
          hintStyle: TextStyle(color: Colors.white),
          hintText: text,
        ),
        onChanged: (val){
          if (iz == 0) {
            username = val;
          } else {
            genre = val;
          }
        },
      ),
    );
  }
  Widget Fliter(String chipName, int index) {
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



