import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:linkid/LoSi/Info.dart';
import 'package:linkid/Services/auth.dart';
import 'package:linkid/items/UnderLine.dart';


class SignUp extends StatefulWidget {
  Function toggle;
  Function p;
  Function e;
  SignUp(this.toggle, this.p, this.e);


  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  // AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String pass2 = '';
  String pass = '';
  String error = '';
  String error1 = '';
  String error2 = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff323232),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 2.6, left: MediaQuery.of(context).size.width / 7),
                child: AutoSizeText(error, style: TextStyle(color: Colors.red), maxLines: 1, maxFontSize: 25, minFontSize: 20),
              ),
              Row(
                children: [
                  Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 12, left: MediaQuery.of(context).size.width / 13),
                      width: MediaQuery.of(context).size.width / 5,
                      height: MediaQuery.of(context).size.height / 5,
                      child: SvgPicture.asset("assets/icon.svg")),
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 12, left: MediaQuery.of(context).size.width / 30),
                    child: AutoSizeText("Linkid", style: TextStyle(color: Colors.white), maxLines: 1, maxFontSize: 45, minFontSize: 42,),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3.7, left: MediaQuery.of(context).size.width / 8),
                child: AutoSizeText("Welcome! \ncreate your account.", style: TextStyle(color: Colors.white), maxLines: 2, maxFontSize: 32, minFontSize: 30),
              ),

              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 2.2, left: MediaQuery.of(context).size.width / 7),
                child: textFormField("Email", 0, false),
              ),
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 1.75, left: MediaQuery.of(context).size.width / 7),
                child: textFormField("Password", 1, true),
              ),
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 1.45, left: MediaQuery.of(context).size.width / 7),
                child: textFormField("Re-enter Password", 2, true),
              ),
              GestureDetector(
                onTap: () {
                  // if (_formKey.currentState.validate()) {
                  //   if (pass == pass2) {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(builder: (context) => Info(
                  //         email: email,
                  //         pass: pass,
                  //       )),
                  //     );
                  //   }
                  // }
                  setState(() {
                    if (_formKey.currentState.validate())
                    {
                    if (pass == pass2)
                    {
                      widget.toggle(-1);
                    } else {
                      error = "passwords don't match";
                    }
                    }
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 1.23, left: MediaQuery.of(context).size.width / 7.1),
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 200, left: MediaQuery.of(context).size.width / 30),
                  width: MediaQuery.of(context).size.width / 2.5,
                  height: MediaQuery.of(context).size.height / 16,
                  decoration: BoxDecoration(
                      color: Color(0xffc4c4c4).withOpacity(0.4),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: AutoSizeText("Next", style: TextStyle(color: Colors.white), maxLines: 1, maxFontSize: 36, minFontSize: 34,),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 1.1, left: MediaQuery.of(context).size.width / 7),
                child: UnderLine(
                  text: "have an account?",
                  text1: "Login",
                  onTap: (){widget.toggle(0);},
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget textFormField(String text, int num, bool one){
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 80, left: MediaQuery.of(context).size.width / 50),
      width: MediaQuery.of(context).size.width / 1.5,
      height: MediaQuery.of(context).size.height / 17,
      decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xffc4c4c4).withOpacity(0.4), width: 5),
      ),
      child: TextFormField(
        obscureText: one,
        validator: num == 0 ? (val) => val.isEmpty ? 'Enter Email' : null : (val) => val.length < 6 ? 'Enter A password 6 + chars long' : null,
        style: TextStyle(color: Colors.white),
        // validator: one1 == 1 ? (val) => val.isEmpty ? 'Enter Email' : null : (val) => val.isEmpty ? 'Enter Password' : null,
        decoration: InputDecoration(
          // labelText: one1 == 1 ? error1.isEmpty ? "Email" : error1 : error1.isEmpty ? "Password" : error1,
          border: InputBorder.none,
          hintStyle: TextStyle(color: Colors.white),
          hintText: text,
        ),
        onChanged: (val){
          if (num == 0) {
            widget.e(val);
          }
          if (num == 1) {
            pass = val;
            widget.p(val);
          }
          if (num == 2) {
            pass2 = val;
          }
        },
      ),
    );
  }
}

