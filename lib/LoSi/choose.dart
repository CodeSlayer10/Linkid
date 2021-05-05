import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:linkid/LoSi/Info.dart';
import 'package:linkid/LoSi/Login.dart';
import 'package:linkid/LoSi/SignUp.dart';




class Choose extends StatefulWidget {
  @override
  _ChooseState createState() => _ChooseState();
}

class _ChooseState extends State<Choose> {
  int show = 2;
  void toggleView(int num) {
    setState(() {
      show = num;
    });
  }
  String email1 = "";
  String pass1 = "";
  void Pass(String pass) {
    setState(() {
      pass1 = pass;
    });
  }
  void Email(String email) {
    setState(() {
      email1 = email;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (show == -1) {
      return InfoPage(email: email1, pass: pass1, toggle1: toggleView);
    }
    if (show == 0)
    {
      return Login(toggleView);
    }
    if (show == 1)
    {
      return SignUp(toggleView, Pass, Email);
    }
    if (show == 2) {
      return Scaffold(
        backgroundColor: Color(0xff323232),
        body: Stack(
          children: [
            Container(
                margin: EdgeInsets.only(top: MediaQuery
                    .of(context)
                    .size
                    .height / 22, left: MediaQuery
                    .of(context)
                    .size
                    .width / 4.6),
                width: MediaQuery
                    .of(context)
                    .size
                    .width / 2,
                height: MediaQuery
                    .of(context)
                    .size
                    .height / 2,
                child: SvgPicture.asset("assets/iconBwhite.svg")),
            Padding(
              padding: EdgeInsets.only(top: MediaQuery
                  .of(context)
                  .size
                  .height / 4.25, left: MediaQuery
                  .of(context)
                  .size
                  .width / 3.1),
              child: AutoSizeText(
                "Linkid", style: TextStyle(color: Colors.white),
                maxLines: 1,
                maxFontSize: 46,
                minFontSize: 44,),
            ),
            Padding(
              padding: EdgeInsets.only(top: MediaQuery
                  .of(context).size.height / 2.2, left: MediaQuery
                  .of(context).size.width / 6),
              child: AutoSizeText("Connect With \nlike minded kids.",
                  style: TextStyle(color: Colors.white),
                  maxLines: 2,
                  maxFontSize: 40,
                  minFontSize: 36),
            ),
            Padding(
              padding: EdgeInsets.only(top: MediaQuery
                  .of(context).size.height / 1.7, left: MediaQuery
                  .of(context).size.width / 6),
              child: AutoSizeText(
                  "find other kids interested in \nComputer science, History, \nCoins and so much more!",
                  style: TextStyle(color: Color(0xffc4c4c4).withOpacity(0.8)),
                  maxLines: 3,
                  maxFontSize: 24,
                  minFontSize: 19),
            ),
            GestureDetector(
              onTap: (){
                setState(() {
                  toggleView(1);
                });
              },
              child: Container(
                margin: EdgeInsets.only(top: MediaQuery
                    .of(context).size.height / 1.18, left: MediaQuery
                    .of(context).size.width / 7.5),
                padding: EdgeInsets.only(top: MediaQuery
                    .of(context).size.height / 80, left: MediaQuery
                    .of(context).size.width / 2.5),
                width: MediaQuery
                    .of(context).size.width / 1.35,
                height: MediaQuery
                    .of(context).size.height / 13,
                decoration: BoxDecoration(
                    color: Color(0xffc4c4c4).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: AutoSizeText(
                    "Signup", style: TextStyle(color: Colors.white),
                    maxLines: 1,
                    maxFontSize: 36,
                    minFontSize: 33),
              ),
            ),
            GestureDetector(
              onTap: (){
                setState(() {
                  toggleView(0);
                });
              },
              child: Container(
                margin: EdgeInsets.only(top: MediaQuery
                    .of(context).size.height / 1.18, left: MediaQuery
                    .of(context).size.width / 7.5),
                padding: EdgeInsets.only(top: MediaQuery
                    .of(context).size.height / 80, left: MediaQuery
                    .of(context).size.width / 20),
                width: MediaQuery
                    .of(context).size.width / 2.8,
                height: MediaQuery
                    .of(context).size.height / 13,
                decoration: BoxDecoration(
                    color: Color(0xffc4c4c4).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: AutoSizeText(
                    "Login", style: TextStyle(color: Colors.white),
                    maxLines: 1,
                    maxFontSize: 36,
                    minFontSize: 33),
              ),
            ),
          ],
        ),
      );
    }
  }
}
