import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Interest extends StatefulWidget {
  int color;
  String text;
  Interest({
    Key key,
    this.text,
    this.color,
  }) : super(key: key);
  @override
  _InterestState createState() => _InterestState();
}

class _InterestState extends State<Interest> {
  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 30, left: MediaQuery.of(context).size.width / 50),
          width: MediaQuery.of(context).size.width / 7,
          height: MediaQuery.of(context).size.width / 7,
          decoration: BoxDecoration(
            color: Color(widget.color).withOpacity(1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white, width: 5),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 30, left: MediaQuery.of(context).size.width / 45),
          child: AutoSizeText(widget.text, style: TextStyle(color: Colors.white), maxLines: 1, maxFontSize: 32, minFontSize: 25,),
        ),
      ],
    );
  }
}
