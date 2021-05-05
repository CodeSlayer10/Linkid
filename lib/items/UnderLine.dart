import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';


// ignore: must_be_immutable
class UnderLine extends StatefulWidget {
  Function onTap;
  String text;
  String text1;
  UnderLine({Key key, this.text, this.text1, this.onTap}) : super(key: key);
  @override
  _UnderLineState createState() => _UnderLineState();
}

class _UnderLineState extends State<UnderLine> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AutoSizeText(widget.text, minFontSize: 20, maxFontSize: 30, style: TextStyle(color: Colors.white),),
        GestureDetector(
            onTap: widget.onTap,
            child: AutoSizeText(widget.text1, minFontSize: 20, maxFontSize: 30,  style: TextStyle(color: Colors.white, decoration: TextDecoration.underline),)),
      ],
    );
  }
}
