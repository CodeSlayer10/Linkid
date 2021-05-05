import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:linkid/LoSi/Info.dart';
import 'package:linkid/Screens/Interest_List.dart';
import 'package:linkid/Screens/Settings.dart';
import 'package:linkid/items/navbar.dart';
import 'package:linkid/models/user.dart';
import 'package:provider/provider.dart';






class Pagez extends StatefulWidget {
  @override
  _PagezState createState() => _PagezState();
}

class _PagezState extends State<Pagez> {
  int _index = 0;
  bool selected = false;


  @override
  Widget build(BuildContext context) {



    List indexList = [
      InterestList(),
      Settings()
    ];
    return Scaffold(
      bottomSheet: CustomBottomNavigation(
        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 2, top: MediaQuery.of(context).size.height / 13.2),
        radius: BorderRadius.only(topLeft: Radius.circular(10)),
        width: MediaQuery.of(context).size.width / 2,
        height: MediaQuery.of(context).size.height / 11,
        backgroundColor: Color(0xff4F4F4F),
        items: [
          NavItem(
            selected: selected,
            icon: "assets/IconzC.svg",
            icon2: "assets/Iconz.svg",
            onTap: (){
              setState(() {
                selected = !selected;
                _index = 0;
              });
            },
          ),
          NavItem(
            selected: selected,
            icon: "assets/iconz2C.svg",
            icon2: "assets/iconz2.svg",
            onTap: (){
              setState(() {
                selected = !selected;
                _index = 1;
              });
            },
          ),
        ],
      ),
      body: indexList.elementAt(_index),
    );
  }
}
